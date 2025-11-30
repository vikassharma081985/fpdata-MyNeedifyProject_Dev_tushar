using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WSBillingMaster.Pages
{
    public partial class BillingScreen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblDate.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                
               
            }
        }
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SearchData()
        {
            //StringBuilder sb1 = new StringBuilder();
            //sb1.Append(" SELECT em.`Employee_ID` as EmpId ,em.`Name` AS EmployeeName,  DATE_FORMAT(now(),'%d-%b-%Y %h:%i:%s %p')   AS LastDateTime,(SELECT IFNULL(SUM(Amount),'0') prevBal FROM Employee_Account WHERE Employee_Id_by=" + Value + ") as PrevBal,  IFNULL(SUM(r.Amount),'0') Amount,IFNULL(a.Amount,'0') AS Amount  FROM `employee_master` em  ");
            //sb1.Append(" LEFT  JOIN  (");
            //sb1.Append(" SELECT rec.`UserId` AS Employee_ID,SUM(rec.Amount) Amount FROM f_reciept Rec  ");
            //sb1.Append(" WHERE  rec.`IsCancel`=0 ");
            //sb1.Append(" AND rec.EntryDateTime > (SELECT IFNULL(MAX( LastDateTime),'0001-01-01  00:00:00') FROM Employee_Account WHERE Employee_Id_by=" + Value + ")   ");
            //sb1.Append("  AND rec.`EntryDateTime` <=NOW()  AND rec.`UserID` IN (" + Value + ")  GROUP BY rec.UserID, rec.`PaymentModeID` ");
            //sb1.Append(" )r ON em.`Employee_ID`=r.Employee_ID  ");
            //sb1.Append(" LEFT  JOIN  ( ");
            //sb1.Append(" SELECT Employee_Id_by AS Employee_Id,  IFNULL(SUM(Amount),'0') amount FROM Employee_Account WHERE Employee_Id_by IN (" + Value + ") )a ON em.Employee_Id =a.Employee_Id    ");
            //sb1.Append(" WHERE  em.`Employee_ID`  IN (" + Value + ") ");
            //DataTable dt = StockReports.GetDataTable(sb1.ToString());
            //return Newtonsoft.Json.JsonConvert.SerializeObject(dt);
            return "1";

        }
    }
}