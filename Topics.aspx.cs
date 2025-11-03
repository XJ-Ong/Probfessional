using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace Probfessional
{
    public partial class Topics : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadModuleDetails();
            }
        }

        private void LoadModuleDetails()
        {
            string moduleId = Request.QueryString["id"];
            
            if (string.IsNullOrEmpty(moduleId))
            {
                // No module ID specified, maybe redirect or show error
                lblError.Visible = true;
                lblError.Text = "No module specified.";
                return;
            }

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Load module details
                    string moduleQuery = "SELECT ID, Title, Description FROM Modules WHERE ID = @ModuleID";
                    using (SqlCommand cmd = new SqlCommand(moduleQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@ModuleID", moduleId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                title.InnerText = reader["Title"].ToString();
                                desc.InnerText = reader["Description"].ToString();
                            }
                            else
                            {
                                lblError.Visible = true;
                                lblError.Text = "Module not found.";
                                return;
                            }
                        }
                    }

                    // Load lessons for this module
                    string lessonsQuery = "SELECT ID, Title FROM Lessons WHERE ModuleID = @ModuleID";
                    using (SqlCommand cmd = new SqlCommand(lessonsQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@ModuleID", moduleId);
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            
                            // Add Url column with links to lesson details
                            dt.Columns.Add("Url", typeof(string));
                            foreach (DataRow row in dt.Rows)
                            {
                                int lessonId = Convert.ToInt32(row["ID"]);
                                row["Url"] = $"Lessons.aspx?id={lessonId}";
                            }
                            
                            rptLessons.DataSource = dt;
                            rptLessons.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "An error occurred while loading module details: " + ex.Message;
            }
        }
    }
}