using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ubilingua.Models;
using Ubilingua.Logic;
using Microsoft.AspNet.Identity;

namespace Ubilingua
{
    public partial class SubjectPassword : System.Web.UI.Page
    {
        private int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            var _db = new Model1();
            id = Convert.ToInt32(Request.QueryString["subjectID"]);
            string name = (from subjects in _db.subjects where subjects.SubjectID == id select subjects.SubjectName).SingleOrDefault();
            SubjectName.Text = name;
        }

        protected void AccessSubject_Click(object sender, EventArgs e)
        {
            AddJoinSubjectUser addJoin = new AddJoinSubjectUser();
            bool addSuccess = addJoin.AddJoinSubjectUsers(id, User.Identity.GetUserId());
            if (addSuccess)
            {
                Response.Redirect("Subject.aspx?subjectID=" + id);
            }
            
        }
    }


}