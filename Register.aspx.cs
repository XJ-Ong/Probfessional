using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Probfessional
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect if already logged in
            if (Session["UserID"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string email = txtEmail.Text.Trim();
            string displayName = txtDisplayName.Text.Trim();
            string password = txtPassword.Text;
            string role = rbTeacher.Checked ? "Teacher" : "Learner";

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Check if email already exists
                    string checkEmailQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                    using (SqlCommand checkCmd = new SqlCommand(checkEmailQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Email", email);
                        int count = (int)checkCmd.ExecuteScalar();
                        
                        if (count > 0)
                        {
                            // Email already exists
                            ClientScript.RegisterStartupScript(this.GetType(), "EmailExists", 
                                "alert('This email is already registered. Please use a different email or login.');", true);
                            return;
                        }
                    }

                    // Insert new user
                    string insertQuery = @"INSERT INTO Users (Email, DisplayName, Password, Role, CreatedAt, IsActive) 
                                         VALUES (@Email, @DisplayName, @Password, @Role, GETDATE(), 1);
                                         SELECT SCOPE_IDENTITY();";
                    
                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@DisplayName", displayName);
                        cmd.Parameters.AddWithValue("@Password", password);
                        cmd.Parameters.AddWithValue("@Role", role);

                        // Get the new user ID
                        int newUserID = Convert.ToInt32(cmd.ExecuteScalar());

                        // Registration successful - automatically log in
                        Session["UserID"] = newUserID.ToString();
                        Session["Email"] = email;
                        Session["DisplayName"] = displayName;
                        Session["Role"] = role;

                        // Redirect based on role
                        if (role == "Teacher")
                        {
                            Response.Redirect("Modules.aspx");
                        }
                        else
                        {
                            Response.Redirect("Default.aspx");
                        }
                    }
                }
            }
            catch (Exception)
            {
                // Log error
                ClientScript.RegisterStartupScript(this.GetType(), "RegistrationError", 
                    "alert('Registration failed. Please try again.');", true);
            }
        }
    }
}