<%@ Page Title="Your Progress" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Progress.aspx.cs" Inherits="Probfessional.Progress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- SqlDataSource for Modules with Progress -->
    <asp:SqlDataSource ID="sqlModulesProgress" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
        SelectCommand="
            SELECT 
                m.ID as Id,
                m.Title,
                m.ImagePath,
                ISNULL(up.ProgressPercent, 0) as ProgressPercent
            FROM Modules m
            LEFT JOIN UserProgress up ON m.ID = up.ModuleID AND up.UserID = @UserID
            ORDER BY m.ID">
        <SelectParameters>
            <asp:Parameter Name="UserID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="container mt-4">
        <h2 class="mb-4">Your Learning Progress</h2>

    <asp:Repeater ID="rptModules" runat="server" OnItemDataBound="rptModules_ItemDataBound">
        <ItemTemplate>
            <div class="card mb-4">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-2">
                            <%# !string.IsNullOrEmpty(Eval("ImagePath")?.ToString()) ? 
                                "<img src='" + ResolveUrl("~/" + Eval("ImagePath").ToString()) + "' alt='" + Server.HtmlEncode(Eval("Title").ToString()) + "' class='img-fluid' />" : 
                                "<div class='bg-light p-3 text-center'><small>No image</small></div>" %>
                        </div>
                        <div class="col-md-10">
                            <h4><%# Eval("Title") %></h4>
                            
                            <div class="mb-3">
                                <div class="d-flex justify-content-between mb-1">
                                    <small class="text-muted">Overall Progress</small>
                                    <small class="text-muted"><strong><%# Eval("ProgressPercent") %>%</strong></small>
                                </div>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: <%# Eval("ProgressPercent") %>%"></div>
                                </div>
                            </div>
                            
                            <div class="mt-3">
                                <strong>Topics:</strong>
                                <asp:Repeater ID="rptLessons" runat="server">
                                    <ItemTemplate>
                                        <div class="mb-2">
                                            <span class="<%# Convert.ToBoolean(Eval("IsCompleted")) ? "text-success" : "text-muted" %>">
                                                <%# Eval("Title") %>
                                            </span>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            
                            <div class="mt-3">
                                <a class="btn btn-primary btn-sm" href="<%# ResolveUrl("~/Topics.aspx?id=" + Eval("Id")) %>">View Module</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
