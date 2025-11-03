<%@ Page Title="Modules" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Modules.aspx.cs" Inherits="Probfessional.Modules" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4">
        <h2 class="mb-4">Learning Modules</h2>
        <p class="mb-4">Explore probability through interactive parlour games and master key concepts</p>
        
        <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false" />
        
        <div class="row" id="modulesGrid" runat="server">
            <!-- Modules will be loaded here -->
        </div>
    </div>

</asp:Content>
