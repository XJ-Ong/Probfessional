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
                string query = "SELECT ID, Title FROM Modules ORDER BY Title";
                SqlCommand comm = new SqlCommand(query, conn);
                // Step 5: Execute reader
                SqlDataReader reader = comm.ExecuteReader();

                ddlModules.Items.Clear();
                ddlModules.Items.Add(new ListItem("-- Select Module --", "0"));

                while (reader.Read())
                {
                    ddlModules.Items.Add(new ListItem(reader["Title"].ToString(), reader["ID"].ToString()));
                }
                reader.Close();

                if (ddlModules.Items.Count > 1)
                {
                    ddlModules.SelectedIndex = 1;
                    LoadRankings();
                }
            }
            catch (Exception ex)
            {
                lblNoData.Visible = true;
                lblNoData.Text = "Error loading modules: " + ex.Message;
            }
            finally
            {
                // Step 6: Close connection
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }
        }
        protected void ddlModules_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadRankings();
        }
        private void LoadRankings()
        {
            int moduleId = Convert.ToInt32(ddlModules.SelectedValue);

            if (moduleId <= 0)
            {
                rptRankings.DataSource = null;
                rptRankings.DataBind();
                lblNoData.Visible = true;
                return;
            }
            var rankings = new List<object>();

            // Step 2: Create connection
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);
            try
            {
                // Step 3: Open connection
                conn.Open();
                // Step 4: Prepare SqlCommand - Get quiz ID
                string quizQuery = "SELECT TOP 1 ID FROM Quiz WHERE ModuleID = @ModuleID";
                SqlCommand comm = new SqlCommand(quizQuery, conn);
                comm.Parameters.AddWithValue("@ModuleID", moduleId);
                // Step 5: Execute scalar
                object result = comm.ExecuteScalar();
                int? quizId = result != null ? (int?)result : null;
                if (quizId.HasValue)
                {
                    // get the top 100 quiz attempts
                    string rankingsQuery = @"SELECT TOP 100 u.DisplayName AS UserName, qa.Score, qa.TakenTime AS TakenAt, ROW_NUMBER() OVER (ORDER BY qa.Score DESC, qa.TakenTime ASC) AS RankNum FROM QuizAttempts qa INNER JOIN Users u ON qa.UserID = u.ID WHERE qa.QuizID = @QuizID ORDER BY qa.Score DESC, qa.TakenTime ASC";
                    SqlCommand comm2 = new SqlCommand(rankingsQuery, conn);
                    comm2.Parameters.AddWithValue("@QuizID", quizId.Value);
                    SqlDataReader reader = comm2.ExecuteReader();
                    while (reader.Read())
                    {
                        rankings.Add(new
                        {
                            Rank = Convert.ToInt32(reader["RankNum"]),
                            UserName = reader["UserName"].ToString(),
                            Score = Convert.ToDecimal(reader["Score"]),
                            TakenAt = Convert.ToDateTime(reader["TakenAt"])
                        });
                    }
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                lblNoData.Visible = true;
                lblNoData.Text = "Error loading rankings: " + ex.Message;
            }
            finally
            {
                // Step 6: Close connection
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
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
    }
}