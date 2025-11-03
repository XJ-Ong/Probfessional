using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace Probfessional
{
    public partial class Modules : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadModules();
            }
        }

        private void LoadModules()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT ID, Title, Description, ImagePath FROM Modules";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        string html = "";
                        while (reader.Read())
                        {
                            int moduleId = Convert.ToInt32(reader["ID"]);
                            string title = reader["Title"].ToString();
                            string description = reader["Description"].ToString();
                            string imagePath = reader["ImagePath"] != DBNull.Value ? reader["ImagePath"].ToString() : "";
                            
                            // Truncate description if too long
                            string shortDesc = description.Length > 150 ? description.Substring(0, 147) + "..." : description;
                            
                            html += $@"
                                <div class='col-md-6 col-lg-4 mb-4'>
                                    <div class='module-card'>
                                        {(string.IsNullOrEmpty(imagePath) ? "" : $"<img src='{ResolveUrl("~/" + imagePath)}' alt='{title}' class='module-image' />")}
                                        <div class='module-body'>
                                            <h3 class='module-title'>{title}</h3>
                                            <p class='module-description'>{shortDesc}</p>
                                            <a href='Topics.aspx?id={moduleId}' class='btn-view-module'>View Module</a>
                                        </div>
                                    </div>
                                </div>";
                        }
                        modulesGrid.InnerHtml = html;
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "An error occurred while loading modules: " + ex.Message;
            }
        }
    }
}