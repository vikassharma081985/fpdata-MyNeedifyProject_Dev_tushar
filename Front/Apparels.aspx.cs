using System;
using System.Data;

public partial class Apparels : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindProducts();
        }
    }

    private void BindProducts()
    {
        DataTable dt = new DataTable();

        dt.Columns.Add("ItemId");
        dt.Columns.Add("ItemName");
        dt.Columns.Add("ImageName");
        dt.Columns.Add("OfferPrice");
        dt.Columns.Add("ItemPrice");

        dt.Rows.Add("1", "Men T-Shirt", "shirt1.jpg", "799", "999");
        dt.Rows.Add("2", "Women Kurti", "kurti.jpg", "1299", "1599");
        dt.Rows.Add("3", "Jeans", "jeans.jpg", "1499", "1999");
        dt.Rows.Add("4", "Hoodie", "hoodie.jpg", "1799", "2299");

        //rptWomenCollection.DataSource = dt;
        //rptWomenCollection.DataBind();

        //divWomenCollNoRecord.Visible = dt.Rows.Count == 0;
    }
}