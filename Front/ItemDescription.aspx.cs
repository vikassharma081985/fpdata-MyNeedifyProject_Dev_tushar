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
    public partial class ItemDescription : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["ItemId"] != null)
            {
                BindItemData(Request["ItemId"].ToString());
                hdnItemId.Value = Request["ItemId"].ToString();
                if (Session["UserId"] != null)
                {
                    hdnUserId.Value = Session["UserId"].ToString();
                }
            }

        }

        private void BindItemData(string ItemId)
        {
            int index = 0;
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                objFp.ItemId = Convert.ToInt32(Request["ItemId"].ToString());
                using (DataSet dsMain = objFp.GetItemDescriptionData())
                {
                    //index++;
                    if (dsMain.Tables.Count > index)
                    {
                        using (DataTable dt = dsMain.Tables[index])
                        {
                            if (dt.Rows.Count > 0 && dt != null)
                            {
                                lblItemName.Text = dt.Rows[0]["ItemName"].ToString();
                                //var Description = dt.Rows[0]["ItemDescription"].ToString();

                                lblDescription.Text = Server.HtmlDecode(dt.Rows[0]["ItemDescription"].ToString()).Length > 250 ? Server.HtmlDecode(dt.Rows[0]["ItemDescription"].ToString()).Substring(0, 250) : Server.HtmlDecode(dt.Rows[0]["ItemDescription"].ToString());
                                lblDescriptionFull.Text = Server.HtmlDecode(dt.Rows[0]["ItemDescription"].ToString());
                                lblPrice.Text = dt.Rows[0]["OfferPrice"].ToString();
                                lblOfferPrice.Text = dt.Rows[0]["ItemPrice"].ToString();
                                lblOff.Text = (((Convert.ToInt32(dt.Rows[0]["OfferPrice"]) - Convert.ToInt32(dt.Rows[0]["ItemPrice"])) * 100) / (Convert.ToInt32(dt.Rows[0]["OfferPrice"]))).ToString() + "% off";
                                hdnTotalStock.Value = dt.Rows[0]["TotalStock"].ToString();
                                // ImgMain.ImageUrl = "../Images/Item/" + dt.Rows[0]["ImageName"].ToString();
                                // ImgMain.Attributes["src"] = "../Images/Item/" + dt.Rows[0]["ImageName"].ToString();
                            }
                        }
                    }

                    index++;
                    if (dsMain.Tables.Count > index)
                    {
                        using (DataTable dt = dsMain.Tables[index])
                        {
                            if (dt.Rows.Count > 0 && dt != null)
                            {
                                rptItemImages.DataSource = dt;
                                rptItemImages.DataBind();
                            }
                        }
                    }

                    index++;
                    if (dsMain.Tables.Count > index)
                    {
                        using (DataTable dt = dsMain.Tables[index])
                        {
                            if (dt.Rows.Count > 0 && dt != null)
                            {
                                rptAvailableSize.DataSource = dt;
                                rptAvailableSize.DataBind();
                            }
                        }
                    }

                    index++;
                    if (dsMain.Tables.Count > index)
                    {
                        using (DataTable dt = dsMain.Tables[index])
                        {
                            if (dt.Rows.Count > 0 && dt != null)
                            {
                                rptYouMayLike.DataSource = dt;
                                rptYouMayLike.DataBind();
                            }
                        }
                    }

                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string AddToCart(string Qty, string SizeId, string ItemId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.Quantity = Convert.ToInt32(Qty);
                obj.SizeId = Convert.ToInt32(SizeId);
                obj.UserId = HttpContext.Current.Session["UserId"].ToString();
                obj.ItemId = Convert.ToInt32(ItemId);
                string CartCtr = obj.AddToCart();
                return CartCtr;
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string AddToWishList(string ItemId, string UserId)
        {
            using (BusinessLogicLayer obj = new BusinessLogicLayer())
            {
                obj.UserId = UserId.ToString();
                obj.ItemId = Convert.ToInt32(ItemId);
                string WishList = obj.InsertWishlist().ToString();
                return WishList;
            }
        }

    }



}