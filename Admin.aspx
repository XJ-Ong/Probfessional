<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Probfessional.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4">
        <h2 class="mb-4">Admin Dashboard</h2>
        
        <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false" />

        <!-- Welcome Card -->
        <div class="card bg-primary text-white mb-4">
            <div class="card-body">
                <h4>Welcome, <asp:Label ID="lblAdminName" runat="server" /></h4>
                <p>Administrator Control Panel</p>
            </div>
        </div>

        <!-- Management Button -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">User Management</h5>
                <p>Manage user accounts, roles, and permissions.</p>
                <asp:Button ID="btnManageUsers" runat="server" Text="Manage Users" CssClass="btn btn-primary" OnClick="btnManageUsers_Click" CausesValidation="False" />
            </div>
        </div>

        <!-- Quiz Attempts Log -->
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Quiz Attempt Logs</h5>
                <p class="text-muted">View all quiz attempts by users, including date, time, quiz details, and scores.</p>
                
                <!-- SqlDataSource for Quiz Attempts -->
                <asp:SqlDataSource ID="SqlDataSourceQuizAttempts" runat="server"
                    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
                    SelectCommand="SELECT 
                        qa.ID, 
                        qa.TakenTime, 
                        qa.Score, 
                        u.DisplayName as UserName,
                        u.Email as UserEmail,
                        u.Role as UserRole,
                        q.Title as QuizTitle,
                        m.Title as ModuleName
                    FROM QuizAttempts qa
                    INNER JOIN Users u ON qa.UserID = u.ID
                    INNER JOIN Quiz q ON qa.QuizID = q.ID
                    INNER JOIN Modules m ON q.ModuleID = m.ID
                    ORDER BY qa.TakenTime DESC">
                </asp:SqlDataSource>

                <!-- GridView for Quiz Attempts -->
                <asp:GridView ID="GridViewQuizAttempts" runat="server"
                    DataSourceID="SqlDataSourceQuizAttempts"
                    AllowPaging="True"
                    PageSize="15"
                    AllowSorting="True"
                    CssClass="table table-striped table-bordered mt-3"
                    AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="Attempt ID" SortExpression="ID" />
                        <asp:BoundField DataField="UserName" HeaderText="Student" SortExpression="UserName" />
                        <asp:BoundField DataField="UserEmail" HeaderText="Email" SortExpression="UserEmail" />
                        <asp:BoundField DataField="UserRole" HeaderText="Role" SortExpression="UserRole" />
                        <asp:BoundField DataField="ModuleName" HeaderText="Module" SortExpression="ModuleName" />
                        <asp:BoundField DataField="QuizTitle" HeaderText="Quiz" SortExpression="QuizTitle" />
                        <asp:BoundField DataField="Score" HeaderText="Score (%)" SortExpression="Score" DataFormatString="{0:F2}" />
                        <asp:BoundField DataField="TakenTime" HeaderText="Date & Time" SortExpression="TakenTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                    </Columns>
                    <PagerSettings Mode="NumericFirstLast" />
                </asp:GridView>
            </div>
        </div>
    </div>

</asp:Content>
