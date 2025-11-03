<%@ Page Title="Topics" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Topics.aspx.cs" Inherits="Probfessional.Topics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Back Button -->
    <div class="mb-3">
        <a href="<%= ResolveUrl("~/Modules.aspx") %>" class="btn-back-modules">
            <span>&laquo;</span> Back to Modules
        </a>
    </div>

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

    <style>
        .btn-back-modules {
            display: inline-block;
            padding: 10px 20px;
            background-color: #f8f9fa;
            color: #495057;
            border: 2px solid #dee2e6;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-back-modules span {
            margin-right: 8px;
        }
        .btn-back-modules:hover {
            background-color: #e9ecef;
            border-color: #adb5bd;
            color: #212529;
            text-decoration: none;
            transform: translateX(-2px);
        }
        .topic-card {
            border-left: 4px solid #007bff;
            margin-bottom: 16px;
            transition: all 0.3s ease;
        }
        .topic-card:hover {
            transform: translateX(4px);
            box-shadow: 0 4px 12px rgba(0,123,255,0.2);
        }
        .topic-title {
            margin-bottom: 12px;
        }
    </style>

    <div>
        <h1 id="title" runat="server" style="margin-top: 0; margin-bottom: 10px; font-size: 32px; font-weight: 800; color: #1e40af;"></h1>
        <p id="desc" runat="server" style="font-size: 1.1rem; line-height: 1.6; color: #4a5568; margin-bottom: 0;"></p>
    </div>

    <h3 style="margin-top: 32px; margin-bottom: 20px;">Topics</h3>
    
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
        <a class="btn btn-success btn-lg" href="<%= ResolveUrl("~/Quizzes.aspx") %>?moduleId=<%= Request["id"] %>" style="padding: 12px 32px; font-size: 18px; font-weight: 700;">Take Quiz</a>
    </div>
</asp:Content>
