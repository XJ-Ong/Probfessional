<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Probfessional.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- SqlDataSource for User Registration -->
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
        InsertCommand="INSERT INTO [Users] ([Email], [DisplayName], [Password], [Role], [CreatedAt], [IsActive]) VALUES (@Email, @DisplayName, @Password, @Role, GETDATE(), 1); SELECT CAST(SCOPE_IDENTITY() as int);"
        OnInserted="SqlDataSource1_Inserted">
        <InsertParameters>
            <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDisplayName" Name="DisplayName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtPassword" Name="Password" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="rdolRole" Name="Role" PropertyName="SelectedValue" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="mb-4">Create Account</h2>
                
                <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" />
                <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false" />
                
                <asp:Panel runat="server" DefaultButton="btnRegister">
                    <table class="table">
                        <tr>
                            <td><asp:Label ID="lblEmail" runat="server" Text="Email Address:" /></td>
                            <td>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" Display="Dynamic" CssClass="text-danger" />
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationExpression="^\S+@\S+\.\S+$" ErrorMessage="Invalid email format" CssClass="text-danger" Display="Dynamic" />
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblDisplayName" runat="server" Text="Display Name:" /></td>
                            <td>
                                <asp:TextBox ID="txtDisplayName" runat="server" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDisplayName" ErrorMessage="Display name is required" Display="Dynamic" CssClass="text-danger" />
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblRole" runat="server" Text="Account Type:" /></td>
                            <td>
                                <asp:RadioButtonList ID="rdolRole" runat="server" CssClass="form-check">
                                    <asp:ListItem Text="Learner" Value="Learner" Selected="True" />
                                    <asp:ListItem Text="Teacher" Value="Teacher" />
                                </asp:RadioButtonList>
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
                            <td><asp:Label ID="lblConfirm" runat="server" Text="Confirm Password:" /></td>
                            <td>
                                <asp:TextBox ID="txtConfirm" runat="server" CssClass="form-control" TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirm" ErrorMessage="Please confirm your password" Display="Dynamic" CssClass="text-danger" />
                                <asp:CompareValidator runat="server" ControlToValidate="txtConfirm" ControlToCompare="txtPassword" ErrorMessage="Passwords do not match" CssClass="text-danger" Display="Dynamic" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn btn-primary" OnClick="btnRegister_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-center">
                                Already have an account? <a href="Login.aspx">Sign in here</a>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
        </div>
    </div>

</asp:Content>
