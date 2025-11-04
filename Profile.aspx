<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Probfessional.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4">
        <h2 class="mb-4">My Profile</h2>
        
        <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false" />
        <asp:Label ID="lblStatus" runat="server" CssClass="alert alert-success" Visible="false" />

        <!-- Profile Information Form -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Profile Information</h5>
                <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" />
                <table class="table table-bordered">
                    <tr>
                        <td><asp:Label ID="lblEmail" runat="server" Text="Email:" CssClass="fw-bold" /></td>
                        <td>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                                ControlToValidate="txtEmail" 
                                ErrorMessage="Email is required" 
                                Display="Dynamic" 
                                CssClass="text-danger" />
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                                ControlToValidate="txtEmail" 
                                ErrorMessage="Enter a valid email address" 
                                ValidationExpression="^\S+@\S+\.\S+$" 
                                Display="Dynamic" 
                                CssClass="text-danger" />
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblDisplayName" runat="server" Text="Display Name:" CssClass="fw-bold" /></td>
                        <td>
                            <asp:TextBox ID="txtDisplayName" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvDisplayName" runat="server" 
                                ControlToValidate="txtDisplayName" 
                                ErrorMessage="Display name is required" 
                                Display="Dynamic" 
                                CssClass="text-danger" />
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblPassword" runat="server" Text="New Password:" CssClass="fw-bold" /></td>
                        <td>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Leave blank to keep current password" />
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblRole" runat="server" Text="Account Type:" CssClass="fw-bold" /></td>
                        <td>
                            <asp:Label ID="lblRoleDisplay" runat="server" CssClass="form-control-plaintext" />
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label runat="server" Text="Account Status:" CssClass="fw-bold" /></td>
                        <td>
                            <asp:Label ID="lblActiveStatus" runat="server" CssClass="form-control-plaintext" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
                            <asp:Button ID="btnDeactivate" runat="server" Text="Deactivate Account" CssClass="btn btn-danger ms-2" OnClick="btnDeactivate_Click" OnClientClick="return confirm('Are you sure you want to deactivate your account? You will be logged out and unable to log in until an administrator reactivates your account.');" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

</asp:Content>
