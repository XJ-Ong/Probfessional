using System;
using System.Collections.Generic;
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
                // Initialize question count
                Session["QuestionCount"] = 1;
                AddQuestionPanel();
            }
            else
            {
                // Recreate dynamically added controls on postback
                RecreateQuestionPanels();
            }
        }

        private void RecreateQuestionPanels()
        {
            // Recreate question panels based on session state
            if (Session["QuestionCount"] != null)
            {
                int count = Convert.ToInt32(Session["QuestionCount"]);
                for (int i = 1; i <= count; i++)
                {
                    CreateQuestionPanel(i);
                }
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
                
                ddlModule.Items.Clear();
                ddlModule.Items.Add(new ListItem("-- Select Module --", "0"));
                
                while (reader.Read())
                {
                    ddlModule.Items.Add(new ListItem(reader["Title"].ToString(), reader["ID"].ToString()));
                }
                reader.Close();
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "Error loading modules: " + ex.Message;
            }
            finally
            {
                // Step 6: Close connection
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }
        }

        protected void btnAddQuestion_Click(object sender, EventArgs e)
        {
            // Increment question count
            int currentCount = Session["QuestionCount"] != null ? Convert.ToInt32(Session["QuestionCount"]) : 0;
            currentCount++;
            Session["QuestionCount"] = currentCount;
            
            // Create the new question panel
            CreateQuestionPanel(currentCount);
        }

        private void AddQuestionPanel()
        {
            // Get current question count
            int questionCount = Session["QuestionCount"] != null ? Convert.ToInt32(Session["QuestionCount"]) : 1;
            CreateQuestionPanel(questionCount);
        }

        private void CreateQuestionPanel(int questionCount)
        {
            // Create question panel
            Panel questionPanel = new Panel();
            questionPanel.ID = "pnlQuestion" + questionCount;
            questionPanel.CssClass = "mb-4 p-3 border rounded";

            // Question number label
            Label lblQuestionNum = new Label();
            lblQuestionNum.Text = "Question " + questionCount + ":";
            lblQuestionNum.CssClass = "fw-bold";
            questionPanel.Controls.Add(lblQuestionNum);
            questionPanel.Controls.Add(new LiteralControl("<br />"));

            // Question text
            Label lblQuestionText = new Label();
            lblQuestionText.Text = "Question Text:";
            questionPanel.Controls.Add(lblQuestionText);
            questionPanel.Controls.Add(new LiteralControl("<br />"));
            
            TextBox txtQuestion = new TextBox();
            txtQuestion.ID = "txtQuestion" + questionCount;
            txtQuestion.CssClass = "form-control mb-2";
            txtQuestion.TextMode = TextBoxMode.MultiLine;
            txtQuestion.Rows = 2;
            questionPanel.Controls.Add(txtQuestion);
            questionPanel.Controls.Add(new LiteralControl("<br />"));

            // Options
            string[] options = { "A", "B", "C", "D" };
            foreach (string opt in options)
            {
                Label lblOption = new Label();
                lblOption.Text = "Option " + opt + ":";
                questionPanel.Controls.Add(lblOption);
                questionPanel.Controls.Add(new LiteralControl(" "));
                
                TextBox txtOption = new TextBox();
                txtOption.ID = "txtOption" + questionCount + opt;
                txtOption.CssClass = "form-control mb-2 d-inline-block";
                txtOption.Width = Unit.Percentage(80);
                questionPanel.Controls.Add(txtOption);
                questionPanel.Controls.Add(new LiteralControl("<br />"));
            }

            // Correct answer
            Label lblCorrect = new Label();
            lblCorrect.Text = "Correct Answer:";
            questionPanel.Controls.Add(lblCorrect);
            questionPanel.Controls.Add(new LiteralControl("<br />"));
            
            RadioButtonList rdolCorrect = new RadioButtonList();
            rdolCorrect.ID = "rdolCorrect" + questionCount;
            rdolCorrect.RepeatDirection = RepeatDirection.Horizontal;
            rdolCorrect.Items.Add(new ListItem("A", "A"));
            rdolCorrect.Items.Add(new ListItem("B", "B"));
            rdolCorrect.Items.Add(new ListItem("C", "C"));
            rdolCorrect.Items.Add(new ListItem("D", "D"));
            questionPanel.Controls.Add(rdolCorrect);
            questionPanel.Controls.Add(new LiteralControl("<br /><br />"));

            // Only add if not already exists (to prevent duplicates during recreation)
            if (pnlQuestions.FindControl("pnlQuestion" + questionCount) == null)
            {
                pnlQuestions.Controls.Add(questionPanel);
            }
        }

        protected void btnSubmitQuiz_Click(object sender, EventArgs e)
        {
            if (ddlModule.SelectedValue == "0")
            {
                lblError.Visible = true;
                lblError.Text = "Please select a module.";
                return;
            }

            // Get questions first to validate
            List<QuestionData> questions = GetQuestionsFromControls();
            if (questions.Count == 0)
            {
                lblError.Visible = true;
                lblError.Text = "Please add at least one question.";
                return;
            }

            int moduleID = Convert.ToInt32(ddlModule.SelectedValue);
            int quizID = 0;
            
            // Step 2: Create connection
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);

            try
            {
                // Step 3: Open connection
                conn.Open();

                // Step 4: Find the existing Quiz for this module
                string getQuizQuery = "SELECT ID FROM Quiz WHERE ModuleID = @ModuleID";
                SqlCommand commGetQuiz = new SqlCommand(getQuizQuery, conn);
                commGetQuiz.Parameters.AddWithValue("@ModuleID", moduleID);

                // Step 5: Execute and get the existing quiz ID
                object result = commGetQuiz.ExecuteScalar();
                if (result != null)
                {
                    quizID = Convert.ToInt32(result);
                }
                else
                {
                    lblError.Visible = true;
                    lblError.Text = "Error: Quiz not found for selected module. Please contact administrator.";
                    return;
                }

                // Insert each question into the existing quiz
                foreach (var question in questions)
                {
                    string insertQuestionQuery = "INSERT INTO [QuizQuestion] ([QuizID], [QuestionText], [ChoiceA], [ChoiceB], [ChoiceC], [ChoiceD], [CorrectChoice]) VALUES (@QuizID, @QuestionText, @ChoiceA, @ChoiceB, @ChoiceC, @ChoiceD, @CorrectChoice)";
                    SqlCommand commQuestion = new SqlCommand(insertQuestionQuery, conn);
                    commQuestion.Parameters.AddWithValue("@QuizID", quizID);
                    commQuestion.Parameters.AddWithValue("@QuestionText", question.QuestionText);
                    commQuestion.Parameters.AddWithValue("@ChoiceA", question.ChoiceA);
                    commQuestion.Parameters.AddWithValue("@ChoiceB", question.ChoiceB);
                    commQuestion.Parameters.AddWithValue("@ChoiceC", question.ChoiceC);
                    commQuestion.Parameters.AddWithValue("@ChoiceD", question.ChoiceD);
                    commQuestion.Parameters.AddWithValue("@CorrectChoice", question.CorrectChoice);
                    
                    commQuestion.ExecuteNonQuery();
                }

                // Success
                pnlQuizForm.Visible = false;
                pnlSuccess.Visible = true;
                Session["QuestionCount"] = null; // Clear question count
                
                lblStatus.Visible = true;
                lblStatus.Text = $"Success! {questions.Count} question(s) added to {ddlModule.SelectedItem.Text} quiz (Quiz ID: {quizID}).";
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "Error adding questions: " + ex.Message;
            }
            finally
            {
                // Step 6: Close connection
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }
        }

        protected void SqlDataSourceQuiz_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            // This event handler is no longer used but kept for compatibility
        }

        private List<QuestionData> GetQuestionsFromControls()
        {
            List<QuestionData> questions = new List<QuestionData>();

            foreach (Control ctrl in pnlQuestions.Controls)
            {
                if (ctrl is Panel && ctrl.ID.StartsWith("pnlQuestion"))
                {
                    string questionNum = ctrl.ID.Replace("pnlQuestion", "");
                    
                    // Find controls in this panel
                    TextBox txtQuestion = ctrl.FindControl("txtQuestion" + questionNum) as TextBox;
                    if (txtQuestion == null || string.IsNullOrWhiteSpace(txtQuestion.Text))
                        continue;

                    RadioButtonList rdolCorrect = ctrl.FindControl("rdolCorrect" + questionNum) as RadioButtonList;
                    if (rdolCorrect == null || string.IsNullOrEmpty(rdolCorrect.SelectedValue))
                        continue;

                    TextBox txtA = ctrl.FindControl("txtOption" + questionNum + "A") as TextBox;
                    TextBox txtB = ctrl.FindControl("txtOption" + questionNum + "B") as TextBox;
                    TextBox txtC = ctrl.FindControl("txtOption" + questionNum + "C") as TextBox;
                    TextBox txtD = ctrl.FindControl("txtOption" + questionNum + "D") as TextBox;

                    if (txtA == null || txtB == null || txtC == null || txtD == null)
                        continue;

                    if (string.IsNullOrWhiteSpace(txtA.Text) || 
                        string.IsNullOrWhiteSpace(txtB.Text) || 
                        string.IsNullOrWhiteSpace(txtC.Text) || 
                        string.IsNullOrWhiteSpace(txtD.Text))
                        continue;

                    questions.Add(new QuestionData
                    {
                        QuestionText = txtQuestion.Text,
                        ChoiceA = txtA.Text,
                        ChoiceB = txtB.Text,
                        ChoiceC = txtC.Text,
                        ChoiceD = txtD.Text,
                        CorrectChoice = rdolCorrect.SelectedValue
                    });
                }
            }

            return questions;
        }

        private class QuestionData
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
