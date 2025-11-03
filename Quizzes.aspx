<%@ Page Title="Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Quizzes.aspx.cs" Inherits="Probfessional.Quizzes" %>

<asp:Content ID="QuizContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- SqlDataSource for Modules -->
    <asp:SqlDataSource ID="sqlModules" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
        SelectCommand="SELECT ID, Title FROM Modules ORDER BY ID">
    </asp:SqlDataSource>

    <div class="quiz-wrapper">
        <!-- Module Selection - Outside Bar -->
        <div class="module-selector-outside">
            <label for="<%= ddlModules.ClientID %>" class="module-selector-label-outside">Select Module:</label>
            <asp:DropDownList ID="ddlModules" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlModules_SelectedIndexChanged" CssClass="quiz-module-dropdown-outside" 
                DataSourceID="sqlModules" DataTextField="Title" DataValueField="ID" OnDataBound="ddlModules_DataBound" />
            <div style="margin-left: auto; display: flex; gap: 10px;">
                <a href="Rank.aspx" class="btn btn-success" style="padding: 10px 20px; font-weight: 600;">
                    🏆 Leaderboard
                </a>
                <asp:Panel ID="divCreateQuiz" runat="server">
                    <a href="CreateQuiz.aspx" class="btn btn-primary" style="padding: 10px 20px; font-weight: 600;">
                        + Create Quiz
                    </a>
                </asp:Panel>
            </div>
        </div>

        <!-- Quiz Title Section -->
        <div class="quiz-module-selector">
            <h1 id="quizTitle" runat="server" class="quiz-module-title"></h1>
        </div>

        <!-- Page indicator -->
        <div id="pageIndicator" runat="server" class="quiz-page-info mb-4">
            <asp:Literal ID="litPageInfo" runat="server" />
        </div>

        <!-- Questions Container -->
        <div class="quiz-content">
            <asp:PlaceHolder ID="phQuestions" runat="server" />
        </div>

        <!-- Navigation Controls - Under Question -->
        <div class="quiz-navigation-question">
            <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click" CssClass="btn-nav-question btn-nav-prev" />
            <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" CssClass="btn-nav-question btn-nav-next" Visible="false" />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit Quiz" OnClick="btnSubmit_Click" CssClass="btn-nav-question btn-nav-submit" Visible="false" />
        </div>
    </div>

    <style>
        .quiz-wrapper {
            max-width: 900px;
            margin: 0 auto;
            padding: 25px;
            font-size: 18px;
        }

        /* Module Selector - Outside Bar */
        .module-selector-outside {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .module-selector-label-outside {
            font-size: 1.15rem;
            font-weight: 600;
            color: #2d3748;
            margin: 0;
            white-space: nowrap;
        }

        .quiz-module-dropdown-outside {
            flex: 1;
            min-width: 250px;
            padding: 12px 16px;
            font-size: 1.05rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            background: white;
            color: #2d3748;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .quiz-module-dropdown-outside:hover {
            border-color: #cbd5e0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .quiz-module-dropdown-outside:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
        }

        /* Quiz Title Section */
        .quiz-module-selector {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 25px 30px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.25);
        }

        .quiz-module-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: white;
            margin: 0;
            line-height: 1.3;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .quiz-page-info {
            font-size: 16px;
            color: #666;
            padding: 12px 16px;
            background-color: #f8f9fa;
            border-radius: 8px;
            font-weight: 500;
        }

        /* Question Content */
        .quiz-content {
            margin-bottom: 35px;
        }

        /* Question Card */
        .question-card {
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 35px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .question-text {
            font-size: 1.4rem;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 25px;
            line-height: 1.6;
        }

        /* Radio Button Options */
        .quiz-content .question-card table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 12px;
        }

        .quiz-content .question-card table td {
            padding: 0;
        }

        .quiz-content .question-card input[type="radio"] {
            display: none;
        }

        .quiz-content .question-card label {
            display: block;
            width: 100%;
            padding: 18px 24px;
            margin: 0;
            background: #f7fafc;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 1.1rem;
            color: #4a5568;
            font-weight: 500;
            text-align: left;
            position: relative;
            box-sizing: border-box;
        }

        .quiz-content .question-card label:hover {
            background: #edf2f7;
            border-color: #cbd5e0;
            transform: translateX(3px);
        }

        .quiz-content .question-card input[type="radio"]:checked + label {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: #667eea;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
            transform: translateX(3px);
        }

        /* Navigation */
        .quiz-navigation-question {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 25px;
            margin-bottom: 40px;
            padding: 0;
        }

        .btn-nav-question {
            padding: 14px 32px;
            font-size: 1.1rem;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-nav-prev {
            background: #e2e8f0;
            color: #4a5568;
            margin-right: auto;
        }

        .btn-nav-prev:hover {
            background: #cbd5e0;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .btn-nav-next {
            background: #4299e1;
            color: white;
            margin-left: auto;
        }

        .btn-nav-next:hover {
            background: #3182ce;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(66, 153, 225, 0.4);
        }

        .btn-nav-submit {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            color: white;
            margin-left: auto;
        }

        .btn-nav-submit:hover {
            background: linear-gradient(135deg, #38a169 0%, #2f855a 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(72, 187, 120, 0.4);
        }

        @media (max-width: 768px) {
            .quiz-wrapper { padding: 20px; font-size: 16px; }
            .quiz-module-selector { padding: 20px 22px; }
            .quiz-module-title { font-size: 1.8rem; }
            .module-selector-outside { flex-direction: column; align-items: flex-start; gap: 12px; }
            .quiz-module-dropdown-outside { width: 100%; }
            .question-card { padding: 25px; }
            .question-text { font-size: 1.2rem; }
            .quiz-content .question-card label { font-size: 1rem; padding: 16px 20px; }
            .quiz-navigation-question { flex-direction: column; gap: 12px; }
            .btn-nav-question { width: 100%; font-size: 1rem; }
        }
    </style>

    <!-- Validation message -->
    <asp:Label ID="lblValidationError" runat="server" CssClass="alert alert-warning" Visible="false" />

    <!-- Bootstrap Modal for Validation Error -->
    <div class="modal fade" id="ValidationModal" tabindex="-1" role="dialog" aria-labelledby="ValidationLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ValidationLabel">Please Answer All Questions</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblValidationModal" runat="server" CssClass="lead" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <asp:Literal ID="validationScript" runat="server" EnableViewState="false" />

    <!-- Bootstrap Modal for Quiz Result -->
    <div class="modal fade" id="QuizResultModal" tabindex="-1" role="dialog" aria-labelledby="QuizResultLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="QuizResultLabel">Quiz Result</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblPopupScore" runat="server" CssClass="lead" />
                    <asp:Label ID="lblPopupMsg" runat="server" CssClass="fw-bold mt-2" />
                    <br />
                    <asp:Label ID="lblPopupHighScore" runat="server" CssClass="text-secondary small mt-2" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <asp:Literal ID="modalScript" runat="server" EnableViewState="false" />
</asp:Content>
