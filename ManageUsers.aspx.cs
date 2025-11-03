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
            // Check if user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Check if user is admin
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                lblError.Visible = true;
                lblError.Text = "Access denied. Only administrators can manage users.";
                GridView1.Visible = false;
                return;
            }

            if (!IsPostBack)
            {
                ClearFields();
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get selected row data and populate input fields
            if (GridView1.SelectedRow != null)
            {
                int selectedID = Convert.ToInt32(GridView1.SelectedDataKey.Value);
                Session["SelectedUserID"] = selectedID;

                // Load user data using 6-step connection pattern
                // Step 2: Create connection
                string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                SqlConnection conn = new SqlConnection(connStr);

                try
                {
                    // Step 3: Open connection
                    conn.Open();

                    // Step 4: Prepare SqlCommand
                    string query = "SELECT Email, DisplayName, Role, IsActive FROM Users WHERE ID = @ID";
                    SqlCommand comm = new SqlCommand(query, conn);
                    comm.Parameters.AddWithValue("@ID", selectedID);

                    // Step 5: Execute reader
                    SqlDataReader reader = comm.ExecuteReader();
                    if (reader.Read())
                    {
                        txtEmail.Text = reader["Email"].ToString();
                        txtDisplayName.Text = reader["DisplayName"].ToString();
                        ddlRole.SelectedValue = reader["Role"].ToString();
                        chkIsActive.Checked = Convert.ToBoolean(reader["IsActive"]);
                        txtPassword.Text = ""; // Don't show password
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    lblError.Visible = true;
                    lblError.Text = "Error loading user data: " + ex.Message;
                }
                finally
                {
                    // Step 6: Close connection
                    if (conn.State == System.Data.ConnectionState.Open)
                        conn.Close();
                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Validate required fields
            if (string.IsNullOrWhiteSpace(txtEmail.Text) || 
                string.IsNullOrWhiteSpace(txtDisplayName.Text) || 
                string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblError.Visible = true;
                lblError.Text = "Please fill in all required fields (Email, Display Name, Password).";
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

            // Validate required fields
            if (string.IsNullOrWhiteSpace(txtEmail.Text) || 
                string.IsNullOrWhiteSpace(txtDisplayName.Text))
            {
                lblError.Visible = true;
                lblError.Text = "Please fill in all required fields (Email, Display Name).";
                return;
            }

            try
            {
                // If password is empty, don't update password
                if (string.IsNullOrWhiteSpace(txtPassword.Text))
                {
                    // Use a separate update without password
                    // Step 2: Create connection
                    string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                    SqlConnection conn = new SqlConnection(connStr);

                    try
                    {
                        // Step 3: Open connection
                        conn.Open();

                        // Step 4: Prepare SqlCommand
                        string query = "UPDATE [Users] SET [Email] = @Email, [DisplayName] = @DisplayName, [Role] = @Role, [IsActive] = @IsActive WHERE [ID] = @ID";
                        SqlCommand comm = new SqlCommand(query, conn);
                        comm.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        comm.Parameters.AddWithValue("@DisplayName", txtDisplayName.Text.Trim());
                        comm.Parameters.AddWithValue("@Role", ddlRole.SelectedValue);
                        comm.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);
                        comm.Parameters.AddWithValue("@ID", Session["SelectedUserID"]);

                        // Step 5: Execute command
                        comm.ExecuteNonQuery();
                    }
                    finally
                    {
                        // Step 6: Close connection
                        if (conn.State == System.Data.ConnectionState.Open)
                            conn.Close();
                    }
                }
                else
                {
                    SqlDataSource1.Update();
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
            ddlRole.SelectedIndex = 0;
            chkIsActive.Checked = true;
            Session["SelectedUserID"] = null;
            GridView1.SelectedIndex = -1;
            lblError.Visible = false;
            lblStatus.Visible = false;
        }
    }
}

