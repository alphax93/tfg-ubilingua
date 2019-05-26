using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Ubilingua.Models;
using Ubilingua.NewExtensions;
using Microsoft.AspNet.Identity;
using System.IO;
using Ubilingua.Logic;
using System.Web.ModelBinding;

namespace Ubilingua
{
    public partial class ViewTask : System.Web.UI.Page
    {
        public int id;
        bool alredySent;
        public int subjectID;
        protected void Page_Load(object sender, EventArgs e)
        {
            var _db = new Model1();
            id = Convert.ToInt32(Request.QueryString["ResourceID"]);
            int blockID = (from resources in _db.resources where resources.ResourceID == id select resources.BlockID).First();
            subjectID = (from blocks in _db.blocks where blocks.BlockID == blockID select blocks.SubjectID).First();
            taskresources task = (from tasks in _db.taskresources where tasks.ResourceID == id select tasks).FirstOrDefault();

            Label name = (Label)Page.FindControlRecursive("name");
            name.Text = task.TaskName;

            HtmlGenericControl desc = (HtmlGenericControl)Page.FindControlRecursive("description");
            desc.InnerText = task.Text;

            if (User.IsInRole("Profesor")||User.IsInRole("admin"))
            {
                TableCell dateCell = (TableCell)Page.FindControlRecursive("date");
                dateCell.Text = task.Deadline.ToString();

                TableCell leftCell = (TableCell)Page.FindControlRecursive("leftTime");
                TimeSpan timeLeft = task.Deadline.Subtract(DateTime.Now);
                int days = (int)timeLeft.TotalDays;
                int hours = (int)timeLeft.TotalHours - days * 24;
                int minutes = (int)timeLeft.TotalMinutes - (days * 24 * 60 + hours * 60);
                if(minutes < 0)
                {
                    leftCell.Text = "Hace " + days + " días " + hours + " horas " + minutes + " minutos";
                    leftCell.ForeColor = System.Drawing.Color.Red;
                } else
                {
                    leftCell.Text = "Quedan " + days + " días " + hours + " horas " + minutes + " minutos";
                }
                
            }
            if (User.IsInRole("Alumno"))
            {
                TableCell dateCell = (TableCell)Page.FindControlRecursive("date");
                dateCell.Text = task.Deadline.ToString();

                TableCell leftCell = (TableCell)Page.FindControlRecursive("leftTime");
                TimeSpan timeLeft = task.Deadline.Subtract(DateTime.Now);
                int days = (int)timeLeft.TotalDays;
                int hours = (int)timeLeft.TotalHours - days * 24;
                int minutes = (int)timeLeft.TotalMinutes - (days * 24 * 60 + hours * 60);
                Label warning = (Label)Page.FindControlRecursive("warning");
                warning.Visible = false;
                if (minutes < 0)
                {
                    leftCell.Text = "Hace " + days + " días " + hours + " horas " + minutes + " minutos";
                    leftCell.ForeColor = System.Drawing.Color.Red;
                    TableCell uploadCell = (TableCell)Page.FindControlRecursive("uploadCell");
                    uploadCell.Visible = false;
                    Button uploadButton = (Button)Page.FindControlRecursive("uploadButton");
                    uploadButton.Visible = false;
                    
                }
                else
                {
                    leftCell.Text = "Quedan " + days + " días " + hours + " horas " + minutes + " minutos";
                }
                string currentID = User.Identity.GetUserId();
                joinusermarks joinUserMark = (from joinUserMarks in _db.joinusermarks where joinUserMarks.ResourceID == id && joinUserMarks.UserID == currentID select joinUserMarks).FirstOrDefault();
                if (joinUserMark != null)
                {
                    alredySent = true;
                    if(joinUserMark.FilePath != "" && joinUserMark.Mark == 0)
                    {
                        TableCell status = (TableCell)Page.FindControlRecursive("status");
                        status.Text = "Entregado";
                        TableCell file = (TableCell)Page.FindControlRecursive("file");
                        file.Text = joinUserMark.FilePath + " (" + joinUserMark.Delivered.ToString() + ")";
                        warning.Visible = true;

                    }
                    if(joinUserMark.FilePath != "" && joinUserMark.Mark != 0)
                    {
                        TableCell status = (TableCell)Page.FindControlRecursive("status");
                        status.Text = "Calificado";
                        TableCell file = (TableCell)Page.FindControlRecursive("file");
                        file.Text = joinUserMark.FilePath;
                        TableCell mark = (TableCell)Page.FindControlRecursive("mark");
                        mark.Text = joinUserMark.Mark.ToString();
                        Button uploadButton = (Button)Page.FindControlRecursive("uploadButton");
                        uploadButton.Visible = false;

                    }
                }
            }
        }

        protected void Upload_Click(object sender, EventArgs e)
        {
            FileUpload fileUpload = (FileUpload)Page.FindControlRecursive("fileUpload");
            if (fileUpload.HasFile)
            {
                string fileName = Path.GetFileName(fileUpload.FileName);
                string path = "Subjects/" + subjectID + "/Tasks/" + id + "/";
                fileUpload.SaveAs(Server.MapPath(path) + User.Identity.GetUserId() + fileName);
                AddJoinUserMark join = new AddJoinUserMark();
                if (alredySent)
                {
                    bool updateSuccess = join.UpdateJoinUserMarks(id, User.Identity.GetUserId(), User.Identity.GetUserId() + fileName);
                    if (updateSuccess)
                    {
                        Response.Redirect(Request.RawUrl);
                    }
                }
                else
                {

                    
                    bool addSuccess = join.AddJoinUserMarks(id, User.Identity.GetUserId(),User.Identity.GetUserId()+ fileName, 
                        User.Identity.GetName() + " " + User.Identity.GetSurname1() + " " + User.Identity.GetSurname2(), subjectID);
                    if (addSuccess)
                    {
                        Response.Redirect(Request.RawUrl);
                    }
                }
            }
        }

        public IQueryable<joinusermarks> GetElements([QueryString("ResourceID")] int? resourceId)
        {
            var _db = new Model1();
            IQueryable<joinusermarks> query = _db.joinusermarks;
            if (resourceId.HasValue && resourceId > 0)
            {
                query = query.Where(b => b.ResourceID == resourceId);
            }

            return query;
        }

        public void SaveMarks(object sender, EventArgs e)
        {
            GridView list = (GridView)Page.FindControlRecursive("fileList");
            for(int i = 0; i<list.Rows.Count; i++)
            {
                GridViewRow row = list.Rows[i];
                TextBox mark = (TextBox)row.FindControlRecursive("mark");
                HiddenField userid = (HiddenField)row.FindControlRecursive("userid");
                HiddenField resourceid = (HiddenField)row.FindControlRecursive("resourceid");
                AddJoinUserMark join = new AddJoinUserMark();
                bool addSuccess = join.UpdateMark(int.Parse(resourceid.Value), userid.Value, float.Parse(mark.Text));
                if (addSuccess)
                {
                    Response.Redirect(Request.RawUrl);
                }
            }
        }

    }
}