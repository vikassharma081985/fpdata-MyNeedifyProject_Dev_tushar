using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using System.Data;
using System.Web.Services;
using System.Web.Script.Services;

namespace WSBillingMaster.Pages
{
    public partial class ManageItems : System.Web.UI.Page
    {
        private readonly Dictionary<string, string> itemImageJson = new Dictionary<string, string>();

        protected string GetItemImages(object itemId)
        {
            string json;
            return HttpUtility.HtmlAttributeEncode(itemImageJson.TryGetValue(Convert.ToString(itemId), out json) ? json : "[]");
        }

        private void LoadItemImages(DataTable items, BusinessLogicLayer bll)
        {
            var ids = new System.Xml.Linq.XElement("items",
                items.AsEnumerable().Select(row => new System.Xml.Linq.XElement("item",
                    new System.Xml.Linq.XAttribute("id", Convert.ToInt64(row["ItemId"])))));
            using (DataTable images = bll.GetManagedItemImages(ids.ToString()))
            {
                var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                foreach (var group in images.AsEnumerable().GroupBy(row => Convert.ToString(row["ItemId"])))
                {
                    itemImageJson[group.Key] = serializer.Serialize(group.Select(row => new {
                        ImageName = Convert.ToString(row["ImageName"]),
                        Url = VirtualPathUtility.ToAbsolute("~/Images/Items/") + Uri.EscapeDataString(Convert.ToString(row["ImageName"]))
                    }).ToArray());
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFromDate.Text = DateTime.Now.ToString("yyyy-MM-dd 00:00:00");
                txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd 23:59:59");
                
            }
        }

        private const int ItemsPerPage = 25;

        private int CurrentPage
        {
            get { return (int)(ViewState["ItemPage"] ?? 0); }
            set { ViewState["ItemPage"] = value; }
        }

        private int TotalPages
        {
            get { return (int)(ViewState["ItemPageCount"] ?? 0); }
            set { ViewState["ItemPageCount"] = value; }
        }

        private void StartSearch(int type)
        {
            CurrentPage = 0;
            ViewState["ItemSearchType"] = type;
            ViewState["ItemKeyword"] = txtSearch.Text.Trim();
            ViewState["ItemFromDate"] = txtFromDate.Text;
            ViewState["ItemToDate"] = txtToDate.Text;
            BindData(type);
        }

        private void UpdatePager(int itemCount)
        {
            pnlItemPager.Visible = itemCount > 0;
            btnItemFirst.Enabled = btnItemPrevious.Enabled = CurrentPage > 0;
            btnItemNext.Enabled = btnItemLast.Enabled = CurrentPage + 1 < TotalPages;
            lblItemPage.Text = itemCount == 0 ? "No items found." : string.Format(
                "Page {0} of {1} — Items {2}–{3} of {4}", CurrentPage + 1, TotalPages,
                CurrentPage * ItemsPerPage + 1, Math.Min((CurrentPage + 1) * ItemsPerPage, itemCount), itemCount);
            lblItemEmpty.Visible = itemCount == 0;
        }

        private void BindData(int type)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                // Keep the submitted search when navigating, even if the inputs are edited.
                objBLL.Keyword = Convert.ToString(ViewState["ItemKeyword"]);
                objBLL.FromDate = Convert.ToString(ViewState["ItemFromDate"]);
                objBLL.ToDate = Convert.ToString(ViewState["ItemToDate"]);
                using (DataTable dt = objBLL.GetManageItemData(type))
                {
                    int count = dt == null ? 0 : dt.Rows.Count;
                    TotalPages = (count + ItemsPerPage - 1) / ItemsPerPage;
                    CurrentPage = Math.Max(0, Math.Min(CurrentPage, TotalPages - 1));
                    itemImageJson.Clear();
                    if (count > 0)
                    {
                        using (DataTable page = dt.Clone())
                        {
                            int start = CurrentPage * ItemsPerPage;
                            for (int i = start; i < Math.Min(start + ItemsPerPage, count); i++)
                                page.ImportRow(dt.Rows[i]);
                            LoadItemImages(page, objBLL);
                            rptItems.DataSource = page;
                            rptItems.DataBind();
                        }
                    }
                    else
                    {
                        rptItems.DataSource = null;
                        rptItems.DataBind();
                    }
                    UpdatePager(count);
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (txtSearch.Text.Trim() == "")
            {
                CurrentPage = TotalPages = 0;
                rptItems.DataSource = null;
                rptItems.DataBind();
                UpdatePager(0);
            }
            else
            {
                StartSearch(1);
            }
        }

        protected void btnSearch2_Click(object sender, EventArgs e)
        {
            StartSearch(2);
        }

        protected void ItemPage_Command(object sender, CommandEventArgs e)
        {
            switch (Convert.ToString(e.CommandArgument))
            {
                case "First": CurrentPage = 0; break;
                case "Previous": CurrentPage = Math.Max(0, CurrentPage - 1); break;
                case "Next": CurrentPage = Math.Min(Math.Max(0, TotalPages - 1), CurrentPage + 1); break;
                case "Last": CurrentPage = Math.Max(0, TotalPages - 1); break;
            }
            BindData((int)(ViewState["ItemSearchType"] ?? 1));
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string EditItemName(int ItemId,string ItemName)
        {
            using (BusinessLogicLayer objBLL = new BusinessLogicLayer())
            {
                objBLL.ItemName = ItemName;
                objBLL.ItemId = ItemId;
                return objBLL.EditItemName().ToString();
                
            }
        }
    }
}