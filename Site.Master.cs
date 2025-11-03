using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Probfessional
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in and update navigation
            if (Session["UserID"] != null)
            {
                // User is logged in - show profile and logout
                divAuthButtons.Visible = false;
                divUserProfile.Visible = true;
                
                // Display user's display name in the oval badge
                string displayName = Session["DisplayName"]?.ToString() ?? "User";
                spanUserDisplayName.InnerText = displayName;
            }
            else
            {
                // User is not logged in - show register and login buttons
                divAuthButtons.Visible = true;
                divUserProfile.Visible = false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear session
            Session.Clear();
            Session.Abandon();
            
            // Redirect to login page
            Response.Redirect("Login.aspx");
        }
    }
}