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
            // Check if user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Show Create Quiz button only for teachers
            if (Session["Role"] != null && Session["Role"].ToString() == "Teacher")
            {
                divCreateQuiz.Visible = true;
            }
            else
            {
                divCreateQuiz.Visible = false;
            }

            if (!IsPostBack)
            {
                // This will be handled in PreRender to ensure dropdown is populated first
            }
            else
            {
                LoadQuizData();
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (!IsPostBack && ddlModules.Items.Count > 0)
            {
                // Check if moduleId is passed in query string
                string moduleIdParam = Request.QueryString["moduleId"];
                int selectedModuleId;
                
                if (!string.IsNullOrEmpty(moduleIdParam))
                {
                    if (int.TryParse(moduleIdParam, out selectedModuleId))
                    {
                        ddlModules.SelectedValue = selectedModuleId.ToString();
                        LoadQuizForModule(selectedModuleId);
                    }
                }
                else if (ddlModules.Items.Count > 1)
                {
                    // Load Poker quiz by default (ModuleID = 1)
                    ddlModules.SelectedValue = "1";
                    LoadQuizForModule(1);
                }
            }
        }

        protected void ddlModules_DataBound(object sender, EventArgs e)
        {
            // Add default item at the beginning
            ddlModules.Items.Insert(0, new ListItem("-- Select Module --", "0"));
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
            
            // Step 2: Create connection
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);

            try
            {
                // Step 3: Open connection
                conn.Open();

                // Step 4: Prepare SqlCommand
                string quizQuery = "SELECT ID, Title FROM Quiz WHERE ModuleID = @ModuleID";
                SqlCommand comm = new SqlCommand(quizQuery, conn);
                comm.Parameters.AddWithValue("@ModuleID", moduleId);

                // Step 5: Execute reader
                SqlDataReader reader = comm.ExecuteReader();
                int quizCount = 0;
                while (reader.Read())
                {
                    if (quizCount == 0)
                    {
                        quizId = Convert.ToInt32(reader["ID"]);
                        quizTitle.InnerText = reader["Title"].ToString();
                        reader.Close();
                        LoadQuizQuestions();
                        return;
                    }
                    quizCount++;
                }
                reader.Close();
                
                if (quizCount == 0)
                {
                    lblValidationError.Visible = true;
                    lblValidationError.Text = "No quiz found for this module.";
                    ClearQuiz();
                }
            }
            catch (Exception ex)
            {
                lblValidationError.Visible = true;
                lblValidationError.Text = "Error loading quiz: " + ex.Message;
                ClearQuiz();
            }
            finally
            {
                // Step 6: Close connection
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }
        }

        private void LoadQuizQuestions()
        {
            quizQuestions.Clear();
            
            // Step 2: Create connection
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);

            try
            {
                // Step 3: Open connection
                conn.Open();

                // Step 4: Prepare SqlCommand
                string query = "SELECT ID, QuestionText, ChoiceA, ChoiceB, ChoiceC, ChoiceD, CorrectChoice FROM QuizQuestion WHERE QuizID = @QuizID ORDER BY ID";
                SqlCommand comm = new SqlCommand(query, conn);
                comm.Parameters.AddWithValue("@QuizID", quizId);

                // Step 5: Execute reader
                SqlDataReader reader = comm.ExecuteReader();
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
                reader.Close();

                Session["QuizQuestions"] = quizQuestions;
                Session["QuizID"] = quizId;
                Session["ModuleID"] = moduleId;
                currentQuestionIndex = 0;
                Session["CurrentQuestionIndex"] = currentQuestionIndex;
                Session["QuizAnswers"] = new Dictionary<int, string>();
                
                DisplayCurrentQuestion();
            }
            catch (Exception ex)
            {
                lblValidationError.Visible = true;
                lblValidationError.Text = "Error loading questions: " + ex.Message;
            }
            finally
            {
                // Step 6: Close connection
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
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
                
                // Get saved answer if exists
                string savedAnswer = "";
                if (Session["QuizAnswers"] != null)
                {
                    var answers = (Dictionary<int, string>)Session["QuizAnswers"];
                    if (answers.ContainsKey(question.ID))
                    {
                        savedAnswer = answers[question.ID];
                    }
                }
                
                // Update page indicator
                litPageInfo.Text = $"Question {currentQuestionIndex + 1} of {quizQuestions.Count}";
                
                // Clear previous controls
                phQuestions.Controls.Clear();
                
                // Create question container
                Panel questionPanel = new Panel();
                questionPanel.CssClass = "mb-4 p-3 border";
                
                // Question text label
                Label lblQuestion = new Label();
                lblQuestion.Text = System.Security.SecurityElement.Escape(question.QuestionText);
                lblQuestion.CssClass = "fw-bold mb-3 d-block";
                questionPanel.Controls.Add(lblQuestion);
                
                // Create RadioButtonList for choices
                RadioButtonList rdolChoices = new RadioButtonList();
                rdolChoices.ID = "rdolQuestion" + question.ID;
                rdolChoices.CssClass = "form-check mb-3";
                rdolChoices.RepeatLayout = RepeatLayout.UnorderedList;
                rdolChoices.CellSpacing = 10; // Add spacing between choices
                
                if (!string.IsNullOrEmpty(question.ChoiceA))
                {
                    ListItem itemA = new ListItem("&nbsp;&nbsp;A. " + System.Security.SecurityElement.Escape(question.ChoiceA), "A");
                    if (savedAnswer == "A") itemA.Selected = true;
                    rdolChoices.Items.Add(itemA);
                }
                if (!string.IsNullOrEmpty(question.ChoiceB))
                {
                    ListItem itemB = new ListItem("&nbsp;&nbsp;B. " + System.Security.SecurityElement.Escape(question.ChoiceB), "B");
                    if (savedAnswer == "B") itemB.Selected = true;
                    rdolChoices.Items.Add(itemB);
                }
                if (!string.IsNullOrEmpty(question.ChoiceC))
                {
                    ListItem itemC = new ListItem("&nbsp;&nbsp;C. " + System.Security.SecurityElement.Escape(question.ChoiceC), "C");
                    if (savedAnswer == "C") itemC.Selected = true;
                    rdolChoices.Items.Add(itemC);
                }
                if (!string.IsNullOrEmpty(question.ChoiceD))
                {
                    ListItem itemD = new ListItem("&nbsp;&nbsp;D. " + System.Security.SecurityElement.Escape(question.ChoiceD), "D");
                    if (savedAnswer == "D") itemD.Selected = true;
                    rdolChoices.Items.Add(itemD);
                }
                
                questionPanel.Controls.Add(rdolChoices);
                phQuestions.Controls.Add(questionPanel);
                
                // Store question ID for later retrieval
                ViewState["CurrentQuestionID"] = question.ID;
                
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
            SaveCurrentAnswer();
            currentQuestionIndex--;
            Session["CurrentQuestionIndex"] = currentQuestionIndex;
            DisplayCurrentQuestion();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            SaveCurrentAnswer();
            currentQuestionIndex++;
            Session["CurrentQuestionIndex"] = currentQuestionIndex;
            DisplayCurrentQuestion();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SaveCurrentAnswer();
            ShowQuizResults();
        }

        private void SaveCurrentAnswer()
        {
            if (quizQuestions.Count > 0 && currentQuestionIndex < quizQuestions.Count)
            {
                int questionId = quizQuestions[currentQuestionIndex].ID;
                
                // Find the RadioButtonList control
                RadioButtonList rdolChoices = phQuestions.FindControl("rdolQuestion" + questionId) as RadioButtonList;
                if (rdolChoices != null && !string.IsNullOrEmpty(rdolChoices.SelectedValue))
                {
                    string selectedAnswer = rdolChoices.SelectedValue;
                    Dictionary<int, string> answers = Session["QuizAnswers"] as Dictionary<int, string>;
                    if (answers == null)
                    {
                        answers = new Dictionary<int, string>();
                    }
                    answers[questionId] = selectedAnswer;
                    Session["QuizAnswers"] = answers;
                }
            }
        }

        private void ShowQuizResults()
        {
            if (quizQuestions.Count == 0)
            {
                return;
            }

            Dictionary<int, string> userAnswers = Session["QuizAnswers"] as Dictionary<int, string> ?? new Dictionary<int, string>();
            int correctCount = 0;
            int totalQuestions = quizQuestions.Count;

            // Build results HTML
            System.Text.StringBuilder resultsHtml = new System.Text.StringBuilder();
            resultsHtml.Append("<div style='background: white; border: 2px solid #e2e8f0; border-radius: 12px; padding: 30px;'>");
            resultsHtml.Append("<h2 style='color: #2d3748; margin-bottom: 25px; text-align: center;'>Quiz Results</h2>");

            // Display each question with result
            for (int i = 0; i < quizQuestions.Count; i++)
            {
                QuizQuestion question = quizQuestions[i];
                string userAnswer = userAnswers.ContainsKey(question.ID) ? userAnswers[question.ID] : "";
                bool isCorrect = userAnswer == question.CorrectChoice;

                if (isCorrect)
                {
                    correctCount++;
                }

                resultsHtml.Append("<div style='margin-bottom: 30px; padding: 20px; border: 2px solid " + (isCorrect ? "#48bb78" : "#f56565") + "; border-radius: 8px; background: " + (isCorrect ? "#f0fff4" : "#fff5f5") + ";'>");
                resultsHtml.Append("<div style='display: flex; align-items: center; margin-bottom: 15px;'>");
                resultsHtml.Append("<span style='background: " + (isCorrect ? "#48bb78" : "#f56565") + "; color: white; font-weight: bold; padding: 5px 12px; border-radius: 20px; margin-right: 15px;'>");
                resultsHtml.Append(isCorrect ? "✓ Correct" : "✗ Incorrect");
                resultsHtml.Append("</span>");
                resultsHtml.Append("<strong style='color: #2d3748;'>Question " + (i + 1) + "</strong>");
                resultsHtml.Append("</div>");

                resultsHtml.Append("<div style='font-size: 1.1rem; color: #2d3748; margin-bottom: 15px;'>" + System.Security.SecurityElement.Escape(question.QuestionText) + "</div>");

                // Show all options with styling
                string[] choices = { question.ChoiceA, question.ChoiceB, question.ChoiceC, question.ChoiceD };
                string[] choiceLetters = { "A", "B", "C", "D" };

                foreach (int j in Enumerable.Range(0, 4))
                {
                    if (!string.IsNullOrEmpty(choices[j]))
                    {
                        bool isSelected = userAnswer == choiceLetters[j];
                        bool isCorrectAnswer = question.CorrectChoice == choiceLetters[j];

                        string optionStyle = "";
                        string icon = "";

                        if (isCorrectAnswer)
                        {
                            optionStyle = "background: #d4edda; border-color: #48bb78; font-weight: bold;";
                            icon = "✓ ";
                        }
                        else if (isSelected && !isCorrectAnswer)
                        {
                            optionStyle = "background: #f8d7da; border-color: #f56565;";
                            icon = "✗ ";
                        }

                        resultsHtml.Append("<div style='padding: 12px; margin-bottom: 8px; border: 2px solid #e2e8f0; border-radius: 8px; " + optionStyle + "'>");
                        resultsHtml.Append(icon + "<strong>" + choiceLetters[j] + ":</strong> " + System.Security.SecurityElement.Escape(choices[j]));
                        resultsHtml.Append("</div>");
                    }
                }

                resultsHtml.Append("</div>");
            }

            // Display score summary
            double scorePercentage = (correctCount * 100.0) / totalQuestions;
            string gradeColor = scorePercentage >= 70 ? "#48bb78" : scorePercentage >= 50 ? "#f39c12" : "#f56565";
            string gradeText = scorePercentage >= 70 ? "Excellent!" : scorePercentage >= 50 ? "Good Effort!" : "Keep Practicing!";

            // Save quiz attempt to database if user is logged in
            if (Session["UserID"] != null)
            {
                SaveQuizAttempt(correctCount, totalQuestions, scorePercentage);
            }

            resultsHtml.Append("<div style='text-align: center; padding: 25px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 10px; color: white; margin-top: 20px;'>");
            resultsHtml.Append("<div style='font-size: 3rem; font-weight: bold; margin-bottom: 10px;'>" + correctCount + " / " + totalQuestions + "</div>");
            resultsHtml.Append("<div style='font-size: 1.5rem; margin-bottom: 5px;'>Score: " + scorePercentage.ToString("F1") + "%</div>");
            resultsHtml.Append("<div style='font-size: 1.2rem;'>" + gradeText + "</div>");
            resultsHtml.Append("</div>");

            resultsHtml.Append("</div>");

            phQuestions.Controls.Clear();
            phQuestions.Controls.Add(new LiteralControl(resultsHtml.ToString()));

            // Hide navigation buttons
            btnPrevious.Visible = false;
            btnNext.Visible = false;
            btnSubmit.Visible = false;
            litPageInfo.Text = "Quiz Completed";

            // Hide module selector and title to focus on results
            ddlModules.Visible = false;
            quizTitle.Visible = false;
        }

        private void SaveQuizAttempt(int correctCount, int totalQuestions, double scorePercentage)
        {
            // Step 2: Create connection
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);

            try
            {
                // Step 3: Open connection
                conn.Open();

                // Step 4: Prepare SqlCommand
                string query = @"INSERT INTO [QuizAttempts] ([UserID], [QuizID], [Score], [TakenTime]) 
                                 VALUES (@UserID, @QuizID, @Score, GETDATE())";
                SqlCommand comm = new SqlCommand(query, conn);
                comm.Parameters.AddWithValue("@UserID", Session["UserID"]);
                comm.Parameters.AddWithValue("@QuizID", quizId);
                comm.Parameters.AddWithValue("@Score", (decimal)scorePercentage);

                // Step 5: Execute non-query
                comm.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                // Log error but don't prevent user from seeing results
                System.Diagnostics.Debug.WriteLine("Error saving quiz attempt: " + ex.Message);
            }
            finally
            {
                // Step 6: Close connection
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }
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
            Session["QuizAnswers"] = null;
        }
    }
}