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
    public partial class Quizzes : System.Web.UI.Page
    {
        private int currentQuestionIndex = 0;
        private List<QuizQuestion> quizQuestions = new List<QuizQuestion>();
        private int quizId = 0;
        private int moduleId = 0;

        public class QuizQuestion
        {
            public int ID { get; set; }
            public string QuestionText { get; set; }
            public string ChoiceA { get; set; }
            public string ChoiceB { get; set; }
            public string ChoiceC { get; set; }
            public string ChoiceD { get; set; }
            public string CorrectChoice { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadModules();
                
                // Check if moduleId is passed in query string
                string moduleIdParam = Request.QueryString["moduleId"];
                if (!string.IsNullOrEmpty(moduleIdParam))
                {
                    if (int.TryParse(moduleIdParam, out int parsedModuleId))
                    {
                        ddlModules.SelectedValue = parsedModuleId.ToString();
                        LoadQuizForModule(parsedModuleId);
                    }
                }
            }
            else
            {
                LoadQuizData();
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
                    string query = "SELECT ID, Title FROM Modules ORDER BY ID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        ddlModules.DataSource = cmd.ExecuteReader();
                        ddlModules.DataTextField = "Title";
                        ddlModules.DataValueField = "ID";
                        ddlModules.DataBind();
                        ddlModules.Items.Insert(0, new ListItem("-- Select Module --", "0"));
                    }
                }
            }
            catch (Exception ex)
            {
                lblValidationError.Visible = true;
                lblValidationError.Text = "Error loading modules: " + ex.Message;
            }
        }

        protected void ddlModules_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (int.TryParse(ddlModules.SelectedValue, out int selectedModuleId) && selectedModuleId > 0)
            {
                LoadQuizForModule(selectedModuleId);
            }
            else
            {
                ClearQuiz();
            }
        }

        private void LoadQuizForModule(int moduleId)
        {
            this.moduleId = moduleId;
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Get quiz for this module
                    string quizQuery = "SELECT ID, Title FROM Quiz WHERE ModuleID = @ModuleID";
                    using (SqlCommand cmd = new SqlCommand(quizQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@ModuleID", moduleId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                quizId = Convert.ToInt32(reader["ID"]);
                                quizTitle.InnerText = reader["Title"].ToString();
                                LoadQuizQuestions();
                            }
                            else
                            {
                                lblValidationError.Visible = true;
                                lblValidationError.Text = "No quiz found for this module.";
                                ClearQuiz();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblValidationError.Visible = true;
                lblValidationError.Text = "Error loading quiz: " + ex.Message;
                ClearQuiz();
            }
        }

        private void LoadQuizQuestions()
        {
            quizQuestions.Clear();
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT ID, QuestionText, ChoiceA, ChoiceB, ChoiceC, ChoiceD, CorrectChoice FROM QuizQuestions WHERE QuizID = @QuizID ORDER BY ID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@QuizID", quizId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                quizQuestions.Add(new QuizQuestion
                                {
                                    ID = Convert.ToInt32(reader["ID"]),
                                    QuestionText = reader["QuestionText"].ToString(),
                                    ChoiceA = reader["ChoiceA"]?.ToString() ?? "",
                                    ChoiceB = reader["ChoiceB"]?.ToString() ?? "",
                                    ChoiceC = reader["ChoiceC"]?.ToString() ?? "",
                                    ChoiceD = reader["ChoiceD"]?.ToString() ?? "",
                                    CorrectChoice = reader["CorrectChoice"]?.ToString() ?? ""
                                });
                            }
                        }
                    }
                }

                Session["QuizQuestions"] = quizQuestions;
                Session["QuizID"] = quizId;
                Session["ModuleID"] = moduleId;
                currentQuestionIndex = 0;
                Session["CurrentQuestionIndex"] = currentQuestionIndex;
                
                DisplayCurrentQuestion();
            }
            catch (Exception ex)
            {
                lblValidationError.Visible = true;
                lblValidationError.Text = "Error loading questions: " + ex.Message;
            }
        }

        private void LoadQuizData()
        {
            if (Session["QuizQuestions"] != null)
            {
                quizQuestions = (List<QuizQuestion>)Session["QuizQuestions"];
                quizId = Session["QuizID"] != null ? (int)Session["QuizID"] : 0;
                moduleId = Session["ModuleID"] != null ? (int)Session["ModuleID"] : 0;
                currentQuestionIndex = Session["CurrentQuestionIndex"] != null ? (int)Session["CurrentQuestionIndex"] : 0;
                DisplayCurrentQuestion();
            }
        }

        private void DisplayCurrentQuestion()
        {
            if (quizQuestions.Count == 0)
            {
                phQuestions.Controls.Clear();
                return;
            }

            if (currentQuestionIndex >= 0 && currentQuestionIndex < quizQuestions.Count)
            {
                QuizQuestion question = quizQuestions[currentQuestionIndex];
                
                // Update page indicator
                litPageInfo.Text = $"Question {currentQuestionIndex + 1} of {quizQuestions.Count}";
                
                // Create question card
                System.Text.StringBuilder html = new System.Text.StringBuilder();
                html.Append("<div class='question-card'>");
                html.Append($"<div class='question-text'>{System.Security.SecurityElement.Escape(question.QuestionText)}</div>");
                html.Append("<table>");
                
                if (!string.IsNullOrEmpty(question.ChoiceA))
                {
                    html.Append("<tr><td><input type='radio' id='choiceA' name='questionChoice' value='A' /><label for='choiceA'>" + System.Security.SecurityElement.Escape(question.ChoiceA) + "</label></td></tr>");
                }
                if (!string.IsNullOrEmpty(question.ChoiceB))
                {
                    html.Append("<tr><td><input type='radio' id='choiceB' name='questionChoice' value='B' /><label for='choiceB'>" + System.Security.SecurityElement.Escape(question.ChoiceB) + "</label></td></tr>");
                }
                if (!string.IsNullOrEmpty(question.ChoiceC))
                {
                    html.Append("<tr><td><input type='radio' id='choiceC' name='questionChoice' value='C' /><label for='choiceC'>" + System.Security.SecurityElement.Escape(question.ChoiceC) + "</label></td></tr>");
                }
                if (!string.IsNullOrEmpty(question.ChoiceD))
                {
                    html.Append("<tr><td><input type='radio' id='choiceD' name='questionChoice' value='D' /><label for='choiceD'>" + System.Security.SecurityElement.Escape(question.ChoiceD) + "</label></td></tr>");
                }
                
                html.Append("</table>");
                html.Append("</div>");
                
                phQuestions.Controls.Clear();
                phQuestions.Controls.Add(new LiteralControl(html.ToString()));
                
                // Show previous button if not first question
                btnPrevious.Visible = currentQuestionIndex > 0;
                
                // Show next or submit button
                if (currentQuestionIndex < quizQuestions.Count - 1)
                {
                    btnNext.Visible = true;
                    btnSubmit.Visible = false;
                }
                else
                {
                    btnNext.Visible = false;
                    btnSubmit.Visible = true;
                }
            }
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            currentQuestionIndex--;
            Session["CurrentQuestionIndex"] = currentQuestionIndex;
            DisplayCurrentQuestion();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            currentQuestionIndex++;
            Session["CurrentQuestionIndex"] = currentQuestionIndex;
            DisplayCurrentQuestion();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Save current answer before submitting
            // For now, just show a simple message
            ClientScript.RegisterStartupScript(this.GetType(), "QuizComplete", "alert('Quiz submitted! Results coming soon.');", true);
        }

        private void ClearQuiz()
        {
            quizTitle.InnerText = "";
            phQuestions.Controls.Clear();
            litPageInfo.Text = "";
            btnPrevious.Visible = false;
            btnNext.Visible = false;
            btnSubmit.Visible = false;
            quizQuestions.Clear();
            Session["QuizQuestions"] = null;
        }
    }
}