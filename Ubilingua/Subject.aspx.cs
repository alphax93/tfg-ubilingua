using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ubilingua.Models;
using System.Web.ModelBinding;
using Microsoft.AspNet.Identity;
using Ubilingua.Logic;
using AjaxControlToolkit;
using System.IO;
using Ubilingua.NewExtensions;

namespace Ubilingua
{
    public partial class Subject : System.Web.UI.Page
    {
        List<Block> blocks;
        int index = 0;
        int blockID;
        int? subjectID;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                var db = new SubjectContext();
                subjectID = Convert.ToInt32(Request.QueryString["subjectID"]);

                string pass = (string)(from subjects in db.Subjects where subjects.SubjectID == subjectID select subjects.SubjectPassword).Single<string>();
                if (!String.IsNullOrEmpty(pass))
                {
                    string userID = User.Identity.GetUserId();
                    int count = (from joinSubjectUser in db.JoinSubjectUser where joinSubjectUser.SubjectID == subjectID && joinSubjectUser.UserID == userID select joinSubjectUser.SubjectID).Count();
                    if (count != 1)
                    {
                        Response.Redirect("~/SubjectPassword?SubjectID=" + subjectID);
                    }

                }
            }

        }

        public IQueryable<Ubilingua.Models.Block> GetBlocks([QueryString("subjectID")] int? subjectId)
        {
            var _db = new SubjectContext();
            IQueryable<Block> query = _db.Blocks;
            if (subjectId.HasValue && subjectId > 0)
            {
                query = query.Where(b => b.SubjectID == subjectId);
            }
            blocks = query.ToList<Block>();

            return query;
        }

        public IQueryable<Ubilingua.Models.Resource> GetResources()
        {
            var _db = new SubjectContext();
            IQueryable<Resource> query = _db.Resources;
            int? blockID = blocks[index].BlockID;

            if (blockID.HasValue && blockID > 0)
            {
                query = query.Where(r => r.BlockId == blockID);
            }
            index++;
            return query;
        }

        public IQueryable<Ubilingua.Models.Resource> GetVisibleResources()
        {
            var _db = new SubjectContext();
            IQueryable<Resource> query = _db.Resources;
            int? blockID = blocks[index].BlockID;

            if (blockID.HasValue && blockID > 0)
            {
                query = query.Where(r => r.BlockId == blockID && r.IsVisible);
            }
            index++;
            return query;
        }

        protected void CreateBlock_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("FEDED");
            int id = Convert.ToInt32(Request.QueryString["subjectID"]);
            AddBlock blocks = new AddBlock();
            bool addSuccess = blocks.AddBlocks(id);
            if (addSuccess)
            {

                Response.Redirect("~/Subject?SubjectID=" + id);
            }
        }

        public void ShowDownloadPopup(object sender, CommandEventArgs e)
        {
            ViewState["blockID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("AddDownloadPopup");
            modalPopupExtender.Show();

        }

        public void NewDownloadableResource(object sender, EventArgs e)
        {
            FileUpload fileUpload = (FileUpload)Page.FindControlRecursive("downloadResourceFile");
            TextBox resourceName = (TextBox)Page.FindControlRecursive("downloadResourceName");

            if (fileUpload.HasFile)
            {
                try
                {

                    string fileName = Path.GetFileName(fileUpload.FileName);
                    fileUpload.SaveAs(Server.MapPath("Resources/") + fileName);
                    AddResource resources = new AddResource();

                    bool addSuccess = resources.AddResources(resourceName.Text, fileName, int.Parse(ViewState["blockID"].ToString()), "download");
                    if (addSuccess)
                    {
                        //Response.Redirect("~/Subject?SubjectID=" + subjectID);
                        Response.Redirect(Request.RawUrl);
                    }
                }
                catch (Exception ex)
                {


                }
            }
            return;
        }

        public void ShowVideoPopup(object sender, CommandEventArgs e)
        {
            ViewState["blockID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("addVideoPopup");
            modalPopupExtender.Show();
        }

        public void NewVideoResource(object sender, EventArgs e)
        {
            TextBox resourceName = (TextBox)Page.FindControlRecursive("videoResourceName");
            TextBox resourcePath = (TextBox)Page.FindControlRecursive("videoPath");

            string link = resourcePath.Text.Replace("watch?v=", "embed/");

            AddResource resources = new AddResource();
            bool addSuccess = resources.AddResources(resourceName.Text, link, int.Parse(ViewState["blockID"].ToString()), "video");
            if (addSuccess)
            {
                Response.Redirect(Request.RawUrl);
            }
        }

        public void ShowImagePopup(object sender, CommandEventArgs e)
        {
            ViewState["blockID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("addImagePopup");
            modalPopupExtender.Show();
        }

        public void NewImageResource(object sender, EventArgs e)
        {
            FileUpload fileUpload = (FileUpload)Page.FindControlRecursive("imageResourceFile");


            if (fileUpload.HasFile)
            {

                try
                {

                    string fileName = Path.GetFileName(fileUpload.FileName);
                    fileUpload.SaveAs(Server.MapPath("Resources/") + fileName);
                    AddResource resources = new AddResource();

                    bool addSuccess = resources.AddResources("img", fileName, int.Parse(ViewState["blockID"].ToString()), "img");
                    if (addSuccess)
                    {
                        //Response.Redirect("~/Subject?SubjectID=" + subjectID);
                        Response.Redirect(Request.RawUrl);
                    }
                }
                catch (Exception ex)
                {

                }

            }
        }

        public void ShowTextPopup(object sender, CommandEventArgs e)
        {
            ViewState["blockID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("AddTextPopup");
            modalPopupExtender.Show();
        }

        public void NewTextResource(object sender, EventArgs e)
        {

            TextBox resource = (TextBox)Page.FindControlRecursive("textResource");
            string text = resource.Text;
            AddResource resources = new AddResource();
            bool addSuccess = resources.AddResources("text", text, int.Parse(ViewState["blockID"].ToString()), "text");
            if (addSuccess)
            {
                Response.Redirect(Request.RawUrl);
            }

        }

        public void ShowRiddlePopup(object sender, CommandEventArgs e)
        {
            ViewState["blockID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("AddRiddlePopup");
            modalPopupExtender.Show();
        }

        public void NewRiddleResource(object sender, EventArgs e)
        {
            TextBox riddleName = (TextBox)Page.FindControlRecursive("riddleName");
            FileUpload audioFile = (FileUpload)Page.FindControlRecursive("riddleAudioFile");
            FileUpload imageFile = (FileUpload)Page.FindControlRecursive("riddleImageFile");
            TextBox ogText = (TextBox)Page.FindControlRecursive("OGText");
            TextBox transText = (TextBox)Page.FindControlRecursive("TransText");
            TextBox answer = (TextBox)Page.FindControlRecursive("riddleAnswer");

            if(audioFile.HasFile)
            {
                try
                {

                    string audioFilename = Path.GetFileName(audioFile.FileName);
                    audioFile.SaveAs(Server.MapPath("Resources/") + audioFilename);

                    string imageFilename = Path.GetFileName(imageFile.FileName);
                    if (imageFilename != "")
                    {
                        imageFile.SaveAs(Server.MapPath("Resources/") + imageFilename);
                    }
                    AddResource resources = new AddResource();
                    bool addSuccess = resources.AddRiddleResource(int.Parse(ViewState["blockID"].ToString()),riddleName.Text,
                        audioFilename, imageFilename, ogText.Text, transText.Text, answer.Text);

                    if (addSuccess)
                    {
                        Response.Redirect(Request.RawUrl);
                    }

                } catch (Exception ex)
                {

                }
            }
        }

        public void ShowTaskPopup(object sender, CommandEventArgs e)
        {
            ViewState["blockID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("AddTaskPopup");
            modalPopupExtender.Show();

        }

        public void NewTaskResource(object sender, EventArgs e)
        {
            TextBox taskName = (TextBox)Page.FindControlRecursive("taskName");
            TextBox taskText = (TextBox)Page.FindControlRecursive("taskText");
            TextBox taskDate = (TextBox)Page.FindControlRecursive("taskDate");

            AddResource resources = new AddResource();
            bool addSuccess = resources.AddTaskResource(int.Parse(ViewState["blockID"].ToString()), taskName.Text, taskText.Text, DateTime.Parse(taskDate.Text));
            if (addSuccess)
            {
                Response.Redirect(Request.RawUrl);
            }
        }

        public void DeleteResource(object sender, CommandEventArgs e)
        {
            SubjectContext _db = new SubjectContext();
            int resID = int.Parse(e.CommandArgument.ToString());
            Resource res = (from resources in _db.Resources where resources.ResourceID == resID select resources).FirstOrDefault();
            if (res != null)
            {
                _db.Resources.Remove(res);
                _db.SaveChanges();
                Response.Redirect(Request.RawUrl);
            }
        }

        public void DeleteBlock(object sender, CommandEventArgs e)
        {
            SubjectContext _db = new SubjectContext();
            int bID = int.Parse(e.CommandArgument.ToString());
            Block res = (from blocks in _db.Blocks where blocks.BlockID == bID select blocks).FirstOrDefault();
            if (res != null)
            {
                _db.Blocks.Remove(res);
                _db.SaveChanges();
                Response.Redirect(Request.RawUrl);


            }
        }

        public void ChangeVisibility(object sender, CommandEventArgs e)
        {

            SubjectContext _db = new SubjectContext();
            int resID = int.Parse(e.CommandArgument.ToString());
            Resource res = (from resources in _db.Resources where resources.ResourceID == resID select resources).FirstOrDefault();
            if (res != null)
            {
                res.IsVisible = !res.IsVisible;
                _db.SaveChanges();
                Response.Redirect(Request.RawUrl);
            }
        }
    }
}