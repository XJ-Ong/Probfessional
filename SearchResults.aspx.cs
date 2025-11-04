using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Probfessional
{
    public partial class SearchResults : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string searchQuery = Request.QueryString["q"];
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    lblSearchQuery.Text = $"Search results for: <strong>{Server.HtmlEncode(searchQuery)}</strong>";
                    PerformSearch(searchQuery);
                }
                else
                {
                    lblSearchQuery.Text = "Please enter a search term.";
                }
            }
        }

        private void PerformSearch(string searchTerm)
        {
            bool foundResults = false;

            // Step 2: Create connection
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);

            try
            {
                // Step 3: Open connection
                conn.Open();

                // Search in Modules
                string moduleQuery = "SELECT ID, Title, Description FROM Modules WHERE Title LIKE @SearchTerm OR Description LIKE @SearchTerm";
                SqlCommand commModules = new SqlCommand(moduleQuery, conn);
                commModules.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");

                SqlDataReader readerModules = commModules.ExecuteReader();
                DataTable dtModules = new DataTable();
                dtModules.Load(readerModules);
                readerModules.Close();

                if (dtModules.Rows.Count > 0)
                {
                    rptModules.DataSource = dtModules;
                    rptModules.DataBind();
                    pnlModules.Visible = true;
                    foundResults = true;
                }

                // Search in Lessons
                string lessonQuery = @"
                    SELECT 
                        l.ID as LessonID, 
                        l.Title as LessonTitle, 
                        l.Content, 
                        m.Title as ModuleTitle
                    FROM Lessons l
                    INNER JOIN Modules m ON l.ModuleID = m.ID
                    WHERE l.Title LIKE @SearchTerm OR l.Content LIKE @SearchTerm";
                
                SqlCommand commLessons = new SqlCommand(lessonQuery, conn);
                commLessons.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");

                SqlDataReader readerLessons = commLessons.ExecuteReader();
                DataTable dtLessons = new DataTable();
                dtLessons.Load(readerLessons);
                readerLessons.Close();

                if (dtLessons.Rows.Count > 0)
                {
                    rptLessons.DataSource = dtLessons;
                    rptLessons.DataBind();
                    pnlLessons.Visible = true;
                    foundResults = true;
                }

                if (!foundResults)
                {
                    lblNoResults.Text = $"No results found for '<strong>{Server.HtmlEncode(searchTerm)}</strong>'. Try different keywords.";
                    lblNoResults.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblNoResults.Text = "An error occurred while searching: " + ex.Message;
                lblNoResults.CssClass = "alert alert-danger";
                lblNoResults.Visible = true;
            }
            finally
            {
                // Step 6: Close connection
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }
        }

        protected string TruncateContent(string content, int maxLength)
        {
            if (string.IsNullOrEmpty(content))
                return "";

            // Remove HTML tags for display
            string plainText = System.Text.RegularExpressions.Regex.Replace(content, "<.*?>", "");
            
            if (plainText.Length <= maxLength)
                return plainText;

            return plainText.Substring(0, maxLength) + "...";
        }
    }
}

