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
            // Check if user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadModuleDetails();
            }
        }

        protected void sqlLessons_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            // This event allows you to handle the data selection if needed
        }

        protected void rptLessons_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Get the lesson ID from the data item
                if (e.Item.DataItem is DataRowView row)
                {
                    int lessonId = Convert.ToInt32(row["ID"]);
                    string lessonTitle = row["Title"].ToString();
                    
                    // Find the anchor tag and set the URL
                    System.Web.UI.HtmlControls.HtmlAnchor link = (System.Web.UI.HtmlControls.HtmlAnchor)e.Item.FindControl("lnkLesson");
                    if (link != null)
                    {
                        link.HRef = $"Lessons.aspx?id={lessonId}";
                    }
                }
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