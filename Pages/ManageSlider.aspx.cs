using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class ManageSlider : System.Web.UI.Page
    {
        int tabIndex = -1;
        int PageSize = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData(1, PageSize);

            }
        }
        public void BindData(int PageIndex, int PageSize)
        {
            using (BusinessLogicLayer ObjIHC = new BusinessLogicLayer())
            {
                ObjIHC.PageIndex = PageIndex;
                ObjIHC.PageSize = PageSize;

                using (DataSet dsMain = ObjIHC.GetBannerList())
                {
                    tabIndex++;
                    if (dsMain.Tables.Count > tabIndex)
                    {
                        using (DataTable dt = dsMain.Tables[tabIndex])
                        {
                            if (dt.Rows.Count > 0)
                            {
                                grdAdminList.DataSource = dt;
                                grdAdminList.DataBind();
                            }
                            else
                            {
                                grdAdminList.DataSource = null;
                                grdAdminList.DataBind();
                            }
                        }
                    }
                    tabIndex++;
                    if (dsMain.Tables.Count > tabIndex)
                    {
                        using (DataTable dt = dsMain.Tables[tabIndex])
                        {
                            if (dt != null && dt.Rows.Count > 0)
                            {
                                //rptImage.DataSource = dt;
                                //rptImage.DataBind();


                            }
                        }
                    }

                    tabIndex++;
                    if (dsMain.Tables.Count > tabIndex)
                    {
                        using (DataTable dt = dsMain.Tables[tabIndex])
                        {
                            if (dt != null && dt.Rows.Count > 0)
                            {
                                //chkSizeList.DataSource = dt;
                                //chkSizeList.DataTextField = "Size";
                                //chkSizeList.DataValueField = "sizeid";
                                //chkSizeList.DataBind();

                            }
                        }
                    }

                    #region "Total Count"
                    tabIndex++;
                    if (dsMain.Tables.Count > tabIndex)
                    {
                        using (DataTable dtCount = dsMain.Tables[tabIndex])
                        {
                            if (dtCount != null && dtCount.Rows.Count > 0)
                            {
                                if (Convert.ToInt32(dtCount.Rows[0][0]) > 0)
                                {
                                    rptPager.Visible = true;
                                    SetPaging(Convert.ToInt32(dtCount.Rows[0][0]));
                                }
                                else
                                {
                                    rptPager.Visible = false;
                                }
                            }
                        }
                    }
                    #endregion
                }
            }
        }

        protected void grdAdminList_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void lnkEdit_Command(object sender, CommandEventArgs e)
        {
            string ItemId = e.CommandArgument.ToString();
            if (e.CommandName == "edit")
            {
                Response.Redirect("https://myneedify.com//Pages/SliderManagement.aspx?ItemId=" + ItemId);
            }
            if (e.CommandName == "Delete")
            {
                using (BusinessLogicLayer ObjIHC = new BusinessLogicLayer())
                {
                    ObjIHC.ItemId = Convert.ToInt32(ItemId);
                    ObjIHC.DeleteSlider();
                    BindData(1, PageSize);
                }
            }

        }
        private void SetPaging(int Total)
        {
            int pages = Total / PageSize;
            if ((Total % PageSize) > 0) pages++;
            DataTable dtPager = new DataTable();
            dtPager.Columns.Add("Text");
            dtPager.Columns.Add("Value");
            dtPager.Columns.Add("Style");
            DataRow dr;
            hdnTotalPages.Value = Convert.ToString(pages);
            if (pages < 5)
                hdnShowPageTo.Value = Convert.ToString(pages);

            #region "Previous"
            if (Convert.ToInt32(hdnCurrentPageIndex.Value) > 1)
            {
                dr = dtPager.NewRow();
                dr["Text"] = "< Previous";
                dr["Value"] = "P";
                dr["Style"] = "font-size: 12px; padding: 5px 10px; color: #0D496B; border: solid 1px #F4F4F4; border-radius: 5px; background-color: #FFF;";
                dtPager.Rows.Add(dr);
            }
            #endregion

            #region "Numbering"
            for (int i = Convert.ToInt32(hdnShowPageFrom.Value.Trim()); i <= Convert.ToInt32(hdnShowPageTo.Value.Trim()); i++)
            {
                dr = dtPager.NewRow();
                dr["Text"] = i;
                dr["Value"] = i;
                if (i == Convert.ToInt32(hdnCurrentPageIndex.Value))
                    dr["Style"] = "font-size: 12px; padding: 5px 10px; color: #FFF; border: solid 1px #0D496B; border-radius: 5px; background-color: #0D496B;";
                else
                    dr["Style"] = "font-size: 12px; padding: 5px 10px; color: #0D496B; border: solid 1px #F4F4F4; border-radius: 5px; background-color: #FFF;";
                dtPager.Rows.Add(dr);
            }
            #endregion

            #region "Next"
            dr = dtPager.NewRow();
            dr["Text"] = "Next >";
            dr["Value"] = "N";
            dr["Style"] = "font-size: 12px; padding: 5px 10px; color: #0D496B; border: solid 1px #F4F4F4; border-radius: 5px; background-color: #FFF;";
            dtPager.Rows.Add(dr);
            #endregion

            if (dtPager != null && dtPager.Rows.Count > 1 && pages > 1)
            {
                rptPager.Visible = true;
                rptPager.DataSource = dtPager;
                rptPager.DataBind();
            }
            else
            {
                rptPager.Visible = false;
            }
        }

        protected void rptPager_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Pager")
            {
                int pageIndex = Convert.ToInt32(hdnCurrentPageIndex.Value.Trim());
                if (e.CommandArgument.ToString().Trim() == "P" && pageIndex > 1)
                {
                    pageIndex--;
                    hdnCurrentPageIndex.Value = Convert.ToString(pageIndex);
                    if (Convert.ToInt32(hdnShowPageFrom.Value.Trim()) > pageIndex && pageIndex != 1)
                    {
                        int x = 5;
                        if (Convert.ToInt32(hdnShowPageTo.Value) % 5 != 0)
                        {
                            x = Convert.ToInt32(hdnShowPageTo.Value) % 5;
                        }
                        hdnShowPageFrom.Value = Convert.ToString(Convert.ToInt32(hdnShowPageFrom.Value.Trim()) - 5);
                        hdnShowPageTo.Value = Convert.ToString(Convert.ToInt32(hdnShowPageTo.Value.Trim()) - x);
                    }
                }
                else if (e.CommandArgument.ToString().Trim() == "N" && pageIndex < Convert.ToInt32(hdnTotalPages.Value))
                {
                    pageIndex++;
                    hdnCurrentPageIndex.Value = Convert.ToString(pageIndex);
                    if (Convert.ToInt32(hdnShowPageTo.Value.Trim()) < pageIndex)
                    {
                        int x = 5;
                        if ((Convert.ToInt32(hdnTotalPages.Value) - Convert.ToInt32(hdnShowPageTo.Value)) < 5)
                        {
                            x = (Convert.ToInt32(hdnTotalPages.Value) - Convert.ToInt32(hdnShowPageTo.Value));
                        }
                        hdnShowPageFrom.Value = Convert.ToString(Convert.ToInt32(hdnShowPageFrom.Value.Trim()) + 5);
                        hdnShowPageTo.Value = Convert.ToString(Convert.ToInt32(hdnShowPageTo.Value.Trim()) + x);
                    }
                }
                else if (((LinkButton)e.CommandSource).Text.Trim() == "<<")
                {
                    hdnShowPageFrom.Value = "1";
                    hdnShowPageTo.Value = "5";
                    pageIndex = Convert.ToInt32(e.CommandArgument);
                    hdnCurrentPageIndex.Value = e.CommandArgument.ToString().Trim();
                }
                else if (((LinkButton)e.CommandSource).Text.Trim() == ">>")
                {
                    int x = ((Convert.ToInt32(hdnTotalPages.Value) % 5) == 0 ? 5 : (Convert.ToInt32(hdnTotalPages.Value) % 5)) - 1;
                    hdnShowPageFrom.Value = Convert.ToString(Convert.ToInt32(e.CommandArgument) - x);
                    hdnShowPageTo.Value = e.CommandArgument.ToString().Trim();
                    pageIndex = Convert.ToInt32(e.CommandArgument);
                    hdnCurrentPageIndex.Value = e.CommandArgument.ToString().Trim();
                }
                else if (e.CommandArgument.ToString().Trim() != "P" && e.CommandArgument.ToString().Trim() != "N")
                {
                    pageIndex = Convert.ToInt32(e.CommandArgument);
                    hdnCurrentPageIndex.Value = e.CommandArgument.ToString().Trim();
                }
                BindData(pageIndex, PageSize);
            }
        }
    }
}