using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Ubilingua.Models;
using Ubilingua.NewExtensions;

namespace Ubilingua
{
    public partial class Riddle : System.Web.UI.Page
    {
        public RiddleResource riddleRes;
        int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            var _db = new SubjectContext();
            id = Convert.ToInt32(Request.QueryString["ResourceID"]);
            riddleRes = (from riddles in _db.RiddleResources where riddles.ResourceID == id select riddles).FirstOrDefault();

            Label label = (Label)Page.FindControlRecursive("name");
            label.Text = riddleRes.RiddleName;

            HtmlSource audioSource = (HtmlSource)Page.FindControlRecursive("audioSource");
            audioSource.Src = "Resources/" + riddleRes.AudioPath;

            if (riddleRes.ImagePath == "")
            {
                Panel container = (Panel)Page.FindControlRecursive("imagePanelContainer");
                container.Visible = false;
            } else
            {
                Image img = (Image)Page.FindControlRecursive("imageImage");
                img.ImageUrl = "Resources/" + riddleRes.ImagePath;
            }

            if(riddleRes.Text == "")
            {
                Panel container = (Panel)Page.FindControlRecursive("OGTextPanelContainer");
                container.Visible = false;
            } else
            {
                HtmlGenericControl txt = (HtmlGenericControl)Page.FindControlRecursive("ogtext");
                txt.InnerText = riddleRes.Text;
            }

            if (riddleRes.TranslatedText == "")
            {
                Panel container = (Panel)Page.FindControlRecursive("TransTextPanelContainer");
                container.Visible = false;
            }
            else
            {
                HtmlGenericControl txt = (HtmlGenericControl)Page.FindControlRecursive("transtext");
                txt.InnerText = riddleRes.TranslatedText;
            }
            HtmlGenericControl answer = (HtmlGenericControl)Page.FindControlRecursive("answer");
            answer.InnerText = riddleRes.Answer;

        }
    }
}