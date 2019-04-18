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

        public IQueryable<Ubilingua.Models.subjects> GetSubjects([QueryString("subjectID")] int? subjectId)
        {
            var _db = new Model1();
            IQueryable<Ubilingua.Models.subjects> query = (IQueryable<Ubilingua.Models.subjects>)_db.subjects;
            if(subjectId.HasValue && subjectId > 0)
            {
                query = query.Where(s => s.SubjectID == subjectId);
            }
            return query;
        }
    }
}