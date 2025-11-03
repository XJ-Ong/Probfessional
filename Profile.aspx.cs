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
    public partial class Profile : System.Web.UI.Page
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
                LoadUserProfile();
                LoadStats();
                LoadModuleProgress();
                LoadBadges();
                LoadQuizHistory();
                LoadAccountInfo();
            }
        }

        private void LoadUserProfile()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT DisplayName, Email, Role, CreatedAt, IsActive FROM Users WHERE ID = @UserID";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string displayName = reader["DisplayName"].ToString();
                                string email = reader["Email"].ToString();
                                string role = reader["Role"].ToString();
                                
                                profileName.InnerText = displayName;
                                profileEmail.InnerText = email;
                                
                                // Set avatar initials
                                avatarInitials.InnerText = GetInitials(displayName);
                                
                                // Set role badge
                                profileRole.InnerText = role;
                                profileRole.Attributes["class"] = "profile-role " + role.ToLower();
                                
                                // Set account status
                                bool isActive = Convert.ToBoolean(reader["IsActive"]);
                                accountStatus.InnerText = isActive ? "Active" : "Inactive";
                                accountStatus.Style["color"] = isActive ? "#10b981" : "#ef4444";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                profileName.InnerText = "Error loading profile";
                System.Diagnostics.Debug.WriteLine("Profile load error: " + ex.Message);
            }
        }

        private void LoadStats()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Get modules completed (100% progress)
                    int modulesCompleted = 0;
                    string moduleQuery = @"
                        SELECT COUNT(DISTINCT ModuleID) as ModuleCount
                        FROM UserProgress
                        WHERE UserID = @UserID AND ProgressPercent >= 100";
                    using (SqlCommand cmd = new SqlCommand(moduleQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            modulesCompleted = Convert.ToInt32(result);
                        }
                    }
                    statModulesCompleted.InnerText = modulesCompleted.ToString();
                    
                    // Get quizzes taken
                    int quizzesTaken = 0;
                    string quizQuery = "SELECT COUNT(*) FROM QuizAttempts WHERE UserID = @UserID";
                    using (SqlCommand cmd = new SqlCommand(quizQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            quizzesTaken = Convert.ToInt32(result);
                        }
                    }
                    statQuizzesTaken.InnerText = quizzesTaken.ToString();
                    
                    // Get average score
                    decimal averageScore = 0;
                    if (quizzesTaken > 0)
                    {
                        string avgQuery = "SELECT AVG(Score) FROM QuizAttempts WHERE UserID = @UserID";
                        using (SqlCommand cmd = new SqlCommand(avgQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@UserID", userId);
                            object result = cmd.ExecuteScalar();
                            if (result != null && result != DBNull.Value)
                            {
                                averageScore = Convert.ToDecimal(result);
                            }
                        }
                    }
                    statAverageScore.InnerText = averageScore.ToString("F0") + "%";
                    
                    // Badges earned (placeholder - would need a separate badges table)
                    statBadgesEarned.InnerText = modulesCompleted.ToString(); // Using completed modules as badge count
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Stats load error: " + ex.Message);
            }
        }

        private void LoadModuleProgress()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"
                        SELECT m.Title, ISNULL(up.ProgressPercent, 0) as Progress
                        FROM Modules m
                        LEFT JOIN UserProgress up ON m.ID = up.ModuleID AND up.UserID = @UserID
                        ORDER BY m.ID";
                    
                    System.Text.StringBuilder html = new System.Text.StringBuilder();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string title = reader["Title"].ToString();
                                decimal progress = Convert.ToDecimal(reader["Progress"]);
                                
                                html.Append("<div class='module-progress-item'>");
                                html.Append("<div class='module-progress-header'>");
                                html.Append("<div class='module-progress-name'>" + System.Web.HttpUtility.HtmlEncode(title) + "</div>");
                                html.Append("<div class='module-progress-percent'>" + progress.ToString("F0") + "%</div>");
                                html.Append("</div>");
                                html.Append("<div class='progress-bar-container'>");
                                html.Append("<div class='progress-bar-fill' style='width: " + progress + "%'></div>");
                                html.Append("</div>");
                                html.Append("</div>");
                            }
                        }
                    }
                    moduleProgressList.InnerHtml = html.ToString();
                }
            }
            catch (Exception ex)
            {
                moduleProgressList.InnerHtml = "<p style='color: #718096;'>Error loading progress.</p>";
                System.Diagnostics.Debug.WriteLine("Progress load error: " + ex.Message);
            }
        }

        private void LoadBadges()
        {
            // Placeholder badges - in real implementation, would load from a badges table
            System.Text.StringBuilder html = new System.Text.StringBuilder();
            
            var badges = new[]
            {
                new { Icon = "🎯", Name = "First Quiz", Description = "Complete your first quiz", Earned = true },
                new { Icon = "🏆", Name = "Perfect Score", Description = "Score 100% on any quiz", Earned = false },
                new { Icon = "📚", Name = "Module Master", Description = "Complete all modules", Earned = false },
                new { Icon = "⚡", Name = "Speed Learner", Description = "Complete a module in one day", Earned = false },
                new { Icon = "🔥", Name = "On Fire", Description = "Take 5 quizzes in a row", Earned = false }
            };
            
            foreach (var badge in badges)
            {
                html.Append("<div class='badge-card " + (badge.Earned ? "earned" : "locked") + "'>");
                html.Append("<div class='badge-icon'>" + badge.Icon + "</div>");
                html.Append("<div class='badge-name'>" + badge.Name + "</div>");
                html.Append("<div class='badge-description'>" + badge.Description + "</div>");
                html.Append("</div>");
            }
            
            badgesGrid.InnerHtml = html.ToString();
        }

        private void LoadQuizHistory()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"
                        SELECT TOP 10 q.Title AS QuizTitle, qa.Score, qa.TakenTime
                        FROM QuizAttempts qa
                        INNER JOIN Quiz q ON qa.QuizID = q.ID
                        WHERE qa.UserID = @UserID
                        ORDER BY qa.TakenTime DESC";
                    
                    System.Text.StringBuilder html = new System.Text.StringBuilder();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    string title = reader["QuizTitle"].ToString();
                                    decimal score = Convert.ToDecimal(reader["Score"]);
                                    DateTime taken = Convert.ToDateTime(reader["TakenTime"]);
                                    
                                    string scoreClass = score >= 70 ? "passing" : "failing";
                                    
                                    html.Append("<div class='quiz-history-item'>");
                                    html.Append("<div class='quiz-info'>");
                                    html.Append("<div class='quiz-name'>" + System.Web.HttpUtility.HtmlEncode(title) + "</div>");
                                    html.Append("<div class='quiz-date'>" + taken.ToString("MMM dd, yyyy") + "</div>");
                                    html.Append("</div>");
                                    html.Append("<div class='quiz-score " + scoreClass + "'>" + score.ToString("F0") + "%</div>");
                                    html.Append("</div>");
                                }
                            }
                            else
                            {
                                html.Append("<p style='color: #718096; text-align: center; padding: 20px;'>No quiz history yet.</p>");
                            }
                        }
                    }
                    quizHistoryList.InnerHtml = html.ToString();
                }
            }
            catch (Exception ex)
            {
                quizHistoryList.InnerHtml = "<p style='color: #718096;'>Error loading history.</p>";
                System.Diagnostics.Debug.WriteLine("History load error: " + ex.Message);
            }
        }

        private void LoadAccountInfo()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT CreatedAt FROM Users WHERE ID = @UserID";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                DateTime createdAt = Convert.ToDateTime(reader["CreatedAt"]);
                                memberSince.InnerText = createdAt.ToString("MMM dd, yyyy");
                                lastActivity.InnerText = DateTime.Now.ToString("MMM dd, yyyy");
                            }
                        }
                    }
                    
                    // Get total progress (average of all module progress)
                    string progressQuery = "SELECT AVG(ProgressPercent) FROM UserProgress WHERE UserID = @UserID";
                    using (SqlCommand cmd = new SqlCommand(progressQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            decimal avgProgress = Convert.ToDecimal(result);
                            totalProgressValue.InnerText = avgProgress.ToString("F0") + "%";
                        }
                        else
                        {
                            totalProgressValue.InnerText = "0%";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Account info load error: " + ex.Message);
            }
        }

        private string GetInitials(string name)
        {
            if (string.IsNullOrWhiteSpace(name))
                return "U";
            
            string[] parts = name.Split(' ');
            if (parts.Length >= 2)
            {
                return (parts[0][0].ToString() + parts[parts.Length - 1][0].ToString()).ToUpper();
            }
            return name.Substring(0, Math.Min(2, name.Length)).ToUpper();
        }
    }
}
