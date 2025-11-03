<%@ Page Title="Create Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateQuiz.aspx.cs" Inherits="Probfessional.CreateQuiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4">
        <h2 class="mb-4">Add Quiz Questions</h2>
        
        <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false" />
        <asp:Label ID="lblStatus" runat="server" CssClass="alert alert-success" Visible="false" />

        <asp:Panel ID="pnlQuizForm" runat="server">
            <table class="table table-bordered mb-4">
                <tr>
                    <td><asp:Label ID="lblModule" runat="server" Text="Select Module:" /></td>
                    <td>
                        <asp:DropDownList ID="ddlModule" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvModule" runat="server" 
                            ControlToValidate="ddlModule" ErrorMessage="Please select a module" 
                            Display="Dynamic" CssClass="text-danger" InitialValue="0" />
                    </td>
                </tr>
            </table>

            <h3 class="mb-3">Questions</h3>
            <asp:Panel ID="pnlQuestions" runat="server">
                <!-- Questions will be added dynamically here -->
            </asp:Panel>
            
            <asp:Button ID="btnAddQuestion" runat="server" Text="+ Add Question" 
                CssClass="btn btn-success mb-3" OnClick="btnAddQuestion_Click" CausesValidation="False" />
            
            <br />
            <asp:Button ID="btnSubmitQuiz" runat="server" Text="Add Questions to Quiz" 
                CssClass="btn btn-primary" OnClick="btnSubmitQuiz_Click" />
        </asp:Panel>

        <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
            <div class="alert alert-success">
                <h4>Questions Added Successfully!</h4>
                <p>Your questions have been added to the quiz and are ready for students to take.</p>
                <a href="CreateQuiz.aspx" class="btn btn-success">Add More Questions</a>
                <a href="Modules.aspx" class="btn btn-primary ms-2">Back to Modules</a>
            </div>
        </asp:Panel>
    </div>

</asp:Content>
