using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using AjaxControlToolkit;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Owin;
using Ubilingua.Models;
using Ubilingua.NewExtensions;

namespace Ubilingua.Account
{
    public partial class Manage : System.Web.UI.Page
    {
        protected string SuccessMessage
        {
            get;
            private set;
        }

        private bool HasPassword(ApplicationUserManager manager)
        {
            return manager.HasPassword(User.Identity.GetUserId());
        }

        public bool HasPhoneNumber { get; private set; }

        public bool TwoFactorEnabled { get; private set; }

        public bool TwoFactorBrowserRemembered { get; private set; }

        public int LoginsCount { get; set; }

        protected void Page_Load()
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            HasPhoneNumber = String.IsNullOrEmpty(manager.GetPhoneNumber(User.Identity.GetUserId()));

            // Habilitar esta opción tras configurar autenticación de dos factores
            //PhoneNumber.Text = manager.GetPhoneNumber(User.Identity.GetUserId()) ?? String.Empty;

            TwoFactorEnabled = manager.GetTwoFactorEnabled(User.Identity.GetUserId());

            LoginsCount = manager.GetLogins(User.Identity.GetUserId()).Count;
            
            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
            
            email.InnerText =  manager.GetEmail(User.Identity.GetUserId());
            EditEmail.Text = manager.GetEmail(User.Identity.GetUserId());
            var user = manager.FindById(User.Identity.GetUserId());
            

            if (!IsPostBack)
            {
                

                // Presentar mensaje de operación correcta
                var message = Request.QueryString["m"];
                if (message != null)
                {
                    // Seccionar la cadena de consulta desde la acción
                    Form.Action = ResolveUrl("~/Account/Manage");

                    
                    if(message == "ChangePwdSuccess")
                    {
                        successChangePass.Visible = true;
                    } else if (message == "ChangeUserSuccess")
                    {
                        successChangeUser.Visible = true;
                    } else if (message == "TeacherProfSuccess")
                    {
                        successTeacherProf.Visible = true;
                    }
                }
            }
        }


        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        // Quitar número de teléfono del usuario
        protected void RemovePhone_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
            var result = manager.SetPhoneNumber(User.Identity.GetUserId(), null);
            if (!result.Succeeded)
            {
                return;
            }
            var user = manager.FindById(User.Identity.GetUserId());
            if (user != null)
            {
                signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                Response.Redirect("/Account/Manage?m=RemovePhoneNumberSuccess");
            }
        }

        // DisableTwoFactorAuthentication
        protected void TwoFactorDisable_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            manager.SetTwoFactorEnabled(User.Identity.GetUserId(), false);

            Response.Redirect("/Account/Manage");
        }

        //EnableTwoFactorAuthentication 
        protected void TwoFactorEnable_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            manager.SetTwoFactorEnabled(User.Identity.GetUserId(), true);

            Response.Redirect("/Account/Manage");
        }

        public void GoToChangePassword(object sender, EventArgs e)
        {
            Response.Redirect("/Account/ManagePassword");
        }

 


        public void GoToTeacherProfile(object sender, EventArgs e)
        {
            Response.Redirect("/Account/ManageTeacherProfile");
        }

        public void ShowProfilePopu(object sender, EventArgs e)
        {
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("EditUserPopup");
            modalPopupExtender.Show();

            EditUserName.Text = User.Identity.GetName();
            EditSurname1.Text = User.Identity.GetSurname1();
            EditSurname2.Text = User.Identity.GetSurname2();
            
        }

        public void EditUser_Click(object sender, EventArgs e) {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            manager.SetEmail(User.Identity.GetUserId(), EditEmail.Text);
            var user = manager.FindById(User.Identity.GetUserId());
            user.Name = EditUserName.Text;
            user.Surname1 = EditSurname1.Text;
            user.Surname2 = EditSurname2.Text;
            manager.Update(user);

            Response.Redirect("~/Account/Manage?m=ChangeUserSuccess");

        }

        public void DeleteAccount(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var userForDeleting = manager.FindById(User.Identity.GetUserId());
            manager.Delete(userForDeleting);
            
            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
            //System.Web.Security.FormsAuthentication.SignOut();
            Response.Redirect("~");
        }

        public IQueryable<Ubilingua.Models.subjects> GetSubjects()
        {
            var _db = new Model1();
            IQueryable<joinsubjectusers> tmp = _db.joinsubjectusers;
            IQueryable<Models.subjects> query = _db.subjects;
            string userID = User.Identity.GetUserId();
            tmp = tmp.Where(r => r.UserID == userID);
            var tmp2 = tmp.ToList();
            List<Models.subjects> res = new List<Models.subjects>();
            foreach(Models.subjects s in query)
            {
                foreach(joinsubjectusers j in tmp2)
                {
                    if(j.SubjectID == s.SubjectID)
                    {
                        res.Add(s);
                        break;
                    }
                }
            }
            
            return res.AsQueryable();
        }

    }
}