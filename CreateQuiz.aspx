<%@ Page Title="Create Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateQuiz.aspx.cs" Inherits="Probfessional.CreateQuiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .quiz-create-container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 40px;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(240, 248, 255, 0.95) 100%);
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0,0,0,0.2);
            font-family: 'Inter', sans-serif;
        }

        .quiz-create-header {
            margin-bottom: 40px;
            text-align: center;
        }

        .quiz-create-header h1 {
            font-size: 32px;
            font-weight: 700;
            color: #1a202c;
            margin-bottom: 8px;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .quiz-create-header p {
            color: #718096;
            font-size: 16px;
        }

        .quiz-form-section {
            background: white;
            padding: 30px;
            border-radius: 16px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            font-size: 14px;
            color: #2d3748;
            margin-bottom: 8px;
        }

        .form-group select,
        .form-group input[type="text"],
        .form-group input[type="number"] {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: white;
            color: #1a202c;
        }

        .form-group select:focus,
        .form-group input[type="text"]:focus,
        .form-group input[type="number"]:focus {
            outline: none;
            border-color: #0369a1;
            box-shadow: 0 0 0 4px rgba(3, 105, 161, 0.1);
        }

        .questions-container {
            margin-top: 30px;
        }

        .question-card {
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 24px;
            transition: all 0.3s ease;
        }

        .question-card:hover {
            border-color: #0369a1;
            box-shadow: 0 4px 12px rgba(3, 105, 161, 0.1);
        }

        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .question-number {
            font-weight: 700;
            font-size: 18px;
            color: #0369a1;
        }

        .btn-remove-question {
            background: #fee2e2;
            color: #dc2626;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .btn-remove-question:hover {
            background: #fecaca;
            transform: translateY(-1px);
        }

        .question-text-input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 14px;
            margin-bottom: 16px;
            transition: all 0.3s ease;
        }

        .question-text-input:focus {
            outline: none;
            border-color: #0369a1;
            box-shadow: 0 0 0 4px rgba(3, 105, 161, 0.1);
        }

        .options-container {
            margin-top: 16px;
        }

        .option-item {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
            padding: 12px;
            background: #f7fafc;
            border-radius: 8px;
        }

        .option-item input[type="radio"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: #0369a1;
        }

        .option-item input[type="text"] {
            flex: 1;
            padding: 8px 12px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
        }

        .option-item input[type="text"]:focus {
            outline: none;
            border-color: #0369a1;
            box-shadow: 0 0 0 3px rgba(3, 105, 161, 0.1);
        }

        .btn-remove-option {
            background: #fee2e2;
            color: #dc2626;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
        }

        .btn-remove-option:hover {
            background: #fecaca;
        }

        .btn-add-option {
            background: #dbeafe;
            color: #0369a1;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            margin-top: 8px;
            transition: all 0.3s ease;
        }

        .btn-add-option:hover {
            background: #bfdbfe;
            transform: translateY(-1px);
        }

        .btn-add-question {
            width: 100%;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            color: white;
            border: none;
            padding: 14px 24px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 20px;
        }

        .btn-add-question:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(3, 105, 161, 0.3);
        }

        .btn-add-question.center {
            width: auto;
            margin: 0 auto;
            display: block;
        }

        .btn-submit-quiz {
            width: auto;
            background: linear-gradient(135deg, #059669 0%, #10b981 50%, #34d399 100%);
            color: white;
            border: none;
            padding: 16px 32px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 18px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 30px;
            margin-left: auto;
            margin-right: auto;
            display: block;
        }

        .btn-submit-quiz:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(5, 150, 105, 0.3);
        }

        .btn-submit-quiz:disabled {
            background: #9ca3af;
            cursor: not-allowed;
            transform: none;
        }

        .validation-message {
            color: #dc2626;
            font-size: 14px;
            margin-top: 8px;
            display: block;
        }

        .info-message {
            background: #dbeafe;
            color: #1e40af;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #718096;
        }

        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 16px;
        }

        @media (max-width: 768px) {
            .quiz-create-container {
                padding: 24px;
                margin: 20px;
            }
            .quiz-form-section {
                padding: 20px;
            }
        }
    </style>

    <div class="quiz-create-container">
        <div class="quiz-create-header">
            <h1>Create New Quiz</h1>
            <p>Build engaging quizzes for your students</p>
        </div>

        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validation-message" DisplayMode="BulletList" />
        <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false" />

        <asp:Panel ID="pnlQuizForm" runat="server">
            <div class="quiz-form-section">
                <div class="form-group">
                    <label for="ddlModule">Select Module *</label>
                    <asp:DropDownList ID="ddlModule" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="ddlModule" ErrorMessage="Please select a module" 
                        CssClass="validation-message" Display="Dynamic" InitialValue="0" />
                </div>
            </div>

            <div class="questions-container">
                <h2 style="color: #2d3748; margin-bottom: 20px; font-size: 24px;">Questions</h2>
                <asp:Panel ID="questionsList" runat="server">
                    <!-- Questions will be added dynamically here -->
                </asp:Panel>
                <button type="button" class="btn-add-question center" onclick="addQuestion()">
                    + Add Question
                </button>
            </div>

            <asp:Button ID="btnSubmitQuiz" runat="server" Text="Create Quiz" 
                CssClass="btn-submit-quiz" OnClick="btnSubmitQuiz_Click" />
        </asp:Panel>

        <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
            <div class="quiz-form-section" style="text-align: center;">
                <div style="font-size: 64px; color: #10b981; margin-bottom: 20px;">✓</div>
                <h2 style="color: #1a202c; margin-bottom: 16px;">Quiz Created Successfully!</h2>
                <p style="color: #718096; margin-bottom: 30px;">Your quiz has been created and is ready for students to take.</p>
                <a href="Modules.aspx" class="btn-add-question center" style="text-decoration: none; padding: 12px 32px;">
                    Back to Modules
                </a>
            </div>
        </asp:Panel>
    </div>

    <script type="text/javascript">
        let questionCount = 0;

        function addQuestion() {
            questionCount++;
            const questionsList = document.getElementById('<%= questionsList.ClientID %>');
            
            const questionHtml = `
                <div class="question-card" id="question-${questionCount}">
                    <div class="question-header">
                        <span class="question-number">Question ${questionCount}</span>
                        <button type="button" class="btn-remove-question" onclick="removeQuestion(${questionCount})">Remove</button>
                    </div>
                    <input type="text" class="question-text-input" name="question-text-${questionCount}" 
                        placeholder="Enter your question here..." required />
                    <div class="options-container" id="options-${questionCount}">
                        <div class="option-item">
                            <input type="radio" name="correct-${questionCount}" value="A" required />
                            <input type="text" name="option-${questionCount}-A" placeholder="Option A" required />
                        </div>
                        <div class="option-item">
                            <input type="radio" name="correct-${questionCount}" value="B" required />
                            <input type="text" name="option-${questionCount}-B" placeholder="Option B" required />
                        </div>
                        <div class="option-item">
                            <input type="radio" name="correct-${questionCount}" value="C" required />
                            <input type="text" name="option-${questionCount}-C" placeholder="Option C" required />
                        </div>
                        <div class="option-item">
                            <input type="radio" name="correct-${questionCount}" value="D" required />
                            <input type="text" name="option-${questionCount}-D" placeholder="Option D" required />
                        </div>
                    </div>
                </div>
            `;
            
            const tempDiv = document.createElement('div');
            tempDiv.innerHTML = questionHtml;
            questionsList.appendChild(tempDiv.firstElementChild);
            
            document.getElementById(`question-${questionCount}`).scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }

        function removeQuestion(questionId) {
            const questionCard = document.getElementById(`question-${questionId}`);
            if (questionCard) {
                questionCard.remove();
                updateQuestionNumbers();
            }
        }

        function updateQuestionNumbers() {
            const questions = document.querySelectorAll('.question-card');
            questions.forEach((question, index) => {
                const numberSpan = question.querySelector('.question-number');
                if (numberSpan) {
                    numberSpan.textContent = `Question ${index + 1}`;
                }
            });
        }
    </script>

</asp:Content>
