using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Configuration;

namespace Probfessional
{
    public partial class Progress : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadModulesProgress();
            }
        }

        private void LoadModulesProgress()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            
            // Set the UserID parameter for the SqlDataSource
            sqlModulesProgress.SelectParameters["UserID"].DefaultValue = userId.ToString();
            
            // Bind the modules repeater
            rptModules.DataSourceID = "sqlModulesProgress";
            rptModules.DataBind();
        }

        protected void rptModules_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Get the module ID from the data item
                int moduleId = 0;
                if (e.Item.DataItem is DataRowView row)
                {
                    moduleId = Convert.ToInt32(row["Id"]);
                }
                else if (e.Item.DataItem is DbDataRecord record)
                {
                    moduleId = Convert.ToInt32(record["Id"]);
                }
                
                // Find the lessons repeater and load lessons for this module
                if (moduleId > 0)
                {
                    Repeater rptLessons = (Repeater)e.Item.FindControl("rptLessons");
                    if (rptLessons != null)
                    {
                        LoadLessonsForModule(rptLessons, moduleId);
                    }
                }
            }
        }

        private void LoadLessonsForModule(Repeater rptLessons, int moduleId)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT ID, Title, ModuleID, 0 as IsCompleted FROM Lessons WHERE ModuleID = @ModuleID ORDER BY ID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@ModuleID", moduleId);
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            rptLessons.DataSource = dt;
                            rptLessons.DataBind();
                        }
                    }
                }
            }
            catch (Exception)
            {
                // Log error if needed
                rptLessons.DataSource = new DataTable();
                rptLessons.DataBind();
            }
        }
    }
}
