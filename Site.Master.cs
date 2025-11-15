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
            if (Session["UserID"] != null)
            {
                divAuthButtons.Visible = false;
                divUserProfile.Visible = true;

                string displayName = "User";
                if (Session["DisplayName"] != null)
                {
                    displayName = Session["DisplayName"].ToString();
                }
                spanUserDisplayName.InnerText = displayName;
            }
            else
            {
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
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            if (!string.IsNullOrEmpty(searchTerm))
            {
                Response.Redirect("SearchResults.aspx?q=" + Server.UrlEncode(searchTerm));
            }
        }
    }
}