using System;
using System.Data;
using System.Data.SqlClient;

namespace FaduPrice.Front
{
    public partial class AppointmentMaster : System.Web.UI.Page
    {  

        int SellerId => Convert.ToInt32(Session["SellerId"]);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSlots();
                LoadServices();
            }
        }

        protected void btnAddSlot_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("sp_CreateSlot", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@SellerId", SellerId);
            cmd.Parameters.AddWithValue("@SlotDate", txtDate.Text);
            cmd.Parameters.AddWithValue("@StartTime", txtStartTime.Text);
            cmd.Parameters.AddWithValue("@EndTime", txtEndTime.Text);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            LoadSlots();
        }

        protected void btnAddService_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("sp_AddService", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@SellerId", SellerId);
            cmd.Parameters.AddWithValue("@ServiceName", txtServiceName.Text);
            cmd.Parameters.AddWithValue("@Price", txtPrice.Text);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            LoadServices();
        }

        void LoadSlots()
        {
            SqlDataAdapter da = new SqlDataAdapter(
                "SELECT SlotId, SlotDate, StartTime, EndTime, IsAvailable FROM Slots WHERE SellerId=" + SellerId, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvSlots.DataSource = dt;
            gvSlots.DataBind();
        }

        void LoadServices()
        {
            SqlDataAdapter da = new SqlDataAdapter(
                "SELECT ServiceName, Price FROM Services WHERE SellerId=" + SellerId, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvServices.DataSource = dt;
            gvServices.DataBind();
        }

        protected void gvSlots_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Toggle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int slotId = Convert.ToInt32(gvSlots.DataKeys[index].Value);

                SqlCommand cmd = new SqlCommand(
                    "UPDATE Slots SET IsAvailable = CASE WHEN IsAvailable = 1 THEN 0 ELSE 1 END WHERE SlotId=@SlotId", con);

                cmd.Parameters.AddWithValue("@SlotId", slotId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                LoadSlots();
            }
        }
    }
}
