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
    public partial class Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["SubSubCategory"] != null)
            {
                hdnSubSubCategory.Value = Request["SubSubCategory"].ToString();

                BindData();

            }
            if (Request["Search"] != null)
            {


                hdnSearchText.Value = Request["Search"].ToString();
                BindData();
            }
        }

        private void BindData()
        {
            int index = -1;
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                if (Request["SubSubCategory"] != null)
                    objFp.SubSubCategoryId = Convert.ToInt32(Request["SubSubCategory"]);
                if (Request["Search"] != null)
                    objFp.Search = Request["Search"].ToString();


                using (DataSet dsMain = objFp.BindSearchData())
                {
                    index++;
                    if (dsMain.Tables.Count > index)
                    {
                        using (DataTable dt = dsMain.Tables[index])
                        {
                            if (dt.Rows.Count > 0 && dt != null)
                            {
                                rptSizeNum.DataSource = dt;
                                rptSizeNum.DataBind();

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
                                rptSizeAlpha.DataSource = dt;
                                rptSizeAlpha.DataBind();
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
                                rptColor.DataSource = dt;
                                rptColor.DataBind();
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
                                rptSearchData.DataSource = dt;
                                rptSearchData.DataBind();
                                lblTotalCount.Text = dt.Rows.Count.ToString();
                            }
                        }
                    }

                }
            }
        }



        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SearchData(string SubSubCategory, string SearchText, string SelectedSize, string SelectedColor, string Price, string PriceOrder)
        {
            using (BusinessLogicLayer objFp = new BusinessLogicLayer())
            {
                if (SubSubCategory != "")
                    objFp.SubSubCategoryId = Convert.ToInt32(SubSubCategory);
                if (SearchText != "")
                    objFp.Search = SearchText.ToString();

                if (SelectedSize != "")
                    objFp.SizeSearch = SelectedSize;
                if (SelectedColor != "")
                    objFp.ColorSearch = SelectedColor;
                if (Price != "")
                    objFp.Amount = Convert.ToInt32(Price);
                objFp.PriceOrder = PriceOrder;
                using (DataSet dsMain = objFp.BindSearchData())
                {
                    using (DataTable dt = dsMain.Tables[3])
                    {

                        string rtrn = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                        return rtrn;

                    }
                }
            }
        }
    }
}