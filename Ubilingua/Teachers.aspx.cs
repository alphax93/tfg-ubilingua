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

            PopulateMultiview();    
            
        }

        protected void Menu_Click(Object sender, MenuEventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("CLICK: "+ Multiview.Views.Count);
            Multiview.ActiveViewIndex = Int32.Parse(e.Item.Value);
        }

        private void PopulateMenu()
        {
            var _db = new SubjectContext();
            List<Teacher> teachers = _db.Teachers.ToList();
            foreach(Teacher teacher in teachers)
            {
                MenuItem menuItem = new MenuItem
                {
                    Value = (teacher.TeacherID-1).ToString(),
                    Text = teacher.TeacherName,


                };
                if (menuItem.Value == "0") menuItem.Selected = true;
                
                Menu1.Items.Add(menuItem);

                
                //System.Diagnostics.Debug.WriteLine(Multiview.Views.Count);



            }
            //System.Diagnostics.Debug.WriteLine(Multiview.Views.Count);
        }

        private void PopulateMultiview()
        {
            var _db = new SubjectContext();
            List<Teacher> teachers = _db.Teachers.ToList();
            foreach (Teacher teacher in teachers)
            {
                View view = new View { ID = "Tab" + (teacher.TeacherID - 1).ToString(), };
                
               
                
                view.Controls.Add(new Literal { Text = 
                    "<h2>" + teacher.Position + "</h2>" +
                    "<br><div style='float: left;'><img src='Subjects/Images/teacher0.jpg' style=' margin-right: 10px'><img></div>" +
                    "<div><h3>Función en el grupo</h3>" +
                    "<br><p style='text-align:justify'>" + teacher.SpanishRole + "</p>" +
                    "<p style='text-align:justify'><i>" + teacher.OtherRole + "</i></p></div>" +
                    "<div><h3>CV</h3>" +
                    "<br><p style='text-align:justify'>" + teacher.SpanishCV + "</p>" +
                    "<p style='text-align:justify'><i>" + teacher.OtherCV + "</i></p></div>"
                });
                Multiview.Views.Add(view);
            }
            Multiview.ActiveViewIndex = 0;
        }
    }
}