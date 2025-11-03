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

            // Step 1: Import namespaces (already at top)
            // Step 2: Create connection
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);

            try
            {
                // Step 3: Open connection
                conn.Open();

                // Step 4: Prepare SqlCommand
                string query = "SELECT ID, Email, DisplayName, Password, Role, IsActive FROM Users WHERE Email = @Email";
                SqlCommand comm = new SqlCommand(query, conn);
                comm.Parameters.AddWithValue("@Email", email);

                // Step 5: Execute reader
                SqlDataReader reader = comm.ExecuteReader();
                if (reader.Read())
                {
                    // Check if account is active
                    if (!Convert.ToBoolean(reader["IsActive"]))
                    {
                        lblError.Visible = true;
                        lblError.Text = "Your account is inactive. Please contact administrator.";
                        reader.Close();
                        return;
                    }

                    // Get user data from reader
                    string userID = reader["ID"].ToString();
                    string userEmail = reader["Email"].ToString();
                    string displayName = reader["DisplayName"].ToString();
                    string role = reader["Role"].ToString();
                    string savedPassword = reader["Password"].ToString();
                    reader.Close();

                    if (password == savedPassword)
                    {
                        // Login successful - store user info in session
                        Session["UserID"] = userID;
                        Session["Email"] = userEmail;
                        Session["DisplayName"] = displayName;
                        Session["Role"] = role;

                        // Redirect based on role
                        string userRole = Session["Role"].ToString();
                        if (userRole == "Admin")
                        {
                            Response.Redirect("Admin.aspx");
                        }
                        else if (userRole == "Teacher")
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
                        lblError.Visible = true;
                        lblError.Text = "Invalid email or password. Please try again.";
                    }
                }
                else
                {
                    reader.Close();
                    lblError.Visible = true;
                    lblError.Text = "Invalid email or password. Please try again.";
                }
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "An error occurred. Please try again later.";
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