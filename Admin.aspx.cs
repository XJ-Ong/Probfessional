using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Probfessional
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Check if user is admin
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                lblError.Visible = true;
                lblError.Text = "Access denied. Only administrators can access this page.";
                GridViewQuizAttempts.Visible = false;
                btnManageUsers.Visible = false;
                return;
            }

            if (!IsPostBack)
            {
                lblAdminName.Text = Session["DisplayName"].ToString();
            }
        }

        protected void btnManageUsers_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageUsers.aspx");
        }
    }
}
