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
                try
                {
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
                catch (SqlException ex)
                {
                    Console.WriteLine($"Error Number: {ex.Number}");
                    Console.WriteLine($"Message: {ex.Message}");
                    return null;
                }
                

            }

        }

        public bool ExecuteProcedureWithOutput(string procedureName, SqlParameter[] inputParams, string outputParamName)
        {
            using (SqlConnection con = new SqlConnection())
            {
                con.ConnectionString = ConfigurationManager.ConnectionStrings["WsBilling"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand(procedureName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Add input parameters
                    if (inputParams != null)
                    {
                        cmd.Parameters.AddRange(inputParams);
                    }

                    // Define output parameter
                    SqlParameter outputParam = new SqlParameter(outputParamName, SqlDbType.Bit)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(outputParam);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();

                        // Return output parameter value
                        return Convert.ToBoolean(outputParam.Value);
                    }
                    catch (SqlException ex)
                    {
                        Console.WriteLine($"SQL Error: {ex.Message}");
                        return false; // or throw
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

