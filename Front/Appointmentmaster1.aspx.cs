using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

public partial class AppointmentMaster : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection("YOUR_CONNECTION_STRING");
    int SellerId => Convert.ToInt32(Session["SellerId"]);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadStaff();
            LoadSlots();
            LoadServices();
        }
    }

    protected void AddStaff(object sender, EventArgs e)
    {
        ExecSP("sp_AddSellerStaff",
            ("@SellerId", SellerId),
            ("@StaffName", txtStaffName.Text));
        LoadStaff();
    }

    protected void CreateSlot(object sender, EventArgs e)
    {
        string staffIds = string.Join(",",
            chkStaff.Items.Cast<System.Web.UI.WebControls.ListItem>()
            .Where(x => x.Selected).Select(x => x.Value));

        ExecSP("sp_CreateSlot_MultipleStaff",
            ("@SellerId", SellerId),
            ("@SlotDate", txtDate.Text),
            ("@StartTime", txtStart.Text),
            ("@EndTime", txtEnd.Text),
            ("@StaffIds", staffIds));

        LoadSlots();
    }

    protected void ToggleSlot(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int slotId = Convert.ToInt32(gvSlots.DataKeys[Convert.ToInt32(e.CommandArgument)].Value);
        ExecSP("sp_ToggleSlotAvailability", ("@SlotId", slotId));
        LoadSlots();
    }

    protected void AddService(object sender, EventArgs e)
    {
        ExecSP("sp_AddService",
            ("@SellerId", SellerId),
            ("@ServiceName", txtService.Text),
            ("@Price", txtPrice.Text));
        LoadServices();
    }

    void LoadStaff() => Bind("sp_GetSellerStaff", chkStaff, "StaffName", "StaffId");
    void LoadSlots() => Bind("sp_GetSellerSlots_WithStaff", gvSlots);
    void LoadServices() => Bind("sp_GetSellerServices", gvServices);

    void Bind(string sp, System.Web.UI.WebControls.ListControl c, string t, string v)
    {
        SqlDataAdapter da = new SqlDataAdapter(sp, con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@SellerId", SellerId);
        DataTable dt = new DataTable();
        da.Fill(dt);
        c.DataSource = dt;
        c.DataTextField = t;
        c.DataValueField = v;
        c.DataBind();
    }

    void Bind(string sp, System.Web.UI.WebControls.GridView g)
    {
        SqlDataAdapter da = new SqlDataAdapter(sp, con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@SellerId", SellerId);
        DataTable dt = new DataTable();
        da.Fill(dt);
        g.DataSource = dt;
        g.DataBind();
    }

    void ExecSP(string sp, params (string, object)[] p)
    {
        SqlCommand cmd = new SqlCommand(sp, con);
        cmd.CommandType = CommandType.StoredProcedure;
        foreach (var x in p)
            cmd.Parameters.AddWithValue(x.Item1, x.Item2);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
}
