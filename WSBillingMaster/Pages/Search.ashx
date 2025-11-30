<%@ WebHandler Language="C#" Class="Search" %>

using System;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using BLL;
using System.Data;

public class Search : IHttpHandler {
    
    public void ProcessRequest (HttpContext context)
    {
        string searchText = context.Request.QueryString["q"];
       
        StringBuilder sb = new StringBuilder();
        using(BusinessLogicLayer objBLL=new BusinessLogicLayer())
        {
            objBLL.Keyword = searchText;
            using (DataTable dt = objBLL.ItemSearch())
            {
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        sb.Append(string.Format("{0},{1}{2}", dt.Rows[i]["ItemName"], dt.Rows[i]["ItemImage"], Environment.NewLine));
                    }
                }

            }
            
        }
       
        context.Response.Write(sb.ToString());
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}

