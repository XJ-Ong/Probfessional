<%@ Page Title="Search Results" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchResults.aspx.cs" Inherits="Probfessional.SearchResults" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2 class="mb-4">Search Results</h2>

        <asp:Label ID="lblSearchQuery" runat="server" CssClass="lead mb-3" />
        <asp:Label ID="lblNoResults" runat="server" CssClass="alert alert-info" Visible="false" />

        <asp:Panel ID="pnlModules" runat="server" Visible="false" CssClass="mb-5">
            <h4 class="text-primary mb-3">Modules</h4>
            <asp:Repeater ID="rptModules" runat="server">
                <ItemTemplate>
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title">
                                <a href='<%# "Topics.aspx?id=" + Eval("ID") %>'><%# Eval("Title") %></a>
                            </h5>
                            <p class="card-text"><%# Eval("Description") %></p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>

        <asp:Panel ID="pnlLessons" runat="server" Visible="false" CssClass="mb-5">
            <h4 class="text-primary mb-3">Lessons</h4>
            <asp:Repeater ID="rptLessons" runat="server">
                <ItemTemplate>
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title">
                                <a href='<%# "Lessons.aspx?id=" + Eval("LessonID") %>'><%# Eval("LessonTitle") %></a>
                            </h5>
                            <p class="text-muted mb-2">
                                <small>Module: <%# Eval("ModuleTitle") %></small>
                            </p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>
    </div>
</asp:Content>