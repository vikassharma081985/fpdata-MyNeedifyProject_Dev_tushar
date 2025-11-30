using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace DAL
{
    public class DataAccessLayer : IDisposable
    {
        string ConStr;

        ~DataAccessLayer()
        {
            Dispose(false);
        }

        public void Dispose(bool disposable)
        {

        }
        public void Dispose()
        {
            GC.SuppressFinalize(this);
        }


        public DataSet GetDataSet(SqlCommand cmd)
        {

            using (SqlConnection con = new SqlConnection())
            {
                ConStr = ConfigurationManager.ConnectionStrings["WsBilling"].ConnectionString;
                con.ConnectionString = ConStr;
                cmd.Connection = con;
                con.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataSet ds = new DataSet())
                    {
                        da.Fill(ds);
                        return ds;
                    }
                }

            }

        }

        public DataTable GetDataTable(SqlCommand cmd)
        {
            using (SqlConnection con = new SqlConnection())
            {
                ConStr = ConfigurationManager.ConnectionStrings["WsBilling"].ConnectionString;
                con.ConnectionString = ConStr;
                cmd.Connection = con;
                con.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        return dt;
                    }
                }

            }

        }

        public int ExecuteNonQuery_RetInt(SqlCommand cmd)
        {
            using (SqlConnection con = new SqlConnection())
            {
                ConStr = ConfigurationManager.ConnectionStrings["WsBilling"].ConnectionString;
                con.ConnectionString = ConStr;
                cmd.Connection = con;
                con.Open();
                int RowEffected = cmd.ExecuteNonQuery();
                return RowEffected;
            }

        }

    }
}

