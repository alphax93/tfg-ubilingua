using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ubilingua.Models;
using System.Web.ModelBinding;

namespace Ubilingua
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public IQueryable<Ubilingua.Models.Subject> GetSubjects([QueryString("subjectID")] int? subjectId)
        {
            var _db = new SubjectContext();
            IQueryable<Ubilingua.Models.Subject> query = (IQueryable<Ubilingua.Models.Subject>)_db.Subjects;
            if(subjectId.HasValue && subjectId > 0)
            {
                query = query.Where(s => s.SubjectID == subjectId);
            }
            return query;
        }
    }
}