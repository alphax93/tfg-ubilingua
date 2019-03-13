using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ubilingua.Logic;
using Microsoft.AspNet.Identity;

namespace Ubilingua
{
    public partial class CreateSubject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateSubject_Click(object sender, EventArgs e)
        {
            string image = "default.jpg";
            if (FileUpload.HasFile)
            {
                if (FileUpload.PostedFile.ContentType == "image/jpeg" || FileUpload.PostedFile.ContentType == "image/png")
                {
                    try
                    {
                        string filename = Path.GetFileName(FileUpload.FileName);
                        FileUpload.SaveAs(Server.MapPath("~/Subjects/Images/") + filename);
                        image = filename;
                        
                    }
                    catch (Exception ex)
                    {

                    }
                }
            }
            SubjectCRUD subjects = new SubjectCRUD();
            bool addSuccess = subjects.AddSubjects(SubjectName.Text, image, Password.Text,User.Identity.GetUserId());
            if (addSuccess)
            {

                Response.Redirect("~");
            }
        }
    }
}