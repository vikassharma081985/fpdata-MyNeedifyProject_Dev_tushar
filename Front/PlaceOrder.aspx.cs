using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FaduPrice.Pages
{
    public partial class PlaceOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["UserId"] = "1";
            if (Session["UserId"] != null)
            {
                BindData(Session["UserId"].ToString());

            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }

        private void BindData(string UserId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.UserId = UserId;
                using (DataSet ds = obj.BindCart())
                {

                    using (DataTable dt = ds.Tables[1])
                    {
                        if (dt.Rows.Count > 0)
                        {
                            rptItems.DataSource = dt;
                            rptItems.DataBind();

                            int Total = 0;
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                int Sub = Convert.ToInt32(dt.Rows[i]["ItemQuantity"]) * (Convert.ToInt32(dt.Rows[i]["ItemPrice"]));
                                Total = Total + Sub;
                            }

                            lblTotal.Text = Total.ToString();

                        }
                        else
                        {
                            rptItems.DataSource = null;
                            rptItems.DataBind();
                        }
                    }

                }
                using (DataTable dt = obj.GetUserAddress())
                {
                    if (dt.Rows.Count > 0)
                    {
                        rptUserAddress.DataSource = dt;
                        rptUserAddress.DataBind();
                    }
                }

            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string Order(string Name, string Mobile, string Building, string Locality, string City, string State, string Pincode, string Amount)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.UserId = Convert.ToString(HttpContext.Current.Session["UserId"]);
                obj.Name = Name;
                obj.Mobile = Mobile;
                obj.Building = Building;
                obj.Locality = Locality;
                obj.City = City;
                obj.State = State;
                obj.Pincode = Pincode;
                obj.Amount = Convert.ToInt32(Amount);
                using (DataTable dt = obj.PlaceOrder())
                {
                    string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                    return rtrn;
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string CheckDelivery(string Pincode)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {

                obj.Pincode = Pincode;

                using (DataTable dt = obj.CheckDelivery())
                {
                    string rtrn = "";
                    if (dt.Rows.Count > 0)
                    {
                        return rtrn = dt.Rows[0][0].ToString();
                    }
                    else
                    {
                        return rtrn;
                    }


                }
            }
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<ListItem> GetStateMaster()
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.GetStateMaster())
                {
                    List<ListItem> StateMaster = new List<ListItem>();

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        StateMaster.Add(new ListItem
                        {
                            Value = dt.Rows[i]["ID"].ToString(),
                            Text = dt.Rows[i]["State"].ToString()
                        });
                    }

                    return StateMaster;
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<ListItem> GetCityMasterByStateID(int stateID)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.GetCityMasterByStateID(stateID))
                {
                    List<ListItem> cityMaster = new List<ListItem>();

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        cityMaster.Add(new ListItem
                        {
                            Value = dt.Rows[i]["ID"].ToString(),
                            Text = dt.Rows[i]["City"].ToString()
                        });
                    }

                    return cityMaster;
                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<ListItem> GetAreaMasterByCityID(int CityID)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                using (DataTable dt = obj.GetAreaMasterByCityID(CityID))
                {
                    List<ListItem> AreaMaster = new List<ListItem>();

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        AreaMaster.Add(new ListItem
                        {
                            Value = dt.Rows[i]["pincode"].ToString(),
                            Text = dt.Rows[i]["Area"].ToString()
                        });
                    }

                    return AreaMaster;
                }
            }
        }
    }
}