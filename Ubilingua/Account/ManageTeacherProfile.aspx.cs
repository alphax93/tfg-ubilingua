using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Ubilingua.Models;
using Ubilingua.NewExtensions;

namespace Ubilingua.Account
{
    public partial class ManageTeacherProfile : System.Web.UI.Page
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

                using (Model1 _db = new Model1())
                {
                    string id = User.Identity.GetUserId();
                    teachers teacher = (from Teachers in _db.teachers where Teachers.UserID == id select Teachers).FirstOrDefault();
                    if (teacher != null)
                    {
                        update.Visible = true;
                        Position.Text = teacher.Position;
                        Contact.Text = teacher.Contact;
                        SpanishRole.Text = teacher.SpanishRole;
                        OtherRole.Text = teacher.OtherRole;
                        SpanishCV.Text = teacher.SpanishCV;
                        OtherCV.Text = teacher.OtherRole;
                    }
                    else
                    {
                        create.Visible = true;
                    }
                }
            }
        }

        protected void TeacherProfile_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                teachers teacher = new teachers
                {
                    Position = Position.Text,
                    Contact = Contact.Text,
                    SpanishRole = SpanishRole.Text,
                    OtherRole = OtherRole.Text,
                    SpanishCV = SpanishCV.Text,
                    OtherCV = OtherCV.Text,
                    UserID = User.Identity.GetUserId(),
                    TeacherName = User.Identity.GetName() + User.Identity.GetSurname1() + User.Identity.GetSurname2()
                };
                if (Image.HasFile)
                {
                    try
                    {
                        string fileName = System.IO.Path.GetFileName(Image.FileName);
                        Image.SaveAs(Server.MapPath("Subjects/Images/") + fileName);
                        teacher.Image = fileName;

                    }
                    catch (Exception ex)
                    {

                    }
                }
                using (Model1 _db = new Model1())
                {
                    _db.teachers.Add(teacher);
                    _db.SaveChanges();
                    Response.Redirect("~/Account/Manage?m=TeacherProfSuccess");
                }

            }
        }

        protected void UpdateTeacherProfile_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (Model1 _db = new Model1())
                {
                    string id = User.Identity.GetUserId();
                    teachers teacher = (from Teachers in _db.teachers where Teachers.UserID == id select Teachers).FirstOrDefault();

                    teacher.Position = Position.Text;
                    teacher.Contact = Contact.Text;
                    teacher.SpanishRole = SpanishRole.Text;
                    teacher.OtherRole = OtherRole.Text;
                    teacher.SpanishCV = SpanishCV.Text;
                    teacher.OtherCV = OtherCV.Text;
                    teacher.UserID = User.Identity.GetUserId();
                    teacher.TeacherName = User.Identity.GetName() + User.Identity.GetSurname1() + User.Identity.GetSurname2();

                    if (Image.HasFile)
                    {
                        try
                        {
                            string fileName = System.IO.Path.GetFileName(Image.FileName);
                            Image.SaveAs(Server.MapPath("Subjects/Images/") + fileName);
                            teacher.Image = fileName;

                        }
                        catch (Exception ex)
                        {

                        }
                    }

                    _db.SaveChanges();
                    Response.Redirect("~/Account/Manage?m=TeacherProfSuccess");
                }

            }
        }

        public void DeleteTeacherProfile_Click(object sender, EventArgs e)
        {
            using (Model1 _db = new Model1())
            {
                string id = User.Identity.GetUserId();
                teachers teacher = (from Teachers in _db.teachers where Teachers.UserID == id select Teachers).FirstOrDefault();
                _db.teachers.Remove(teacher);
                _db.SaveChanges();
            }
        }

    }
}