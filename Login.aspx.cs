using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Probfessional
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect if already logged in
            if (Session["UserID"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT ID, Email, DisplayName, Password, Role, IsActive FROM Users WHERE Email = @Email";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Check if account is active
                                if (!Convert.ToBoolean(reader["IsActive"]))
                                {
                                    lblError.Visible = true;
                                    lblError.Text = "Your account is inactive. Please contact administrator.";
                                    return;
                                }

                                // Verify password (plain text comparison)
                                string savedPassword = reader["Password"].ToString();

                                if (password == savedPassword)
                                {
                                    // Login successful - store user info in session
                                    Session["UserID"] = reader["ID"].ToString();
                                    Session["Email"] = reader["Email"].ToString();
                                    Session["DisplayName"] = reader["DisplayName"].ToString();
                                    Session["Role"] = reader["Role"].ToString();

                                    // Redirect based on role
                                    string role = reader["Role"].ToString();
                                    if (role == "Admin")
                                    {
                                        Response.Redirect("Admin.aspx");
                                    }
                                    else if (role == "Teacher")
                                    {
                                        Response.Redirect("Modules.aspx");
                                    }
                                    else
                                    {
                                        Response.Redirect("Default.aspx");
                                    }
                                }
                                else
                                {
                                    // Invalid password
                                    lblError.Visible = true;
                                    lblError.Text = "Invalid email or password. Please try again.";
                                }
                            }
                            else
                            {
                                // User not found
                                lblError.Visible = true;
                                lblError.Text = "Invalid email or password. Please try again.";
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {
                // Log error (you should implement proper logging)
                lblError.Visible = true;
                lblError.Text = "An error occurred. Please try again later.";
                // In production, log exception details to a file/database
            }
        }
    }
}