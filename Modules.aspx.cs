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
            // Check if user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadModules();
            }
        }

        private void LoadModules()
        {
            // Step 2: Create connection
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);

            try
            {
                // Step 3: Open connection
                conn.Open();

                // Step 4: Prepare SqlCommand
                string query = "SELECT ID, Title, Description, ImagePath FROM Modules";
                SqlCommand comm = new SqlCommand(query, conn);

                // Step 5: Execute reader
                SqlDataReader reader = comm.ExecuteReader();
                
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
                            <div class='card'>
                                {(string.IsNullOrEmpty(imagePath) ? "" : $"<img src='{ResolveUrl("~/" + imagePath)}' alt='{title}' class='card-img-top' style='max-height:180px; object-fit:contain;' />")}
                                <div class='card-body'>
                                    <h5 class='card-title'>{title}</h5>
                                    <p class='card-text'>{shortDesc}</p>
                                    <a href='Topics.aspx?id={moduleId}' class='btn btn-primary'>View Module</a>
                                </div>
                            </div>
                        </div>";
                }
                reader.Close();
                modulesGrid.InnerHtml = html;
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "An error occurred while loading modules: " + ex.Message;
            }
            finally
            {
                // Step 6: Close connection
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }
        }
    }
}