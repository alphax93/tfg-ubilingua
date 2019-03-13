using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ubilingua.Models;
using System.Web.ModelBinding;
using System.IO;

namespace Ubilingua
{
    public partial class Teachers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack) PopulateMenu();
        }

        protected void Page_Init(object sender, EventArgs e)
        {

            //PopulateMultiview();    
            
        }

        protected void Menu_Click(Object sender, MenuEventArgs e)
        {
            // Multiview.ActiveViewIndex = Int32.Parse(e.Item.Value);
            PopulateMultiview(Int32.Parse(e.Item.Value));
        }

        private void PopulateMenu()
        {
            var _db = new SubjectContext();
            List<Teacher> teachers = _db.Teachers.ToList();
            bool first = true;
            foreach(Teacher teacher in teachers)
            {
                MenuItem menuItem = new MenuItem
                {
                    Value = (teacher.TeacherID).ToString(),
                    Text = teacher.TeacherName,


                };
                if (first)
                {
                    menuItem.Selected = true;
                    first = false;
                    PopulateMultiview(Int32.Parse(menuItem.Value));
                }
                Menu1.Items.Add(menuItem);

                
                //System.Diagnostics.Debug.WriteLine(Multiview.Views.Count);



            }
            //System.Diagnostics.Debug.WriteLine(Multiview.Views.Count);
        }

        private void PopulateMultiview(int id)
        {
            var _db = new SubjectContext();
            //List<Teacher> teachers = _db.Teachers.ToList();
            //foreach (Teacher teacher in teachers)
            //{
            //    View view = new View { ID = "Tab" + (teacher.TeacherID - 1).ToString(), };

            Teacher teacher = (from Teachers in _db.Teachers where Teachers.TeacherID == id select Teachers).FirstOrDefault();
            
            content.Text = 
                    "<h2>" + teacher.Position + "</h2>" +
                    "<br><div style='float: left;'><img src='Subjects/Images/"+  teacher.Image + "' style=' margin-right: 10px'><img></div>" +
                    "<div><h3>Función en el grupo</h3>" +
                    "<br><p style='text-align:justify; white - space: pre'>" + teacher.SpanishRole + "</p>" +
                    "<p style='text-align:justify; white - space: pre'><i>" + teacher.OtherRole + "</i></p></div>" +
                    "<div><h3>CV</h3>" +
                    "<br><p style='text-align:justify; white - space: pre'>" + teacher.SpanishCV + "</p>" +
                    "<p style='text-align:justify; white - space: pre'><i>" + teacher.OtherCV + "</i></p></div>" +
                    "<div><h3>Contacto</h3>"+
                    "<br><p style='text-align:justify; white - space: pre'>" + teacher.Contact + "</p></div>";
                //Multiview.Views.Add(view);
            //}
            //Multiview.ActiveViewIndex = 0;
        }
    }
}