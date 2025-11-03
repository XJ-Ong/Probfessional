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
            
            // Check if email already exists using 6-step pattern
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);
            
            try
            {
                conn.Open();
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                SqlCommand comm = new SqlCommand(checkQuery, conn);
                comm.Parameters.AddWithValue("@Email", email);
                
                int count = (int)comm.ExecuteScalar();
                
                if (count > 0)
                {
                    lblError.Visible = true;
                    lblError.Text = "This email is already registered. Please use a different email or login.";
                    return;
                }
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "An error occurred while checking email. Please try again.";
            }
            finally
            {
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }

            // Use SqlDataSource to insert new user
            try
            {
                SqlDataSource1.Insert();
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "Registration failed. Please try again.";
            }
        }

        protected void SqlDataSource1_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            // Get the newly inserted user ID
            string email = txtEmail.Text.Trim();
            string displayName = txtDisplayName.Text.Trim();
            string role = rdolRole.SelectedValue;
            
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);
            
            try
            {
                conn.Open();
                string query = "SELECT ID FROM Users WHERE Email = @Email";
                SqlCommand comm = new SqlCommand(query, conn);
                comm.Parameters.AddWithValue("@Email", email);
                
                object result = comm.ExecuteScalar();
                if (result != null)
                {
                    int newUserID = Convert.ToInt32(result);
                    
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
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "Registration successful but login failed. Please login manually.";
            }
            finally
            {
                if (conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }
        }
    }
}