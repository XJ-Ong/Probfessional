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
    public partial class Rank : System.Web.UI.Page
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
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT ID, Title FROM Modules ORDER BY Title";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        ddlModules.Items.Clear();
                        ddlModules.Items.Add(new ListItem("-- Select Module --", "0"));
                        while (reader.Read())
                        {
                            ddlModules.Items.Add(new ListItem(reader["Title"].ToString(), reader["ID"].ToString()));
                        }
                    }
                }

                // Load rankings for first module if available
                if (ddlModules.Items.Count > 1)
                {
                    ddlModules.SelectedIndex = 1; // Select first module (skip "-- Select Module --")
                    LoadRankings();
                }
            }
            catch (Exception ex)
            {
                lblNoData.Visible = true;
                lblNoData.Text = "Error loading modules: " + ex.Message;
            }
        }

        protected void ddlModules_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadRankings();
        }

        private void LoadRankings()
        {
            try
            {
                int moduleId = Convert.ToInt32(ddlModules.SelectedValue);
                
                if (moduleId <= 0)
                {
                    rptRankings.DataSource = null;
                    rptRankings.DataBind();
                    lblNoData.Visible = true;
                    return;
                }

                List<RankingData> rankings = new List<RankingData>();
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Get quiz ID for this module
                    int? quizId = null;
                    string quizQuery = "SELECT TOP 1 ID FROM Quiz WHERE ModuleID = @ModuleID";
                    using (SqlCommand cmd = new SqlCommand(quizQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@ModuleID", moduleId);
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            quizId = (int)result;
                        }
                    }

                    if (quizId.HasValue)
                    {
                        // Get top 100 quiz attempts for this quiz
                        string rankingsQuery = @"
                            SELECT TOP 100 
                                u.DisplayName AS UserName,
                                qa.Score,
                                qa.TakenTime AS TakenAt,
                                ROW_NUMBER() OVER (ORDER BY qa.Score DESC, qa.TakenTime ASC) AS RankNum
                            FROM QuizAttempts qa
                            INNER JOIN Users u ON qa.UserID = u.ID
                            WHERE qa.QuizID = @QuizID
                            ORDER BY qa.Score DESC, qa.TakenTime ASC";

                        using (SqlCommand cmd = new SqlCommand(rankingsQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@QuizID", quizId.Value);
                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                while (reader.Read())
                                {
                                    rankings.Add(new RankingData
                                    {
                                        Rank = Convert.ToInt32(reader["RankNum"]),
                                        UserName = reader["UserName"].ToString(),
                                        Score = Convert.ToDecimal(reader["Score"]),
                                        TakenAt = Convert.ToDateTime(reader["TakenAt"])
                                    });
                                }
                            }
                        }
                    }
                }

                if (rankings.Count > 0)
                {
                    rptRankings.DataSource = rankings;
                    rptRankings.DataBind();
                    lblNoData.Visible = false;
                }
                else
                {
                    rptRankings.DataSource = null;
                    rptRankings.DataBind();
                    lblNoData.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblNoData.Visible = true;
                lblNoData.Text = "Error loading rankings: " + ex.Message;
            }
        }

        private class RankingData
        {
            public int Rank { get; set; }
            public string UserName { get; set; }
            public decimal Score { get; set; }
            public DateTime TakenAt { get; set; }
        }
    }
}
