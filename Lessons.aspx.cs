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
    public partial class Lessons : System.Web.UI.Page
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
                LoadLesson();
            }
        }

        private void LoadLesson()
        {
            string lessonId = Request.QueryString["id"];
            
            if (string.IsNullOrEmpty(lessonId))
            {
                lblError.Visible = true;
                lblError.Text = "No lesson specified.";
                return;
            }

            // Step 2: Create connection
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);
            int moduleId = 0;

            try
            {
                // Step 3: Open connection
                conn.Open();

                // Step 4: Prepare SqlCommand
                string lessonQuery = "SELECT l.ID, l.Title, l.Content, l.ModuleID FROM Lessons l WHERE l.ID = @LessonID";
                SqlCommand comm = new SqlCommand(lessonQuery, conn);
                comm.Parameters.AddWithValue("@LessonID", lessonId);

                // Step 5: Execute reader
                SqlDataReader reader = comm.ExecuteReader();
                if (reader.Read())
                {
                    lessonTitle.InnerText = reader["Title"].ToString();
                    lessonContent.InnerHtml = reader["Content"].ToString();
                    moduleId = Convert.ToInt32(reader["ModuleID"]);
                    reader.Close();
                }
                else
                {
                    reader.Close();
                    lblError.Visible = true;
                    lblError.Text = "Lesson not found.";
                    return;
                }

                // Get all lessons in the module ordered by ID
                string allLessonsQuery = "SELECT ID, Title FROM Lessons WHERE ModuleID = @ModuleID ORDER BY ID";
                SqlCommand comm2 = new SqlCommand(allLessonsQuery, conn);
                comm2.Parameters.AddWithValue("@ModuleID", moduleId);

                SqlDataReader reader2 = comm2.ExecuteReader();
                var lessonList = new System.Collections.Generic.List<(string ID, string Title)>();
                while (reader2.Read())
                {
                    lessonList.Add((reader2["ID"].ToString(), reader2["Title"].ToString()));
                }
                reader2.Close();

                // Find current lesson index
                int currentIndex = lessonList.FindIndex(l => l.ID == lessonId);
                
                // Set previous button
                if (currentIndex > 0)
                {
                    var (prevId, prevTitle) = lessonList[currentIndex - 1];
                    prevLesson.InnerHtml = $"<a href='Lessons.aspx?id={prevId}' class='btn btn-secondary'><span>‹</span> Previous</a>";
                }

                // Set next button
                if (currentIndex < lessonList.Count - 1)
                {
                    var (nextId, nextTitle) = lessonList[currentIndex + 1];
                    nextLesson.InnerHtml = $"<a href='Lessons.aspx?id={nextId}' class='btn btn-primary'>Next <span>›</span></a>";
                }

                // Update user progress if logged in
                if (Session["UserID"] != null)
                {
                    UpdateUserProgress(moduleId);
                }
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "An error occurred while loading lesson: " + ex.Message;
            }
            finally
            {
                // Step 6: Close connection
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }
        }

        private void UpdateUserProgress(int moduleId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);

            try
            {
                conn.Open();
                int userId = Convert.ToInt32(Session["UserID"]);
                
                // Get all lesson IDs ordered by ID
                string lessonQuery = "SELECT ID FROM Lessons WHERE ModuleID = @ModuleID ORDER BY ID";
                SqlCommand comm = new SqlCommand(lessonQuery, conn);
                comm.Parameters.AddWithValue("@ModuleID", moduleId);

                SqlDataReader reader = comm.ExecuteReader();
                var lessonIds = new List<int>();
                while (reader.Read())
                {
                    lessonIds.Add(Convert.ToInt32(reader["ID"]));
                }
                reader.Close();

                // Get the current lesson ID
                string currentLessonId = Request.QueryString["id"];
                if (string.IsNullOrEmpty(currentLessonId))
                    return;

                // Find the position of the current lesson
                int currentIndex = lessonIds.IndexOf(Convert.ToInt32(currentLessonId));
                decimal progressPercent = 0;

                if (lessonIds.Count > 0)
                {
                    progressPercent = ((decimal)(currentIndex + 1) / lessonIds.Count) * 100;
                }

                // Check if UserProgress entry exists
                string checkQuery = "SELECT ID FROM UserProgress WHERE UserID = @UserID AND ModuleID = @ModuleID";
                SqlCommand comm2 = new SqlCommand(checkQuery, conn);
                comm2.Parameters.AddWithValue("@UserID", userId);
                comm2.Parameters.AddWithValue("@ModuleID", moduleId);
                object result = comm2.ExecuteScalar();
                
                int progressId = result != null ? Convert.ToInt32(result) : 0;

                // Update or insert UserProgress
                if (progressId > 0)
                {
                    string updateQuery = "UPDATE UserProgress SET ProgressPercent = @ProgressPercent, UpdatedAt = GETDATE() WHERE ID = @ProgressID";
                    SqlCommand comm3 = new SqlCommand(updateQuery, conn);
                    comm3.Parameters.AddWithValue("@ProgressPercent", progressPercent);
                    comm3.Parameters.AddWithValue("@ProgressID", progressId);
                    comm3.ExecuteNonQuery();
                }
                else
                {
                    string insertQuery = "INSERT INTO UserProgress (UserID, ModuleID, ProgressPercent, UpdatedAt) VALUES (@UserID, @ModuleID, @ProgressPercent, GETDATE())";
                    SqlCommand comm4 = new SqlCommand(insertQuery, conn);
                    comm4.Parameters.AddWithValue("@UserID", userId);
                    comm4.Parameters.AddWithValue("@ModuleID", moduleId);
                    comm4.Parameters.AddWithValue("@ProgressPercent", progressPercent);
                    comm4.ExecuteNonQuery();
                }
            }
            catch (Exception)
            {
                // Silently fail progress update
            }
            finally
            {
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }
        }
    }
}