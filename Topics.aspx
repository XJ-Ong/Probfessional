<%@ Page Title="Topics" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Topics.aspx.cs" Inherits="Probfessional.Topics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false" />

    <!-- SqlDataSource for Lessons -->
    <asp:SqlDataSource ID="sqlLessons" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
        SelectCommand="SELECT ID, Title FROM Lessons WHERE ModuleID = @ModuleID"
        OnSelecting="sqlLessons_Selecting">
        <SelectParameters>
            <asp:QueryStringParameter Name="ModuleID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="container mt-4">
        <div class="mb-3">
            <a href="<%= ResolveUrl("~/Modules.aspx") %>" class="btn btn-secondary">
                <span>&laquo;</span> Back to Modules
            </a>
        </div>

        <div>
            <h2 id="title" runat="server" class="mb-3"></h2>
            <p id="desc" runat="server" class="mb-4"></p>
        </div>

        <h3 class="mb-3">Topics</h3>
    
    <asp:Repeater ID="rptLessons" runat="server" DataSourceID="sqlLessons" OnItemDataBound="rptLessons_ItemDataBound">
        <ItemTemplate>
            <div class="card topic-card">
                <div class="card-body">
                    <h5 class="card-title topic-title"><%# Eval("Title") %></h5>
                    <div style="margin-top: 16px;">
                        <a id="lnkLesson" runat="server" href="#" class="btn btn-sm btn-primary">View Topic</a>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>

        <div class="text-center mt-4">
            <a class="btn btn-success btn-lg" href="<%= ResolveUrl("~/Quizzes.aspx") %>?moduleId=<%= Request["id"] %>">Take Quiz</a>
        </div>
    </div>
</asp:Content>
