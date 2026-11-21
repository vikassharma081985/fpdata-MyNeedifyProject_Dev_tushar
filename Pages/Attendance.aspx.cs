using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class Attendance : Page
    {
        private static readonly IDictionary<string, string> Views = new Dictionary<string, string>
        {
            { "records", "Records" }, { "settings", "Settings" }, { "employees", "Employees" },
            { "corrections", "Corrections" }, { "exports", "Exports" }, { "evidence", "Photos" },
            { "locations", "Locations" }, { "audit", "Audit" }, { "calendar", "Calendar" }
        };
        private readonly Dictionary<string, TextBox> fields = new Dictionary<string, TextBox>();
        private readonly Dictionary<string, CheckBox> switches = new Dictionary<string, CheckBox>();
        private Control formTarget;
        private DropDownList timeZones;
        private long correctionId;
        private int orgId;
        private int sessionOrgId;
        private bool superAdmin;
        private long sessionUser;
        private long employeeId;
        private long actor;
        private string view;
        private string accessMessage = "Web attendance requires an active MyNeedify Admin (role 1) or Super Admin (role 5) account in this organization.";

        protected override void OnInit(EventArgs e)
        {
            ViewStateUserKey = Session.SessionID;
            base.OnInit(e);
            view = Request.QueryString["view"] ?? "records";
            if (!Views.ContainsKey(view) || !int.TryParse(Convert.ToString(Session["OrgId"]), out sessionOrgId) ||
                !long.TryParse(Convert.ToString(Session["UserId"]), out sessionUser))
            {
                Response.StatusCode = 403;
                Response.TrySkipIisCustomErrors = true;
                return;
            }
            orgId = sessionOrgId;
            var requestedOrg = Request.QueryString["orgId"];
            if (requestedOrg != null && (!int.TryParse(requestedOrg, NumberStyles.None, CultureInfo.InvariantCulture, out orgId) || orgId <= 0))
            {
                Response.StatusCode = 400;
                Response.TrySkipIisCustomErrors = true;
                accessMessage = "Choose a valid organization.";
                return;
            }
            long.TryParse(Convert.ToString(Session["EmployeeId"]), out employeeId);
            try
            {
                actor = Authorize();
            }
            catch (SqlException ex) when (ex.Number == 2812)
            {
                accessMessage = "Attendance setup is incomplete. The database administrator needs to apply MyNeedify_Attendance.sql.";
                Response.StatusCode = 503;
                Response.TrySkipIisCustomErrors = true;
                return;
            }
            if (actor == 0)
            {
                Response.StatusCode = 403;
                Response.TrySkipIisCustomErrors = true;
                return;
            }

            if (superAdmin)
                OrganizationSelector();

            var navigation = new Panel { CssClass = "attendance-nav" };
            navigation.Attributes["role"] = "navigation";
            navigation.Attributes["aria-label"] = "Attendance sections";
            foreach (var item in Views)
            {
                var link = new HyperLink
                {
                    Text = item.Value, NavigateUrl = PageUrl(item.Key, SelectedOrganization)
                };
                if (item.Key == view) link.Attributes["aria-current"] = "page";
                navigation.Controls.Add(link);
            }
            AttendanceBody.Controls.Add(navigation);
            Heading(AttendanceBody, "h2", Views[view]);
            formTarget = AttendanceBody;

            switch (view)
            {
                case "settings":
                    SettingsForm();
                    break;
                case "employees":
                    EmployeeRoster();
                    break;
                case "calendar":
                    Section("Holiday or leave");
                    Field("user", "User ID (leave blank for an organization holiday)", mode: TextBoxMode.Number);
                    Field("date", "Work date", mode: TextBoxMode.Date);
                    Field("description", "Description");
                    Toggle("block", "Block check-in on this date", true);
                    EndSection();
                    Button("Save calendar day", () => SaveCalendar(false));
                    Button("Remove calendar day", () => SaveCalendar(true));
                    break;
                case "corrections":
                    CorrectionForm();
                    break;
                case "evidence":
                    Field("session", "Session ID");
                    Button("Open check-in photo", () => ShowPhoto(false));
                    Button("Open check-out photo", () => ShowPhoto(true));
                    break;
                case "locations":
                    Field("session", "Session ID");
                    Button("Show location samples", ShowLocations);
                    break;
                case "exports":
                case "records":
                    DateRangeForm(view == "exports" ? "Download CSV" : "Show records");
                    break;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            if (actor == 0)
            {
                if (!Response.IsRequestBeingRedirected)
                    Notice(accessMessage);
                return;
            }
            if (IsPostBack) return;

            if (view == "records" || (view == "corrections" && correctionId == 0)) Records(false);
            if (view == "settings") LoadPolicy();
 
            if (view == "calendar") ShowCalendar();
            if (view == "audit") Grid(Query(@"SELECT TOP (500) RecordedUtc,ActorUserId,ActionName,TargetId,Details
                FROM dbo.AttendanceAudit WHERE OrgId=@OrgId ORDER BY AuditId DESC"));
        }

        private int? SelectedOrganization => orgId == sessionOrgId ? (int?)null : orgId;

        private static string PageUrl(string name, int? organization = null)
        {
            var query = HttpUtility.ParseQueryString(string.Empty);
            if (name != "records") query["view"] = name;
            if (organization.HasValue) query["orgId"] = organization.Value.ToString(CultureInfo.InvariantCulture);
            return query.Count == 0 ? "Attendance.aspx" : "Attendance.aspx?" + query;
        }

        private void OrganizationSelector()
        {
            var organizations = Query(@"SELECT SellerId,
                COALESCE(NULLIF(DisplayName,''),NULLIF(SellerName,''),CONVERT(nvarchar(20),SellerId)) AS OrganizationName
                FROM dbo.tblOrganizationMaster ORDER BY OrganizationName,SellerId");
            var selector = new DropDownList
            {
                ID = "att_organization",
                CssClass = "form-control",
                DataSource = organizations,
                DataTextField = "OrganizationName",
                DataValueField = "SellerId"
            };
            selector.DataBind();
            selector.SelectedValue = orgId.ToString(CultureInfo.InvariantCulture);
            var picker = new Panel { CssClass = "attendance-card form-inline" };
            var label = new Label { Text = "Organization", AssociatedControlID = selector.ID };
            label.Style["margin-right"] = "8px";
            picker.Controls.Add(label);
            picker.Controls.Add(selector);
            var open = new Button { ID = "att_open_organization", Text = "Open organization", CssClass = "btn btn-default" };
            open.Click += (sender, args) =>
            {
                if (int.TryParse(selector.SelectedValue, NumberStyles.None, CultureInfo.InvariantCulture, out var selected))
                {
                    Response.Redirect(PageUrl(view, selected), false);
                    Context.ApplicationInstance.CompleteRequest();
                }
            };
            open.Style["margin-left"] = "8px";
            picker.Controls.Add(open);
            AttendanceBody.Controls.Add(picker);
        }

        private long Authorize()
        {
            using (var connection = OpenConnection())
                return Authorize(connection, sessionOrgId, sessionUser, employeeId);
        }

        private static SqlConnection OpenConnection()
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["WsBilling"].ConnectionString);
            try
            {
                connection.Open();
                return connection;
            }
            catch
            {
                connection.Dispose();
                throw;
            }
        }

        private long Authorize(SqlConnection connection, int org, long user, long employee)
        {
            using (var cmd = new SqlCommand("dbo.Attendance_WebAuthorize", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@OrgId", org);
                cmd.Parameters.AddWithValue("@SessionUserId", user);
                cmd.Parameters.Add("@EmployeeId", SqlDbType.BigInt).Value = employee > 0 ? (object)employee : DBNull.Value;
                cmd.Parameters.AddWithValue("@TargetOrgId", orgId);
                using (var result = cmd.ExecuteReader())
                {
                    if (!result.Read()) return 0;
                    superAdmin = Convert.ToInt64(result["RoleId"]) == 5;
                    return Convert.ToInt64(result["UserId"]);
                }
            }
        }

        private TextBox Field(string name, string label, string initial = "", TextBoxMode mode = TextBoxMode.SingleLine)
        {
            var input = new TextBox { ID = "att_" + name, ClientIDMode = ClientIDMode.Static,
                CssClass = "form-control", Text = initial, TextMode = mode, MaxLength = 1000 };
            LabeledControl(label, input);
            fields.Add(name, input);
            return input;
        }

        private void LabeledControl(string label, WebControl control)
        {
            var row = new Panel { CssClass = "form-group" };
            row.Controls.Add(new Label { AssociatedControlID = control.ID, Text = label });
            row.Controls.Add(control);
            formTarget.Controls.Add(row);
        }

        private void Toggle(string name, string label, bool initial = false)
        {
            var input = new CheckBox { ID = "att_" + name, Text = label, Checked = initial, CssClass = "attendance-switch" };
            switches.Add(name, input);
            formTarget.Controls.Add(input);
        }

        private void Section(string title)
        {
            var card = new Panel { CssClass = "attendance-card" };
            Heading(card, "h3", title);
            var group = new Panel { CssClass = "attendance-fields" };
            card.Controls.Add(group);
            AttendanceBody.Controls.Add(card);
            formTarget = group;
        }

        private void EndSection() => formTarget = AttendanceBody;

        private static void Heading(Control parent, string tag, string title)
        {
            parent.Controls.Add(new Literal { Text = "<" + tag + ">" + HttpUtility.HtmlEncode(title) + "</" + tag + ">" });
        }

        private void Hint(string message) => AttendanceBody.Controls.Add(new Literal
        {
            Text = "<p class=\"attendance-hint\">" + HttpUtility.HtmlEncode(message) + "</p>"
        });

        private void Button(string label, Action action)
        {
            var button = new Button { ID = "att_button_" + AttendanceBody.Controls.Count, Text = label, CssClass = "btn btn-primary" };
            button.Click += (s, e) => ExecuteAuthorized(action);
            AttendanceBody.Controls.Add(button);
        }

        private void ExecuteAuthorized(Action action)
        {
            if (Authorize() != actor || actor == 0)
            {
                Response.StatusCode = 403;
                Notice("Attendance access is unavailable.");
                return;
            }
            try { action(); }
            catch (FormatException) { Notice("Check the date, numeric and required fields."); }
            catch (OverflowException) { Notice("One of the entered values is outside its supported range."); }
            catch (SqlException ex) when (ex.Number >= 51001 && ex.Number <= 51004) { Notice(ex.Message); }
        }

        private DataTable Query(string sql, Action<SqlCommand> parameters = null)
        {
            using (var con = new SqlConnection(ConfigurationManager.ConnectionStrings["WsBilling"].ConnectionString))
            using (var cmd = new SqlCommand(sql, con))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@OrgId", orgId);
                if (parameters != null) parameters(cmd);
                var rows = new DataTable();
                adapter.Fill(rows);
                return rows;
            }
        }

        private void SettingsForm()
        {
            Section("Attendance and work hours");
            Toggle("enabled", "Enable mobile attendance");
            timeZones = new DropDownList { ID = "att_zone", CssClass = "form-control" };
            foreach (DataRow zone in Query("SELECT name FROM sys.time_zone_info ORDER BY name").Rows)
                timeZones.Items.Add(Convert.ToString(zone[0]));
            if (timeZones.Items.FindByValue("India Standard Time") != null)
                timeZones.SelectedValue = "India Standard Time";
            LabeledControl("Organization time zone", timeZones);
            NumericField("limit", "Maximum sessions per day", "6", "1", "50");
            Field("shiftStart", "Default shift starts", mode: TextBoxMode.Time);
            Field("shiftEnd", "Default shift ends", mode: TextBoxMode.Time);
            NumericField("grace", "Late grace period (minutes)", "10", "0", "1440");
            NumericField("expected", "Expected work time (minutes)", "480", "1", "1440");
            NumericField("half", "Half-day threshold (minutes)", "240", "1", "1440");
            EndSection();

            Section("Location and punch evidence");
            Toggle("gps", "Require GPS at check-in and check-out");
            Toggle("photo", "Require a photo for each punch");
            Toggle("tracking", "Allow location sampling during attendance");
            NumericField("accuracy", "Maximum GPS error (metres)", "50", "0.01", "100000", "0.01");
            NumericField("lat", "Office latitude", "", "-90", "90", "0.000001");
            NumericField("lon", "Office longitude", "", "-180", "180", "0.000001");
            NumericField("radius", "Office radius (metres)", "", "1", int.MaxValue.ToString(CultureInfo.InvariantCulture));
            EndSection();
            AttendanceBody.Controls.Add(new Literal
            {
                Text = "<div class=\"attendance-location-action\"><button type=\"button\" class=\"btn btn-default\" data-attendance-location>Use my location</button>" +
                    "<span id=\"att_location_status\" role=\"status\" aria-live=\"polite\"></span></div>"
            });
            Hint("Enable a geofence by setting both coordinates and a radius. Leave all three fields blank to allow punches from any location, subject to the GPS setting.");
            Button("Save settings", SavePolicy);
        }

        private void NumericField(string name, string label, string initial, string min, string max, string step = "1")
        {
            var input = Field(name, label, initial, TextBoxMode.Number);
            input.Attributes["min"] = min;
            input.Attributes["max"] = max;
            input.Attributes["step"] = step;
        }

        private void DateRangeForm(string buttonLabel)
        {
            var today = DateTime.UtcNow.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            Section("Work date range");
            Field("from", "From", today, TextBoxMode.Date);
            Field("to", "To", today, TextBoxMode.Date);
            EndSection();
            Button(buttonLabel, () => Records(view == "exports"));
        }

        private void CorrectionForm()
        {
            if (!long.TryParse(Request.QueryString["sessionId"], NumberStyles.None, CultureInfo.InvariantCulture, out correctionId) || correctionId <= 0)
            {
                correctionId = 0;
                Hint("Choose Correct on a session below. Change the work date range to find an older session.");
                DateRangeForm("Find sessions");
                return;
            }

            var rows = Query(@"SELECT s.CheckInUtc,s.CheckOutUtc,
                COALESCE(NULLIF(LTRIM(RTRIM(CONCAT(u.FirstName,' ',u.LastName))),''),CONCAT('User ',s.UserId)) AS DisplayName
                FROM dbo.AttendanceSession s LEFT JOIN dbo.tblUser u ON s.UserId=u.UserId AND s.OrgId=u.OrgId
                WHERE s.OrgId=@OrgId AND s.SessionId=@Session", cmd => cmd.Parameters.AddWithValue("@Session", correctionId));
            if (rows.Rows.Count == 0)
            {
                Hint("This session could not be found in the selected organization.");
                AttendanceBody.Controls.Add(new HyperLink { Text = "Find another session", NavigateUrl = PageUrl("corrections", SelectedOrganization) });
                return;
            }
            var session = rows.Rows[0];
            Section(Convert.ToString(session["DisplayName"]) + " · Session " + correctionId.ToString(CultureInfo.InvariantCulture));
            Field("in", "Check-in (UTC)", DateTimeField(session["CheckInUtc"]), TextBoxMode.DateTimeLocal).Attributes["step"] = "1";
            Field("out", "Check-out (UTC, blank if still open)", DateTimeField(session["CheckOutUtc"]), TextBoxMode.DateTimeLocal).Attributes["step"] = "1";
            var reason = Field("reason", "Reason for correction (at least 10 characters)", mode: TextBoxMode.MultiLine);
            reason.Rows = 3;
            reason.Attributes["maxlength"] = "1000";
            EndSection();
            Hint("The fields show the current punch times in UTC. The correction and reason will be saved in Audit.");
            Button("Save correction", Correct);
            AttendanceBody.Controls.Add(new HyperLink { Text = "Find another session", NavigateUrl = PageUrl("corrections", SelectedOrganization), CssClass = "btn btn-default" });
        }

        private static string DateTimeField(object input) => input is DateTime timestamp
            ? timestamp.ToString("yyyy-MM-dd'T'HH:mm:ss", CultureInfo.InvariantCulture) : "";

        private void LoadPolicy()
        {
            var rows = Query(@"SELECT CAST(Enabled AS int) AS enabled,TimeZone AS zone,CAST(GpsRequired AS int) AS gps,
                MaxAccuracy AS accuracy,OfficeLatitude AS lat,OfficeLongitude AS lon,RadiusMetres AS radius,
                CAST(PhotoRequired AS int) AS photo,CAST(TrackingEnabled AS int) AS tracking,MaxSessions AS [limit],
                CONVERT(char(5),ShiftStart,108) AS shiftStart,CONVERT(char(5),ShiftEnd,108) AS shiftEnd,
                GraceMinutes AS grace,ExpectedMinutes AS expected,HalfDayMinutes AS half
                FROM dbo.AttendancePolicy WHERE OrgId=@OrgId");
            if (rows.Rows.Count == 0) return;
            foreach (var field in fields)
                field.Value.Text = Convert.ToString(rows.Rows[0][field.Key], CultureInfo.InvariantCulture);
            foreach (var toggle in switches)
                toggle.Value.Checked = Convert.ToInt32(rows.Rows[0][toggle.Key]) == 1;
            var zone = Convert.ToString(rows.Rows[0]["zone"]);
            if (timeZones.Items.FindByValue(zone) != null) timeZones.SelectedValue = zone;
        }

        private void SavePolicy()
        {
            var latitude = DecimalOrNull("lat");
            var longitude = DecimalOrNull("lon");
            int? radius = Value("radius") == "" ? (int?)null : int.Parse(Value("radius"), CultureInfo.InvariantCulture);
            var accuracy = DecimalOrNull("accuracy");
            var limit = int.Parse(Value("limit"), CultureInfo.InvariantCulture);
            var start = ShiftTime("shiftStart");
            var end = ShiftTime("shiftEnd");
            var grace = int.Parse(Value("grace"), CultureInfo.InvariantCulture);
            var expected = int.Parse(Value("expected"), CultureInfo.InvariantCulture);
            var half = int.Parse(Value("half"), CultureInfo.InvariantCulture);
            if (start.HasValue != end.HasValue || start >= end || grace < 0 || grace > 1440 ||
                expected < 1 || expected > 1440 || half < 1 || half > expected ||
                (start.HasValue && expected > (end.Value - start.Value).TotalMinutes)) throw new FormatException();
            if (latitude.HasValue != longitude.HasValue || latitude.HasValue != radius.HasValue ||
                latitude < -90 || latitude > 90 || longitude < -180 || longitude > 180 || radius <= 0 ||
                !accuracy.HasValue || accuracy < 0.01m || accuracy > 100000 || limit < 1 || limit > 50 ||
                timeZones.SelectedValue.Length > 100) throw new FormatException();
            Query(@"SET XACT_ABORT ON;
                IF NOT EXISTS (SELECT 1 FROM sys.time_zone_info WHERE name=@Zone) THROW 51003,'Unknown SQL Server time zone.',1;
                BEGIN TRAN;
                IF NOT EXISTS (SELECT 1 FROM dbo.AttendancePolicy WITH (UPDLOCK,HOLDLOCK) WHERE OrgId=@OrgId)
                    INSERT dbo.AttendancePolicy(OrgId) VALUES(@OrgId);
                UPDATE dbo.AttendancePolicy SET Enabled=@Enabled,TimeZone=@Zone,GpsRequired=@Gps,MaxAccuracy=@Accuracy,
                    OfficeLatitude=@Lat,OfficeLongitude=@Lon,RadiusMetres=@Radius,PhotoRequired=@Photo,
                    TrackingEnabled=@Tracking,MaxSessions=@Limit,ShiftStart=@Start,ShiftEnd=@End,
                    GraceMinutes=@Grace,ExpectedMinutes=@Expected,HalfDayMinutes=@Half WHERE OrgId=@OrgId;
                INSERT dbo.AttendanceAudit(OrgId,ActorUserId,ActionName,Details)
                VALUES(@OrgId,@Actor,'POLICY_SAVED',CONCAT(@Zone,' enabled=',@Enabled,' GPS=',@Gps,' photo=',@Photo,' tracking=',@Tracking));
                COMMIT;", cmd =>
            {
                cmd.Parameters.AddWithValue("@Actor", actor);
                cmd.Parameters.AddWithValue("@Enabled", Flag("enabled"));
                cmd.Parameters.AddWithValue("@Zone", timeZones.SelectedValue);
                cmd.Parameters.AddWithValue("@Gps", Flag("gps"));
                AddDecimal(cmd, "@Accuracy", accuracy, 2);
                AddDecimal(cmd, "@Lat", latitude, 6);
                AddDecimal(cmd, "@Lon", longitude, 6);
                cmd.Parameters.Add("@Radius", SqlDbType.Int).Value = (object)radius ?? DBNull.Value;
                cmd.Parameters.AddWithValue("@Photo", Flag("photo"));
                cmd.Parameters.AddWithValue("@Tracking", Flag("tracking"));
                cmd.Parameters.AddWithValue("@Limit", limit);
                cmd.Parameters.Add("@Start", SqlDbType.Time).Value = (object)start ?? DBNull.Value;
                cmd.Parameters.Add("@End", SqlDbType.Time).Value = (object)end ?? DBNull.Value;
                cmd.Parameters.AddWithValue("@Grace", grace);
                cmd.Parameters.AddWithValue("@Expected", expected);
                cmd.Parameters.AddWithValue("@Half", half);
            });
            Notice("Settings saved.");
        }

        private void EmployeeRoster()
        {
            var search = (Request.QueryString["q"] ?? "").Trim();
            if (search.Length > 100) search = search.Substring(0, 100);
            Hint("Active users can punch by default when attendance is enabled. Disallowing a user blocks new check-ins. They can still close an open session.");
            Section("Find a user");
            Field("search", "Name, email, or user ID", search).MaxLength = 100;
            EndSection();
            Button("Search", () => RedirectEmployees(Value("search")));

            var rows = Query(@"SELECT TOP (101) u.UserId,
                COALESCE(NULLIF(LTRIM(RTRIM(CONCAT(u.FirstName,' ',u.LastName))),''),u.UserName) AS DisplayName,
                u.Email,COALESCE(e.Enabled,1) AS Allowed
                FROM dbo.tblUser u LEFT JOIN dbo.AttendanceEmployee e ON e.OrgId=u.OrgId AND e.UserId=u.UserId
                WHERE u.OrgId=@OrgId AND u.IsActive=1
                  AND (@Search=N'' OR CHARINDEX(@Search,CONCAT(u.FirstName,' ',u.LastName))>0
                       OR CHARINDEX(@Search,u.Email)>0 OR CONVERT(nvarchar(20),u.UserId)=@Search)
                ORDER BY DisplayName,u.UserId", cmd =>
                cmd.Parameters.Add("@Search", SqlDbType.NVarChar, 100).Value = search);
            if (rows.Rows.Count == 0) { Hint("No active users match your search."); return; }
            if (rows.Rows.Count > 100) Hint("Showing the first 100 users. Use search to find a specific user.");

            var table = new Table { CssClass = "table table-striped" };
            var header = new TableHeaderRow { TableSection = TableRowSection.TableHeader };
            foreach (var label in new[] { "User", "Email", "User ID", "Mobile attendance", "Action" })
                header.Cells.Add(new TableHeaderCell { Text = label, Scope = TableHeaderScope.Column });
            table.Rows.Add(header);
            foreach (DataRow employee in rows.Rows.Cast<DataRow>().Take(100))
            {
                var userId = Convert.ToInt64(employee["UserId"]);
                var allowed = Convert.ToBoolean(employee["Allowed"]);
                var row = new TableRow();
                foreach (var value in new[] { Convert.ToString(employee["DisplayName"]), Convert.ToString(employee["Email"]),
                    userId.ToString(CultureInfo.InvariantCulture), allowed ? "Allowed" : "Disallowed" })
                    row.Cells.Add(new TableCell { Text = HttpUtility.HtmlEncode(value) });
                var action = new TableCell();
                var change = new Button { ID = "att_access_" + userId + (allowed ? "_disallow" : "_allow"),
                    Text = allowed ? "Disallow" : "Allow", CssClass = allowed ? "btn btn-default btn-sm" : "btn btn-primary btn-sm" };
                change.Attributes["aria-label"] = change.Text + " mobile attendance for " + Convert.ToString(employee["DisplayName"]);
                change.Click += (sender, args) => ExecuteAuthorized(() =>
                {
                    SetUserAttendance(userId, !allowed);
                    RedirectEmployees(search);
                });
                action.Controls.Add(change);
                row.Cells.Add(action);
                table.Rows.Add(row);
            }
            AddTable(table);
        }

        private void RedirectEmployees(string search)
        {
            var url = PageUrl("employees", SelectedOrganization);
            if (search.Length > 100) search = search.Substring(0, 100);
            if (search.Length > 0) url += "&q=" + HttpUtility.UrlEncode(search);
            Response.Redirect(url, false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void SetUserAttendance(long userId, bool allowed)
        {
            Query(@"SET XACT_ABORT ON;
                BEGIN TRAN;
                IF NOT EXISTS (SELECT 1 FROM dbo.tblUser WHERE OrgId=@OrgId AND UserId=@UserId AND IsActive=1)
                    THROW 51004,'This active user was not found in the selected organization.',1;
                IF NOT EXISTS (SELECT 1 FROM dbo.AttendancePolicy WHERE OrgId=@OrgId)
                    THROW 51003,'Save this organization’s attendance settings first.',1;
                IF EXISTS (SELECT 1 FROM dbo.AttendanceEmployee WITH (UPDLOCK,HOLDLOCK) WHERE OrgId=@OrgId AND UserId=@UserId)
                    UPDATE dbo.AttendanceEmployee SET Enabled=@Allowed WHERE OrgId=@OrgId AND UserId=@UserId;
                ELSE INSERT dbo.AttendanceEmployee(OrgId,UserId,Enabled) VALUES(@OrgId,@UserId,@Allowed);
                INSERT dbo.AttendanceAudit(OrgId,ActorUserId,ActionName,TargetId,Details)
                VALUES(@OrgId,@Actor,CASE WHEN @Allowed=1 THEN 'USER_ATTENDANCE_ALLOWED' ELSE 'USER_ATTENDANCE_DISALLOWED' END,
                    @UserId,'Mobile check-in access changed.');
                COMMIT;", cmd =>
            {
                cmd.Parameters.AddWithValue("@Actor", actor);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@Allowed", allowed);
            });
        }

        private void ShowCalendar()
        {
            Grid(Query(@"SELECT TOP (500) EmployeeUserId,CONVERT(char(10),WorkDate,23) AS WorkDate,Description,BlockPunch
                FROM dbo.AttendanceCalendarDay WHERE OrgId=@OrgId ORDER BY WorkDate DESC,CalendarId DESC"));
        }

        private void SaveCalendar(bool remove)
        {
            var description = Value("description");
            if (!remove && (description.Length == 0 || description.Length > 200)) throw new FormatException();
            var date = DateTime.ParseExact(Value("date"), "yyyy-MM-dd", CultureInfo.InvariantCulture);
            var user = Value("user") == "" ? 0 : Id("user");
            if (user < 0) throw new FormatException();
            Query(@"SET XACT_ABORT ON;
                BEGIN TRAN;
                IF NOT EXISTS (SELECT 1 FROM dbo.AttendancePolicy WHERE OrgId=@OrgId)
                    THROW 51003,'Save organization attendance settings first.',1;
                IF @User<>0
                BEGIN
                    IF NOT EXISTS (SELECT 1 FROM dbo.tblUser WHERE OrgId=@OrgId AND UserId=@User AND IsActive=1)
                        THROW 51004,'Attendance employee not found.',1;
                    IF NOT EXISTS (SELECT 1 FROM dbo.AttendanceEmployee WITH (UPDLOCK,HOLDLOCK) WHERE OrgId=@OrgId AND UserId=@User)
                        INSERT dbo.AttendanceEmployee(OrgId,UserId,Enabled) VALUES(@OrgId,@User,1);
                END;
                IF EXISTS (SELECT 1 FROM dbo.AttendanceCalendarDay WITH (UPDLOCK,HOLDLOCK) WHERE OrgId=@OrgId AND UserId=@User AND WorkDate=@Date)
                BEGIN
                    IF @Remove=1 DELETE dbo.AttendanceCalendarDay WHERE OrgId=@OrgId AND UserId=@User AND WorkDate=@Date;
                    ELSE UPDATE dbo.AttendanceCalendarDay SET Description=@Description,BlockPunch=@Block
                    WHERE OrgId=@OrgId AND UserId=@User AND WorkDate=@Date;
                END
                ELSE IF @Remove=0
                    INSERT dbo.AttendanceCalendarDay(OrgId,EmployeeUserId,WorkDate,Description,BlockPunch)
                    VALUES(@OrgId,NULLIF(@User,0),@Date,@Description,@Block);
                INSERT dbo.AttendanceAudit(OrgId,ActorUserId,ActionName,TargetId,Details)
                VALUES(@OrgId,@Actor,CASE WHEN @Remove=1 THEN 'CALENDAR_REMOVED' ELSE 'CALENDAR_SAVED' END,
                    NULLIF(@User,0),CONCAT(@Date,' ',@Description,' block=',@Block));
                COMMIT;", cmd =>
            {
                cmd.Parameters.AddWithValue("@Actor", actor);
                cmd.Parameters.AddWithValue("@User", user);
                cmd.Parameters.Add("@Date", SqlDbType.Date).Value = date;
                cmd.Parameters.Add("@Description", SqlDbType.NVarChar, 200).Value = remove ? "" : description;
                cmd.Parameters.AddWithValue("@Block", !remove && Flag("block"));
                cmd.Parameters.AddWithValue("@Remove", remove);
            });
            Notice(remove ? "Calendar day removed." : "Calendar day saved.");
            ShowCalendar();
        }

        private void Correct()
        {
            var reason = Value("reason");
            if (reason.Length < 10 || reason.Length > 1000) throw new FormatException();
            Query("dbo.Attendance_CorrectSession", cmd =>
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Actor", actor);
                cmd.Parameters.AddWithValue("@Id", correctionId);
                cmd.Parameters.Add("@InUtc", SqlDbType.DateTime2).Value = Utc("in");
                cmd.Parameters.Add("@OutUtc", SqlDbType.DateTime2).Value = Value("out") == "" ? (object)DBNull.Value : Utc("out");
                cmd.Parameters.Add("@Reason", SqlDbType.NVarChar, 1000).Value = reason;
            });
            Notice("Correction saved.");
        }

        private void Records(bool csv)
        {
            var from = DateTime.ParseExact(Value("from"), "yyyy-MM-dd", CultureInfo.InvariantCulture);
            var to = DateTime.ParseExact(Value("to"), "yyyy-MM-dd", CultureInfo.InvariantCulture);
            if (to < from || (to - from).TotalDays > 366) throw new FormatException();
            var rows = Query(@"SELECT TOP (5001) s.SessionId,s.UserId,
                CASE WHEN u.UserId IS NOT NULL THEN CONCAT(u.FirstName,' ',u.LastName) END AS Employee,
                CONVERT(char(10),s.WorkDate,23) AS WorkDate,s.CheckInUtc,s.CheckOutUtc,
                DATEDIFF_BIG(second,s.CheckInUtc,s.CheckOutUtc) AS WorkedSeconds
                FROM dbo.AttendanceSession s LEFT JOIN dbo.tblUser u ON u.UserId=s.UserId AND u.OrgId=s.OrgId
                WHERE s.OrgId=@OrgId AND s.WorkDate BETWEEN @From AND @To
                ORDER BY s.WorkDate DESC,s.SessionId DESC", cmd =>
            {
                cmd.Parameters.Add("@From", SqlDbType.Date).Value = from;
                cmd.Parameters.Add("@To", SqlDbType.Date).Value = to;
            });
            if (rows.Rows.Count > 5000) { Notice("Narrow the date range to 5,000 records or fewer."); return; }
            if (!csv) { Grid(rows, corrections: true); return; }
            var output = new StringBuilder();
            output.AppendLine(string.Join(",", rows.Columns.Cast<DataColumn>().Select(c => c.ColumnName)));
            foreach (DataRow row in rows.Rows)
                output.AppendLine(string.Join(",", row.ItemArray.Select(Csv)));
            Download(Encoding.UTF8.GetBytes(output.ToString()), "text/csv", "attendance.csv");
        }

        private void ShowPhoto(bool checkout)
        {
            var rows = Query(@"SELECT TOP (1) Photo FROM dbo.AttendancePunch WHERE OrgId=@OrgId AND SessionId=@Id
                AND IsCheckout=@Checkout AND Photo IS NOT NULL ORDER BY RecordedUtc DESC,RequestId DESC", cmd =>
            {
                cmd.Parameters.AddWithValue("@Id", Id("session"));
                cmd.Parameters.AddWithValue("@Checkout", checkout);
            });
            if (rows.Rows.Count == 0) { Notice("Photo unavailable."); return; }
            var bytes = (byte[])rows.Rows[0][0];
            Download(bytes, "application/octet-stream", bytes[0] == 137 ? "attendance.png" : "attendance.jpg");
        }

        private void ShowLocations()
        {
            Grid(Query(@"SELECT TOP (1000) CapturedUtc,Latitude,Longitude,Accuracy FROM dbo.AttendanceLocation
                WHERE OrgId=@OrgId AND SessionId=@Id ORDER BY CapturedUtc DESC",
                cmd => cmd.Parameters.AddWithValue("@Id", Id("session"))));
        }

        private bool downloaded;
        private void Download(byte[] bytes, string mime, string filename)
        {
            downloaded = true;
            Response.Clear();
            Response.ContentType = mime;
            Response.Headers["X-Content-Type-Options"] = "nosniff";
            Response.AddHeader("Content-Disposition", "attachment; filename=" + filename);
            Response.BinaryWrite(bytes);
            Context.ApplicationInstance.CompleteRequest();
        }

        protected override void Render(HtmlTextWriter writer)
        {
            if (!downloaded) base.Render(writer);
        }

        private void Grid(DataTable rows, bool corrections = false)
        {
            if (rows.Rows.Count == 0) { Notice("No records found."); return; }
            var grid = new GridView { CssClass = "table table-striped", AutoGenerateColumns = false, DataSource = rows,
                UseAccessibleHeader = true, GridLines = GridLines.None };
            foreach (DataColumn column in rows.Columns)
            {
                var name = column.ColumnName;
                var label = System.Text.RegularExpressions.Regex.Replace(name, "(?<=[a-z])(?=[A-Z])", " ")
                    .Replace("Utc", "(UTC)");
                if (name.EndsWith("Id", StringComparison.Ordinal))
                    label = label.Substring(0, label.Length - 2) + "ID";
                grid.Columns.Add(new BoundField { DataField = name, HeaderText = label, HtmlEncode = true,
                    DataFormatString = column.DataType == typeof(DateTime) ? "{0:dd MMM yyyy, HH:mm:ss}" : "" });
            }
            if (corrections)
            {
                grid.Columns.Add(new HyperLinkField
                {
                    HeaderText = "Action", Text = "Correct",
                    DataNavigateUrlFields = new[] { "SessionId" },
                    DataNavigateUrlFormatString = PageUrl("corrections", SelectedOrganization) + "&sessionId={0}"
                });
            }
            grid.DataBind();
            if (grid.HeaderRow != null) grid.HeaderRow.TableSection = TableRowSection.TableHeader;
            AddTable(grid);
        }

        private void AddTable(Control table)
        {
            var wrapper = new Panel { CssClass = "attendance-table" };
            wrapper.Controls.Add(table);
            AttendanceBody.Controls.Add(wrapper);
        }

        private void Notice(string message) => AttendanceBody.Controls.Add(new Literal
        {
            Text = "<p class=\"alert alert-info\" role=\"status\">" + HttpUtility.HtmlEncode(message) + "</p>"
        });

        private string Value(string name) => fields[name].Text.Trim();
        private long Id(string name) => long.Parse(Value(name), CultureInfo.InvariantCulture);
        private bool Flag(string name) => switches[name].Checked;
        private TimeSpan? ShiftTime(string name) => Value(name) == "" ? (TimeSpan?)null :
            DateTime.ParseExact(Value(name), "HH:mm", CultureInfo.InvariantCulture).TimeOfDay;
        private decimal? DecimalOrNull(string name) => Value(name) == "" ? (decimal?)null : decimal.Parse(Value(name), CultureInfo.InvariantCulture);
        private DateTime Utc(string name) => DateTime.ParseExact(Value(name),
            new[] { "yyyy-MM-dd'T'HH:mm:ss", "yyyy-MM-dd'T'HH:mm" },
            CultureInfo.InvariantCulture, DateTimeStyles.AssumeUniversal | DateTimeStyles.AdjustToUniversal);
        private static void AddDecimal(SqlCommand cmd, string name, decimal? value, byte scale)
        {
            cmd.Parameters.Add(new SqlParameter(name, SqlDbType.Decimal)
            { Precision = 9, Scale = scale, Value = (object)value ?? DBNull.Value });
        }
        private static string Csv(object value)
        {
            var text = Convert.ToString(value, CultureInfo.InvariantCulture);
            if (text.TrimStart().Length > 0 && "=+-@".Contains(text.TrimStart()[0])) text = "'" + text;
            return "\"" + text.Replace("\"", "\"\"") + "\"";
        }
    }
}

