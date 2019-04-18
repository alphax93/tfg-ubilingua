using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ubilingua.Models;
using Ubilingua.NewExtensions;
using Microsoft.AspNet.Identity;

namespace Ubilingua
{
    public partial class SubjectMarks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public IQueryable<joinusermarks> GetElements([QueryString("subjectID")] int? subjectId)
        {
            var _db = new Model1();
           
            IQueryable<joinusermarks> query = _db.joinusermarks;
            string id = User.Identity.GetUserId();

                query = query.Where(b => b.UserID == id && b.SubjectID==subjectId);
            
            return query;
        }
    }
}