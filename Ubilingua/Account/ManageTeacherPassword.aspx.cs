using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Ubilingua.Models;

namespace Ubilingua.Account
{
    public partial class ManageTeacherPassword : System.Web.UI.Page
    {
 

        protected void Page_Load(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

            if (!IsPostBack)
            {
               

                // Presentar mensaje de operación correcta
                var message = Request.QueryString["m"];
                if (message != null)
                {
                    // Seccionar la cadena de consulta desde la acción
                    Form.Action = ResolveUrl("~/Account/Manage");
                }
            }
        }

        protected void ChangePassword_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using(SubjectContext _db = new SubjectContext())
                {
                    TeacherPassword pass = _db.TeacherPasswords.FirstOrDefault();
                    if(pass.Password == CurrentPassword.Text)
                    {
                        pass.Password = NewPassword.Text;
                        _db.SaveChanges();
                        Response.Redirect("~/Account/Manage?m=ChangeTeachPwdSuccess");
                    }
                }
            }
        }


    }
}