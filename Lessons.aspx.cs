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

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // First, get the lesson and its module
                    string lessonQuery = "SELECT l.ID, l.Title, l.Content, l.ModuleID FROM Lessons l WHERE l.ID = @LessonID";
                    int moduleId = 0;
                    using (SqlCommand cmd = new SqlCommand(lessonQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@LessonID", lessonId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lessonTitle.InnerText = reader["Title"].ToString();
                                lessonContent.InnerHtml = reader["Content"].ToString();
                                moduleId = Convert.ToInt32(reader["ModuleID"]);
                            }
                            else
                            {
                                lblError.Visible = true;
                                lblError.Text = "Lesson not found.";
                                return;
                            }
                        }
                    }

                    // Get all lessons in the module ordered by ID
                    string allLessonsQuery = "SELECT ID, Title FROM Lessons WHERE ModuleID = @ModuleID ORDER BY ID";
                    var lessonList = new System.Collections.Generic.List<(string ID, string Title)>();
                    using (SqlCommand cmd = new SqlCommand(allLessonsQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@ModuleID", moduleId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                lessonList.Add((reader["ID"].ToString(), reader["Title"].ToString()));
                            }
                        }
                    }

                    // Find current lesson index
                    int currentIndex = lessonList.FindIndex(l => l.ID == lessonId);
                    
                    // Set previous button
                    if (currentIndex > 0)
                    {
                        var (prevId, prevTitle) = lessonList[currentIndex - 1];
                        prevLesson.InnerHtml = $"<a href='Lessons.aspx?id={prevId}' class='btn-navigation btn-prev'><span>‹</span> Previous</a>";
                    }

                    // Set next button
                    if (currentIndex < lessonList.Count - 1)
                    {
                        var (nextId, nextTitle) = lessonList[currentIndex + 1];
                        nextLesson.InnerHtml = $"<a href='Lessons.aspx?id={nextId}' class='btn-navigation btn-next'>Next <span>›</span></a>";
                    }

                    // Update user progress if logged in
                    if (Session["UserID"] != null)
                    {
                        UpdateUserProgress(conn, moduleId, lessonList.Count);
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "An error occurred while loading lesson: " + ex.Message;
            }
        }

        private void UpdateUserProgress(SqlConnection conn, int moduleId, int totalLessons)
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                
                // Calculate progress: (lesson number / total lessons) * 100
                // Since they're viewing this lesson, progress is based on current lesson position
                // Get all lesson IDs ordered by ID
                string lessonQuery = "SELECT ID FROM Lessons WHERE ModuleID = @ModuleID ORDER BY ID";
                var lessonIds = new List<int>();
                using (SqlCommand cmd = new SqlCommand(lessonQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@ModuleID", moduleId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            lessonIds.Add(Convert.ToInt32(reader["ID"]));
                        }
                    }
                }

                // Get the current lesson ID
                string currentLessonId = Request.QueryString["id"];
                if (string.IsNullOrEmpty(currentLessonId))
                    return;

                // Find the position of the current lesson
                int currentIndex = lessonIds.IndexOf(Convert.ToInt32(currentLessonId));
                decimal progressPercent = 0;

                // Calculate progress based on current lesson viewed
                if (lessonIds.Count > 0)
                {
                    // Progress is the percentage of lessons completed (0-based index + 1)
                    progressPercent = ((decimal)(currentIndex + 1) / lessonIds.Count) * 100;
                }

                // Check if UserProgress entry exists for this user and module
                string checkQuery = "SELECT ID FROM UserProgress WHERE UserID = @UserID AND ModuleID = @ModuleID";
                int progressId = 0;
                using (SqlCommand cmd = new SqlCommand(checkQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@ModuleID", moduleId);
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        progressId = Convert.ToInt32(result);
                    }
                }

                // Update or insert UserProgress
                if (progressId > 0)
                {
                    string updateQuery = "UPDATE UserProgress SET ProgressPercent = @ProgressPercent, UpdatedAt = GETDATE() WHERE ID = @ProgressID";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@ProgressPercent", progressPercent);
                        cmd.Parameters.AddWithValue("@ProgressID", progressId);
                        cmd.ExecuteNonQuery();
                    }
                }
                else
                {
                    string insertQuery = "INSERT INTO UserProgress (UserID, ModuleID, ProgressPercent, UpdatedAt) VALUES (@UserID, @ModuleID, @ProgressPercent, GETDATE())";
                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.Parameters.AddWithValue("@ModuleID", moduleId);
                        cmd.Parameters.AddWithValue("@ProgressPercent", progressPercent);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception)
            {
                // Silently fail progress update - don't break the lesson view
            }
        }
    }
}