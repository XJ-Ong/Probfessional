using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Probfessional
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }

            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            // Check if user is admin
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                lblError.Visible = true;
                lblError.Text = "Access denied. Only administrators can manage users.";
                GridView1.Visible = false;
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Store selected user ID in session
            Session["SelectedUserID"] = GridView1.SelectedRow.Cells[1].Text;
            
            // Populate form fields from GridView cells
            txtEmail.Text = GridView1.SelectedRow.Cells[2].Text;
            txtDisplayName.Text = GridView1.SelectedRow.Cells[3].Text;
            lblStoredPassword.Text = GridView1.SelectedRow.Cells[4].Text; // Password stored in hidden label
            ddlRole.SelectedValue = GridView1.SelectedRow.Cells[5].Text;
            
            // Handle IsActive checkbox
            string isActiveValue = GridView1.SelectedRow.Cells[6].Text;
            chkIsActive.Checked = (isActiveValue.ToLower() == "true");
            
            // Clear password field (user can enter new password or leave blank)
            txtPassword.Text = "";
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Check validation controls
            if (!Page.IsValid)
            {
                return;
            }

            try
            {
                SqlDataSource1.Insert();
                ClearFields();
                GridView1.DataBind();
                lblStatus.Visible = true;
                lblStatus.Text = "User added successfully.";
                lblError.Visible = false;
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "Error adding user: " + ex.Message;
                lblStatus.Visible = false;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Session["SelectedUserID"] == null)
            {
                lblError.Visible = true;
                lblError.Text = "Please select a user from the grid first.";
                return;
            }

            // Check validation controls
            if (!Page.IsValid)
            {
                return;
            }

            try
            {
                // If password field is empty, keep the old password
                // Otherwise, update with new password
                if (string.IsNullOrWhiteSpace(txtPassword.Text))
                {
                    // Update without changing password - use manual update
                    UpdateUserWithoutPassword();
                }
                else
                {
                    // Update with new password - use SqlDataSource with password update
                    UpdateUserWithPassword();
                }

                ClearFields();
                GridView1.DataBind();
                Session["SelectedUserID"] = null;
                lblStatus.Visible = true;
                lblStatus.Text = "User updated successfully.";
                lblError.Visible = false;
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "Error updating user: " + ex.Message;
                lblStatus.Visible = false;
            }
        }

        private void UpdateUserWithoutPassword()
        {
            // Use SqlDataSource.Update() - password is excluded from UpdateCommand
            SqlDataSource1.Update();
        }

        private void UpdateUserWithPassword()
        {
            // Temporarily change UpdateCommand to include password
            string originalUpdateCommand = SqlDataSource1.UpdateCommand;
            
            try
            {
                SqlDataSource1.UpdateCommand = "UPDATE [Users] SET [Email] = @Email, [DisplayName] = @DisplayName, [Password] = @Password, [Role] = @Role, [IsActive] = @IsActive WHERE [ID] = @ID";
                
                // Add password parameter
                SqlDataSource1.UpdateParameters.Clear();
                SqlDataSource1.UpdateParameters.Add("Email", txtEmail.Text.Trim());
                SqlDataSource1.UpdateParameters.Add("DisplayName", txtDisplayName.Text.Trim());
                SqlDataSource1.UpdateParameters.Add("Password", txtPassword.Text);
                SqlDataSource1.UpdateParameters.Add("Role", ddlRole.SelectedValue);
                SqlDataSource1.UpdateParameters.Add("IsActive", chkIsActive.Checked.ToString());
                SqlDataSource1.UpdateParameters.Add("ID", Session["SelectedUserID"].ToString());
                
                SqlDataSource1.Update();
            }
            finally
            {
                // Restore original UpdateCommand
                SqlDataSource1.UpdateCommand = originalUpdateCommand;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (Session["SelectedUserID"] == null)
            {
                lblError.Visible = true;
                lblError.Text = "Please select a user from the grid first.";
                return;
            }

            try
            {
                SqlDataSource1.Delete();
                ClearFields();
                GridView1.DataBind();
                lblStatus.Visible = true;
                lblStatus.Text = "User has been deleted!";
                lblError.Visible = false;
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "Error deleting user: " + ex.Message;
                lblStatus.Visible = false;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearFields();
        }

        private void ClearFields()
        {
            txtEmail.Text = "";
            txtDisplayName.Text = "";
            txtPassword.Text = "";
            lblStoredPassword.Text = "";
            ddlRole.SelectedIndex = 0;
            chkIsActive.Checked = true;
            Session["SelectedUserID"] = null;
            GridView1.SelectedIndex = -1;
            lblError.Visible = false;
            lblStatus.Visible = false;
        }
    }
}
