using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Probfessional
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Update Get Started button based on login status
            if (Session["UserID"] != null)
            {
                // User is logged in - redirect to Progress page
                lnkGetStarted.NavigateUrl = "~/Progress.aspx";
            }
            else
            {
                // User is not logged in - redirect to Register page
                lnkGetStarted.NavigateUrl = "~/Register.aspx";
            }
        }
    }
}