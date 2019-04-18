using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO.Compression;
using System.IO;
using Ubilingua.Models;
using Microsoft.AspNet.Identity;
using System.Web.Security;
using Microsoft.AspNet.Identity.Owin;
using System.Web.UI.HtmlControls;

namespace Ubilingua
{
    public partial class adminPanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ViewTeachers();
        }

        protected void Backup(object sender, EventArgs e)
        {
            string name = Server.MapPath("~/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "backup.zip");
            ZipFile.CreateFromDirectory(Server.MapPath("~/Subjects/"), name);
            FileInfo file = new FileInfo(name);
            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
            Response.AddHeader("Content-Length", file.Length.ToString());
            Response.ContentType = "text/plain";

            Response.TransmitFile(file.FullName);
            Response.Flush();
            File.Delete(name);
            Response.End();


        }

        public IQueryable<ApplicationUser> ViewTeachers()
        {
            List<ApplicationUser> users = new ApplicationDbContext().Users.ToList();
            
            return (from user in users where user.Roles.Any(r => r.RoleId == "1") select user).AsQueryable();

        }

        public IQueryable<ApplicationUser> ViewStudents()
        {
            List<ApplicationUser> users = new ApplicationDbContext().Users.ToList();

            return (from user in users where user.Roles.Any(r => r.RoleId == "2") select user).AsQueryable();

        }

        public void DeleteUser(object sender, CommandEventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
          
            var userForDeleting = manager.FindById(e.CommandArgument.ToString());
            manager.Delete(userForDeleting);

            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
            
            teacherGrid.DataBind();
            studentGrid.DataBind();
        }

        public void ChangeToStudent(object sender, CommandEventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

            var userForDeleting = manager.FindById(e.CommandArgument.ToString());
            manager.RemoveFromRole(e.CommandArgument.ToString(),"Profesor");
            manager.AddToRole(e.CommandArgument.ToString(), "Alumno");
            
            teacherGrid.DataBind();
            studentGrid.DataBind();
        }

        public void ChangeToTeacher(object sender, CommandEventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

            var userForDeleting = manager.FindById(e.CommandArgument.ToString());
            manager.RemoveFromRole(e.CommandArgument.ToString(), "Alumno");
            manager.AddToRole(e.CommandArgument.ToString(), "Profesor");
            
            teacherGrid.DataBind();
            studentGrid.DataBind();
        }


    }
}