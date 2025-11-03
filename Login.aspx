<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Probfessional.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="mb-4">Sign In</h2>
                
                <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" />
                <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false" />
                
                <asp:Panel runat="server" DefaultButton="btnLogin">
                    <table class="table">
                        <tr>
                            <td><asp:Label ID="lblEmail" runat="server" Text="Email Address:" /></td>
                            <td>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" Display="Dynamic" CssClass="text-danger" />
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="Enter a valid email" Display="Dynamic" CssClass="text-danger" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" />
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblPassword" runat="server" Text="Password:" /></td>
                            <td>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required" Display="Dynamic" CssClass="text-danger" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn btn-primary" OnClick="btnLogin_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-center">
                                Don't have an account? <a href="Register.aspx">Sign up here</a>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
        </div>
    </div>

</asp:Content>
