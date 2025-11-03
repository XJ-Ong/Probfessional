<%@ Page Title="Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Quizzes.aspx.cs" Inherits="Probfessional.Quizzes" %>

<asp:Content ID="QuizContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- SqlDataSource for Modules -->
    <asp:SqlDataSource ID="sqlModules" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
        SelectCommand="SELECT ID, Title FROM Modules ORDER BY ID">
    </asp:SqlDataSource>

    <div class="container mt-4">
        <!-- Module Selection -->
        <div class="mb-4">
            <table class="table">
                <tr>
                    <td><asp:Label ID="lblModule" runat="server" Text="Select Module:" /></td>
                    <td>
                        <asp:DropDownList ID="ddlModules" runat="server" AutoPostBack="true" 
                            OnSelectedIndexChanged="ddlModules_SelectedIndexChanged" 
                            DataSourceID="sqlModules" DataTextField="Title" DataValueField="ID" 
                            OnDataBound="ddlModules_DataBound" CssClass="form-control" />
                    </td>
                    <td>
                        <a href="Rank.aspx" class="btn btn-success">🏆 Leaderboard</a>
                        <asp:Panel ID="divCreateQuiz" runat="server" CssClass="d-inline ms-2">
                            <a href="CreateQuiz.aspx" class="btn btn-primary">+ Create Quiz</a>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Quiz Title -->
        <div class="card bg-primary text-white mb-4">
            <div class="card-body">
                <h2 id="quizTitle" runat="server"></h2>
            </div>
        </div>

        <!-- Page indicator -->
        <div class="mb-3">
            <asp:Literal ID="litPageInfo" runat="server" />
        </div>

        <!-- Questions Container -->
        <asp:PlaceHolder ID="phQuestions" runat="server" />

        <!-- Navigation Controls -->
        <div class="d-flex justify-content-between mt-4">
            <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click" CssClass="btn btn-secondary" />
            <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" CssClass="btn btn-primary" Visible="false" />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit Quiz" OnClick="btnSubmit_Click" CssClass="btn btn-success" Visible="false" />
        </div>
    </div>

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
