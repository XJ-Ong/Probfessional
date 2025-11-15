<%@ Page Title="Rankings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Rank.aspx.cs" Inherits="Probfessional.Rank" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4">
        <h2 class="mb-4 text-center">Quiz Rankings</h2>
        <p class="text-center mb-4">Top 100 players per module</p>
        
        <div class="mb-4">
            <table class="table">
                <tr>
                    <td><asp:Label ID="lblModule" runat="server" Text="Select Module:" /></td>
                    <td>
                        <asp:DropDownList ID="ddlModules" runat="server" AutoPostBack="true" 
                            OnSelectedIndexChanged="ddlModules_SelectedIndexChanged" CssClass="form-control" />
                    </td>
                </tr>
            </table>
        </div>
        
        <asp:Repeater ID="rptRankings" runat="server">
            <HeaderTemplate>
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>Rank</th>
                            <th>User</th>
                            <th>Score</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                        <tr>
                            <td>
                                <%# Eval("Rank") %>
                                <%# (int)Eval("Rank") <= 3 ? ((int)Eval("Rank") == 1 ? "🥇" : (int)Eval("Rank") == 2 ? "🥈" : "🥉") : "" %>
                            </td>
                            <td><%# Eval("UserName") %></td>
                            <td><%# Eval("Score") %>%</td>
                            <td><%# Eval("TakenAt", "{0:MMM dd, yyyy}") %></td>
                        </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        
        <asp:Label ID="lblNoData" runat="server" Visible="false" CssClass="alert alert-info text-center">
            No rankings available for this module yet.
        </asp:Label>
    </div>

</asp:Content>
