using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Probfessional
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            // Load current user's profile information
            int userID = Convert.ToInt32(Session["UserID"]);
            
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
                comm.Parameters.AddWithValue("@ID", userID);

                // Step 5: Execute reader
                SqlDataReader reader = comm.ExecuteReader();
                if (reader.Read())
                {
                    txtEmail.Text = reader["Email"].ToString();
                    txtDisplayName.Text = reader["DisplayName"].ToString();
                    lblRoleDisplay.Text = reader["Role"].ToString();
                    
                    bool isActive = Convert.ToBoolean(reader["IsActive"]);
                    lblActiveStatus.Text = isActive ? "Active" : "Inactive";
                    lblActiveStatus.CssClass = isActive ? "text-success fw-bold" : "text-danger fw-bold";
                }
                reader.Close();
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "Error loading profile: " + ex.Message;
            }
            finally
            {
                // Step 6: Close connection
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // Validate required fields
            if (string.IsNullOrWhiteSpace(txtEmail.Text) || 
                string.IsNullOrWhiteSpace(txtDisplayName.Text))
            {
                lblError.Visible = true;
                lblError.Text = "Please fill in all required fields.";
                return;
            }

            int userID = Convert.ToInt32(Session["UserID"]);

            // Step 2: Create connection
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);

            try
            {
                // Step 3: Open connection
                conn.Open();

                // Step 4: Prepare SqlCommand
                string query;
                SqlCommand comm;
                
                // If password is provided, update it; otherwise, don't
                if (string.IsNullOrWhiteSpace(txtPassword.Text))
                {
                    query = "UPDATE [Users] SET [Email] = @Email, [DisplayName] = @DisplayName WHERE [ID] = @ID";
                    comm = new SqlCommand(query, conn);
                    comm.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    comm.Parameters.AddWithValue("@DisplayName", txtDisplayName.Text.Trim());
                    comm.Parameters.AddWithValue("@ID", userID);
                }
                else
                {
                    query = "UPDATE [Users] SET [Email] = @Email, [DisplayName] = @DisplayName, [Password] = @Password WHERE [ID] = @ID";
                    comm = new SqlCommand(query, conn);
                    comm.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    comm.Parameters.AddWithValue("@DisplayName", txtDisplayName.Text.Trim());
                    comm.Parameters.AddWithValue("@Password", txtPassword.Text);
                    comm.Parameters.AddWithValue("@ID", userID);
                }

                // Step 5: Execute command
                comm.ExecuteNonQuery();

                // Update session
                Session["Email"] = txtEmail.Text.Trim();
                Session["DisplayName"] = txtDisplayName.Text.Trim();

                lblStatus.Visible = true;
                lblStatus.Text = "Profile updated successfully!";
                lblError.Visible = false;
                txtPassword.Text = ""; // Clear password field
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "Error updating profile: " + ex.Message;
                lblStatus.Visible = false;
            }
            finally
            {
                // Step 6: Close connection
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }
        }

        protected void btnDeactivate_Click(object sender, EventArgs e)
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            // Step 2: Create connection
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);

            try
            {
                // Step 3: Open connection
                conn.Open();

                // Step 4: Prepare SqlCommand
                string query = "UPDATE [Users] SET [IsActive] = 0 WHERE [ID] = @ID";
                SqlCommand comm = new SqlCommand(query, conn);
                comm.Parameters.AddWithValue("@ID", userID);

                // Step 5: Execute command
                comm.ExecuteNonQuery();

                // Clear session and redirect to login
                Session.Clear();
                Session.Abandon();
                Response.Redirect("Login.aspx?deactivated=true");
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "Error deactivating account: " + ex.Message;
            }
            finally
            {
                // Step 6: Close connection
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }
        }
    }
}
