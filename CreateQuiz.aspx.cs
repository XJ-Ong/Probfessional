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
    public partial class CreateQuiz : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Check if user is a teacher
            if (Session["Role"] == null || Session["Role"].ToString() != "Teacher")
            {
                lblError.Visible = true;
                lblError.Text = "Access denied. Only teachers can create quizzes.";
                pnlQuizForm.Visible = false;
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
                        ddlModule.Items.Clear();
                        ddlModule.Items.Add(new ListItem("-- Select Module --", "0"));
                        while (reader.Read())
                        {
                            ddlModule.Items.Add(new ListItem(reader["Title"].ToString(), reader["ID"].ToString()));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "Error loading modules: " + ex.Message;
            }
        }

        protected void btnSubmitQuiz_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            try
            {
                // Get form data
                int moduleId = Convert.ToInt32(ddlModule.SelectedValue);
                
                // Validate module selection
                if (moduleId <= 0)
                {
                    lblError.Visible = true;
                    lblError.Text = "Please select a valid module.";
                    return;
                }
                
                // Auto-generate quiz title from module name
                string moduleTitle = ddlModule.SelectedItem.Text;
                string quizTitle = moduleTitle + " Quiz";

                // Get all questions from the form
                List<QuizQuestionData> questions = GetQuestionsFromForm();

                if (questions.Count == 0)
                {
                    lblError.Visible = true;
                    lblError.Text = "Please add at least one question to the quiz.";
                    return;
                }

                // Save to database
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Insert quiz
                    int quizId;
                    string insertQuizQuery = "INSERT INTO [Quiz] ([ModuleID], [Title]) VALUES (@ModuleID, @Title); SELECT CAST(SCOPE_IDENTITY() as int);";
                    using (SqlCommand cmd = new SqlCommand(insertQuizQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@ModuleID", moduleId);
                        cmd.Parameters.AddWithValue("@Title", quizTitle);
                        quizId = (int)cmd.ExecuteScalar();
                    }

                    // Insert questions
                    string insertQuestionQuery = @"INSERT INTO [QuizQuestion] ([QuizID], [QuestionText], [ChoiceA], [ChoiceB], [ChoiceC], [ChoiceD], [CorrectChoice]) 
                                                   VALUES (@QuizID, @QuestionText, @ChoiceA, @ChoiceB, @ChoiceC, @ChoiceD, @CorrectChoice)";

                    foreach (var question in questions)
                    {
                        using (SqlCommand cmd = new SqlCommand(insertQuestionQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@QuizID", quizId);
                            cmd.Parameters.AddWithValue("@QuestionText", question.QuestionText);
                            cmd.Parameters.AddWithValue("@ChoiceA", question.ChoiceA);
                            cmd.Parameters.AddWithValue("@ChoiceB", question.ChoiceB);
                            cmd.Parameters.AddWithValue("@ChoiceC", question.ChoiceC);
                            cmd.Parameters.AddWithValue("@ChoiceD", question.ChoiceD);
                            cmd.Parameters.AddWithValue("@CorrectChoice", question.CorrectChoice);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                // Show success message
                pnlQuizForm.Visible = false;
                pnlSuccess.Visible = true;
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "Error creating quiz: " + ex.Message;
                System.Diagnostics.Debug.WriteLine("Quiz creation error: " + ex.ToString());
            }
        }

        private List<QuizQuestionData> GetQuestionsFromForm()
        {
            List<QuizQuestionData> questions = new List<QuizQuestionData>();

            // Get all question cards
            var questionCards = Request.Form.AllKeys
                .Where(key => key.StartsWith("question-text-"))
                .ToList();

            foreach (var questionKey in questionCards)
            {
                // Extract question number
                string questionNum = questionKey.Replace("question-text-", "");

                // Get question text
                string questionText = Request.Form[questionKey];

                // Skip if question text is empty
                if (string.IsNullOrWhiteSpace(questionText))
                    continue;

                // Get correct answer
                string correctAnswer = Request.Form[$"correct-{questionNum}"];

                // Get options
                string choiceA = Request.Form[$"option-{questionNum}-A"] ?? "";
                string choiceB = Request.Form[$"option-{questionNum}-B"] ?? "";
                string choiceC = Request.Form[$"option-{questionNum}-C"] ?? "";
                string choiceD = Request.Form[$"option-{questionNum}-D"] ?? "";

                // Skip if any required field is missing
                if (string.IsNullOrWhiteSpace(correctAnswer) ||
                    string.IsNullOrWhiteSpace(choiceA) ||
                    string.IsNullOrWhiteSpace(choiceB) ||
                    string.IsNullOrWhiteSpace(choiceC) ||
                    string.IsNullOrWhiteSpace(choiceD))
                    continue;

                questions.Add(new QuizQuestionData
                {
                    QuestionText = questionText,
                    ChoiceA = choiceA,
                    ChoiceB = choiceB,
                    ChoiceC = choiceC,
                    ChoiceD = choiceD,
                    CorrectChoice = correctAnswer
                });
            }

            return questions;
        }

        private class QuizQuestionData
        {
            public string QuestionText { get; set; }
            public string ChoiceA { get; set; }
            public string ChoiceB { get; set; }
            public string ChoiceC { get; set; }
            public string ChoiceD { get; set; }
            public string CorrectChoice { get; set; }
        }
    }
}
