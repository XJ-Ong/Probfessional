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
                    using (SqlCommand cmd = new SqlCommand(allLessonsQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@ModuleID", moduleId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            var lessonList = new System.Collections.Generic.List<(string ID, string Title)>();
                            while (reader.Read())
                            {
                                lessonList.Add((reader["ID"].ToString(), reader["Title"].ToString()));
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
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "An error occurred while loading lesson: " + ex.Message;
            }
        }
    }
}