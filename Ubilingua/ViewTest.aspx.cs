using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ubilingua.Models;
using System.Web.UI.HtmlControls;
using System.Web.Services;
using System.Web.Script.Services;
using Ubilingua.Logic;
using Microsoft.AspNet.Identity;
using Ubilingua.NewExtensions;

namespace Ubilingua
{
    public partial class ViewTest : System.Web.UI.Page
    {
        public int resID;
        public static int id;
        public static string userID;
        public static string userName;
        public static int subID;

        
        protected void Page_Load(object sender, EventArgs e)
        {
            var _db = new Model1();
            resID = Convert.ToInt32(Request.QueryString["ResourceID"]);
            id = resID;
            resources res = (from resources in _db.resources where resources.ResourceID == resID select resources).First();
            int subjectID = (from blocks in _db.blocks where blocks.BlockID == res.BlockID select blocks.SubjectID).First();
            frame.Src = "~/Subjects/" +subjectID+ "/Tests/"+ res.ResourceID +"/index.html";

            string userIDtmp = User.Identity.GetUserId();
            userID = userIDtmp;

            string nametmp = User.Identity.GetName() + " " + User.Identity.GetSurname1() + " " + User.Identity.GetSurname2();
            userName = nametmp;

            subID = subjectID;
        }

        [WebMethod]
        public static string SaveScore(string a)
        {
            AddJoinUserMark addMark = new AddJoinUserMark();
            addMark.AddJoinUserMarkTest(id, userID, userName, subID, float.Parse(a)/10);
            return a;
        }
    }
}