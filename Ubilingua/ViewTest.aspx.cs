using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ubilingua.Models;
using System.Web.UI.HtmlControls;

namespace Ubilingua
{
    public partial class ViewTest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var _db = new Model1();
            int id = Convert.ToInt32(Request.QueryString["ResourceID"]);

            resources res = (from resources in _db.resources where resources.ResourceID == id select resources).First();

            frame.Src = "~/Subjects/1/Tests/7/index.html";
        }
    }
}