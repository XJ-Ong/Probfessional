<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="Probfessional.ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4">
        <h2 class="mb-4">User Management</h2>
        
        <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false" />
        <asp:Label ID="lblStatus" runat="server" CssClass="alert alert-success" Visible="false" />

        <!-- Input Form for Add/Update -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">User Details</h5>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ValidationGroup="AddUser" />
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ValidationGroup="UpdateUser" />
                <table class="table table-bordered">
                    <tr>
                        <td style="width: 200px;"><asp:Label ID="lblEmail" runat="server" Text="Email:" CssClass="fw-bold" /></td>
                        <td>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                            <asp:RequiredFieldValidator ID="rfvEmailAdd" runat="server" 
                                ControlToValidate="txtEmail" 
                                ErrorMessage="Email is required" 
                                Display="Dynamic" 
                                CssClass="text-danger" 
                                ValidationGroup="AddUser" />
                            <asp:RequiredFieldValidator ID="rfvEmailUpdate" runat="server" 
                                ControlToValidate="txtEmail" 
                                ErrorMessage="Email is required" 
                                Display="Dynamic" 
                                CssClass="text-danger" 
                                ValidationGroup="UpdateUser" />
                            <asp:RegularExpressionValidator ID="revEmailAdd" runat="server" 
                                ControlToValidate="txtEmail" 
                                ErrorMessage="Enter a valid email address" 
                                ValidationExpression="^\S+@\S+\.\S+$" 
                                Display="Dynamic" 
                                CssClass="text-danger" 
                                ValidationGroup="AddUser" />
                            <asp:RegularExpressionValidator ID="revEmailUpdate" runat="server" 
                                ControlToValidate="txtEmail" 
                                ErrorMessage="Enter a valid email address" 
                                ValidationExpression="^\S+@\S+\.\S+$" 
                                Display="Dynamic" 
                                CssClass="text-danger" 
                                ValidationGroup="UpdateUser" />
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblDisplayName" runat="server" Text="Display Name:" CssClass="fw-bold" /></td>
                        <td>
                            <asp:TextBox ID="txtDisplayName" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvDisplayNameAdd" runat="server" 
                                ControlToValidate="txtDisplayName" 
                                ErrorMessage="Display name is required" 
                                Display="Dynamic" 
                                CssClass="text-danger" 
                                ValidationGroup="AddUser" />
                            <asp:RequiredFieldValidator ID="rfvDisplayNameUpdate" runat="server" 
                                ControlToValidate="txtDisplayName" 
                                ErrorMessage="Display name is required" 
                                Display="Dynamic" 
                                CssClass="text-danger" 
                                ValidationGroup="UpdateUser" />
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblPassword" runat="server" Text="Password:" CssClass="fw-bold" /></td>
                        <td>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Leave blank when updating to keep current password" />
                            <asp:RequiredFieldValidator ID="rfvPasswordAdd" runat="server" 
                                ControlToValidate="txtPassword" 
                                ErrorMessage="Password is required when adding a new user" 
                                Display="Dynamic" 
                                CssClass="text-danger" 
                                ValidationGroup="AddUser" />
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblRole" runat="server" Text="Role:" CssClass="fw-bold" /></td>
                        <td>
                            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Learner" Value="Learner" />
                                <asp:ListItem Text="Teacher" Value="Teacher" />
                                <asp:ListItem Text="Admin" Value="Admin" />
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label runat="server" Text="Active Status:" CssClass="fw-bold" /></td>
                        <td>
                            <asp:CheckBox ID="chkIsActive" runat="server" Text="Active" Checked="true" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="btnAdd" runat="server" Text="Add User" CssClass="btn btn-success" OnClick="btnAdd_Click" ValidationGroup="AddUser" />
                            <asp:Button ID="btnUpdate" runat="server" Text="Update User" CssClass="btn btn-primary ms-2" OnClick="btnUpdate_Click" ValidationGroup="UpdateUser" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary ms-2" OnClick="btnClear_Click" CausesValidation="False" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <!-- SqlDataSource for CRUD Operations -->
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
            SelectCommand="SELECT [ID], [Email], [DisplayName], [Role], [CreatedAt], [IsActive] FROM [Users] ORDER BY [CreatedAt] DESC"
            InsertCommand="INSERT INTO [Users] ([Email], [DisplayName], [Password], [Role], [CreatedAt], [IsActive]) VALUES (@Email, @DisplayName, @Password, @Role, GETDATE(), @IsActive)"
            UpdateCommand="UPDATE [Users] SET [Email] = @Email, [DisplayName] = @DisplayName, [Password] = @Password, [Role] = @Role, [IsActive] = @IsActive WHERE [ID] = @ID">
            <InsertParameters>
                <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtDisplayName" Name="DisplayName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtPassword" Name="Password" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="ddlRole" Name="Role" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="chkIsActive" Name="IsActive" PropertyName="Checked" Type="Boolean" />
            </InsertParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtDisplayName" Name="DisplayName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtPassword" Name="Password" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="ddlRole" Name="Role" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="chkIsActive" Name="IsActive" PropertyName="Checked" Type="Boolean" />
                <asp:SessionParameter Name="ID" SessionField="SelectedUserID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <!-- GridView for Display -->
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">All Users</h5>
                <asp:GridView ID="GridView1" runat="server"
                    DataSourceID="SqlDataSource1"
                    DataKeyNames="ID"
                    AllowPaging="True"
                    PageSize="10"
                    AllowSorting="True"
                    OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                    CssClass="table table-striped table-bordered">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" ButtonType="Button" SelectText="Select" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

</asp:Content>

