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
        int? subjectID;
        UpdatePanel updatePanel;
        ListView blockList;
        ListView resourceList;

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.MaintainScrollPositionOnPostBack = true;

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
                updatePanel = (UpdatePanel)Page.FindControlRecursive("UpdatePanel");

                blockList = (ListView)Page.FindControlRecursive("blockList");
                resourceList = (ListView)Page.FindControlRecursive("resourceList");
            }

        }

        private void Refresh()
        {
            blockList.DataBind();
            resourceList.DataBind();
            updatePanel.Update();
        }

        #region Populate Listview Methods

        public IQueryable<Ubilingua.Models.Block> GetBlocks([QueryString("subjectID")] int? subjectId)
        {
            var _db = new SubjectContext();
            IQueryable<Block> query = _db.Blocks;
            if (subjectId.HasValue && subjectId > 0)
            {
                query = query.Where(b => b.SubjectID == subjectId);
            }
            blocks = query.ToList<Block>();
            ViewState["blocks"] = blocks;
            ViewState["index"] = 0;
            return query;
        }

        public IQueryable<Ubilingua.Models.Resource> GetResources()
        {
            var _db = new SubjectContext();
            IQueryable<Resource> query = _db.Resources;
            blocks = (List<Block>)ViewState["blocks"];
            index = (int)ViewState["index"];
            if (index < blocks.Count)
            {
                int? blockID = blocks[index].BlockID;

                if (blockID.HasValue && blockID > 0)
                {
                    query = query.Where(r => r.BlockId == blockID);
                }
            }
            index++;
            ViewState["index"] = index;
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

        #endregion

        #region Block

        public void ShowBlockPanel(object sender, EventArgs e)
        {
            ModalPopupExtender popup = (ModalPopupExtender)Page.FindControlRecursive("BlockPopup");
            popup.Show();
        }

        protected void CreateBlock_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Request.QueryString["subjectID"]);
            TextBox name = (TextBox)Page.FindControlRecursive("BlockName");
            BlockCRUD blocks = new BlockCRUD();
            bool addSuccess = blocks.AddBlocks(id, name.Text);
            if (addSuccess)
            {
                Refresh();
            }
        }

        public void ShowEditBlock(object sender, CommandEventArgs e)
        {
            ModalPopupExtender popup = (ModalPopupExtender)Page.FindControlRecursive("EditBlockPopup");
            popup.Show();

            TextBox blockName = (TextBox)Page.FindControlRecursive("EditBlockName");
            SubjectContext _db = new SubjectContext();
            ViewState["BlockID"] = e.CommandArgument.ToString();
            int id = int.Parse(ViewState["BlockID"].ToString());
            Block b = (from blocks in _db.Blocks where blocks.BlockID == id select blocks).FirstOrDefault();
            blockName.Text = b.BlockName;

        }

        public void EditBlock_Click(object sender, EventArgs e)
        {
            SubjectContext _db = new SubjectContext();
            int id = int.Parse(ViewState["BlockID"].ToString());
            TextBox blockName = (TextBox)Page.FindControlRecursive("EditBlockName");
            BlockCRUD blocks = new BlockCRUD();
            bool success = blocks.EditBlock(id, blockName.Text);
            if (success)
            {
                Refresh();
            }
        }

        public void DeleteBlock(object sender, CommandEventArgs e)
        {
            SubjectContext _db = new SubjectContext();
            int bID = int.Parse(e.CommandArgument.ToString());
            BlockCRUD blocks = new BlockCRUD();
            bool success = blocks.RemoveBlock(bID);
            if (success)
            {
                Refresh();
            }
        }

        #endregion

        #region Download Resource

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
                    ResourceCRUD resources = new ResourceCRUD();

                    bool addSuccess = resources.AddResources(resourceName.Text, fileName, int.Parse(ViewState["blockID"].ToString()), "download");
                    if (addSuccess)
                    {
                        Refresh();
                    }
                }
                catch (Exception ex)
                {


                }
            }
            return;
        }

        public void ShowEditDownload(object sender, CommandEventArgs e)
        {
            ViewState["ResID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("editDownloadPopup");
            modalPopupExtender.Show();

            SubjectContext _db = new SubjectContext();
            int id = int.Parse(ViewState["ResID"].ToString());
            Resource res = (from resources in _db.Resources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox text = (TextBox)Page.FindControlRecursive("editDownloadResourceName");
            text.Text = res.ResourceName;

            Label fileName = (Label)Page.FindControlRecursive("oldFileName");
            fileName.Text = res.ResourcePath;

        }

        public void editDownloadableResource(object sender, EventArgs e)
        {
            SubjectContext _db = new SubjectContext();
            int id = int.Parse(ViewState["ResID"].ToString());
            Resource res = (from resources in _db.Resources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox text = (TextBox)Page.FindControlRecursive("editDownloadResourceName");
            FileUpload file = (FileUpload)Page.FindControlRecursive("editDownloadResourceFile");

            if (file.HasFile)
            {
                string fileName = Path.GetFileName(file.FileName);
                file.SaveAs(Server.MapPath("Resources/") + fileName);

                res.ResourceName = text.Text;
                res.ResourcePath = fileName;
                _db.SaveChanges();

            }
            else
            {
                res.ResourceName = text.Text;
                _db.SaveChanges();
            }

            Refresh();
        }

        #endregion

        #region Video Resource

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
            System.Diagnostics.Debug.WriteLine("dsfsdf");
            string link = resourcePath.Text.Replace("watch?v=", "embed/");

            ResourceCRUD resources = new ResourceCRUD();
            bool addSuccess = resources.AddResources(resourceName.Text, link, int.Parse(ViewState["blockID"].ToString()), "video");
            if (addSuccess)
            {
                Refresh();
            }
        }

        public void ShowEditVideo(object sender, CommandEventArgs e)
        {
            ViewState["ResID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("EditVideoPopup");
            modalPopupExtender.Show();

            SubjectContext _db = new SubjectContext();
            int id = int.Parse(ViewState["ResID"].ToString());
            Resource res = (from resources in _db.Resources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox name = (TextBox)Page.FindControlRecursive("EditVideoResourceName");
            TextBox path = (TextBox)Page.FindControlRecursive("EditVideoPath");

            name.Text = res.ResourceName;
            path.Text = res.ResourcePath;

        }

        public void EditVideoResource(object sender, EventArgs e)
        {
            SubjectContext _db = new SubjectContext();
            int id = int.Parse(ViewState["ResID"].ToString());
            Resource res = (from resources in _db.Resources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox name = (TextBox)Page.FindControlRecursive("EditVideoResourceName");
            TextBox path = (TextBox)Page.FindControlRecursive("EditVideoPath");

            string link = path.Text.Replace("watch?v=", "embed/");

            res.ResourceName = name.Text;
            res.ResourcePath = link;
            _db.SaveChanges();
            Refresh();

        }

        #endregion

        #region Image Resource

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
                    ResourceCRUD resources = new ResourceCRUD();

                    bool addSuccess = resources.AddResources("img", fileName, int.Parse(ViewState["blockID"].ToString()), "img");
                    if (addSuccess)
                    {
                        Refresh();
                    }
                }
                catch (Exception ex)
                {

                }

            }
        }

        public void ShowEditImage(object sender, CommandEventArgs e)
        {
            ViewState["ResID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("EditImagePopup");
            modalPopupExtender.Show();
        }

        public void EditImageResource(object sender, EventArgs e)
        {
            FileUpload fileUpload = (FileUpload)Page.FindControlRecursive("EditImageResourceFile");


            if (fileUpload.HasFile)
            {
                string fileName = Path.GetFileName(fileUpload.FileName);
                fileUpload.SaveAs(Server.MapPath("Resources/") + fileName);

                SubjectContext _db = new SubjectContext();
                int id = int.Parse(ViewState["ResID"].ToString());
                Resource res = (from resources in _db.Resources where resources.ResourceID == id select resources).FirstOrDefault();

                res.ResourcePath = fileName;
                _db.SaveChanges();
                Refresh();

            }
        }

        #endregion

        #region Text Resource
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
            ResourceCRUD resources = new ResourceCRUD();
            bool addSuccess = resources.AddResources("text", text, int.Parse(ViewState["blockID"].ToString()), "text");
            if (addSuccess)
            {
                Refresh();
            }

        }

        public void ShowEditText(object sender, CommandEventArgs e)
        {

            ViewState["ResID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("EditTextPopup");
            modalPopupExtender.Show();

            SubjectContext _db = new SubjectContext();
            int id = int.Parse(ViewState["ResID"].ToString());
            Resource res = (from resources in _db.Resources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox text = (TextBox)Page.FindControlRecursive("editTextResource");
            text.Text = res.ResourcePath;
        }

        public void EditTextResource(object sender, EventArgs e)
        {
            SubjectContext _db = new SubjectContext();
            int id = int.Parse(ViewState["ResID"].ToString());
            Resource res = (from resources in _db.Resources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox text = (TextBox)Page.FindControlRecursive("editTextResource");

            if (res != null)
            {
                res.ResourcePath = text.Text;
                _db.SaveChanges();
                Refresh();
            }
        }
        #endregion

        #region Riddle Resource
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

            if (audioFile.HasFile)
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
                    ResourceCRUD resources = new ResourceCRUD();
                    bool addSuccess = resources.AddRiddleResource(int.Parse(ViewState["blockID"].ToString()), riddleName.Text,
                        audioFilename, imageFilename, ogText.Text, transText.Text, answer.Text);

                    if (addSuccess)
                    {
                        Refresh();
                    }

                }
                catch (Exception ex)
                {

                }
            }
        }

        public void ShowEditRiddle(object sender, CommandEventArgs e)
        {
            ViewState["ResID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("EditRiddlePopup");
            modalPopupExtender.Show();

            SubjectContext _db = new SubjectContext();
            int id = int.Parse(ViewState["ResID"].ToString());
            RiddleResource riddle = (from resources in _db.RiddleResources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox name = (TextBox)Page.FindControlRecursive("EditRiddleName");
            TextBox ogText = (TextBox)Page.FindControlRecursive("EditOGTExt");
            TextBox transText = (TextBox)Page.FindControlRecursive("EditTransText");
            TextBox answer = (TextBox)Page.FindControlRecursive("EditRiddleAnswer");
            Label audio = (Label)Page.FindControlRecursive("oldRiddleAudio");
            Label image = (Label)Page.FindControlRecursive("oldRiddleImage");

            name.Text = riddle.RiddleName;
            ogText.Text = riddle.Text;
            transText.Text = riddle.TranslatedText;
            answer.Text = riddle.Answer;
            audio.Text = riddle.AudioPath;
            image.Text = riddle.ImagePath;

        }

        public void EditRiddleResource(object sender, EventArgs e)
        {
            SubjectContext _db = new SubjectContext();
            int id = int.Parse(ViewState["ResID"].ToString());
            RiddleResource riddle = (from resources in _db.RiddleResources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox name = (TextBox)Page.FindControlRecursive("EditRiddleName");
            TextBox ogText = (TextBox)Page.FindControlRecursive("EditOGTExt");
            TextBox transText = (TextBox)Page.FindControlRecursive("EditTransText");
            TextBox answer = (TextBox)Page.FindControlRecursive("EditRiddleAnswer");
            FileUpload audio = (FileUpload)Page.FindControlRecursive("EditRiddleAudioFile");
            FileUpload image = (FileUpload)Page.FindControlRecursive("EditRiddleImageFile");

            if (audio.HasFile)
            {
                string audioFilename = Path.GetFileName(audio.FileName);
                audio.SaveAs(Server.MapPath("Resources/") + audioFilename);
                riddle.AudioPath = audioFilename;

            }
            if (image.HasFile)
            {
                string imageFilename = Path.GetFileName(image.FileName);
                image.SaveAs(Server.MapPath("Resources/") + imageFilename);
                riddle.ImagePath = imageFilename;
            }
            riddle.RiddleName = name.Text;
            riddle.Text = ogText.Text;
            riddle.TranslatedText = transText.Text;
            riddle.Answer = answer.Text;
            _db.SaveChanges();
            Refresh();
        }

        #endregion

        #region Task Resource
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

            ResourceCRUD resources = new ResourceCRUD();
            bool addSuccess = resources.AddTaskResource(int.Parse(ViewState["blockID"].ToString()), taskName.Text, taskText.Text, DateTime.Parse(taskDate.Text));
            if (addSuccess)
            {
                Refresh();
            }
        }

        public void ShowEditTask(object sender, CommandEventArgs e)
        {

            ViewState["ResID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("EditTaskPopup");
            modalPopupExtender.Show();

            SubjectContext _db = new SubjectContext();
            int id = int.Parse(ViewState["ResID"].ToString());
            TaskResource res = (from resources in _db.TaskResources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox taskName = (TextBox)Page.FindControlRecursive("EditTaskName");
            TextBox taskText = (TextBox)Page.FindControlRecursive("EditTaskText");
            TextBox taskDate = (TextBox)Page.FindControlRecursive("EditTaskDate");

            taskName.Text = res.TaskName;
            taskText.Text = res.Text;
            taskDate.TextMode = TextBoxMode.DateTimeLocal;
            taskDate.Text = res.Deadline.ToString();
        }

        public void EditTaskResource(object sender, EventArgs e)
        {
            SubjectContext _db = new SubjectContext();
            int id = int.Parse(ViewState["ResID"].ToString());
            TaskResource res = (from resources in _db.TaskResources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox taskName = (TextBox)Page.FindControlRecursive("EditTaskName");
            TextBox taskText = (TextBox)Page.FindControlRecursive("EditTaskText");
            TextBox taskDate = (TextBox)Page.FindControlRecursive("EditTaskDate");

            res.TaskName = taskName.Text;
            res.Text = taskText.Text;
            res.Deadline = DateTime.Parse(taskDate.Text);
            _db.SaveChanges();
            Refresh();

        }

        #endregion

        public void DeleteResource(object sender, CommandEventArgs e)
        {
            int resID = int.Parse(e.CommandArgument.ToString());
            ResourceCRUD resources = new ResourceCRUD();
            bool success = resources.DeleteResource(resID);
            if (success)
            {
                Refresh();
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
                Refresh();

            }
        }



        public void DeleteSubject(object sender, EventArgs e)
        {
            SubjectCRUD add = new SubjectCRUD();
            bool success = add.DeleteSubject(int.Parse(HttpContext.Current.Request.QueryString["subjectID"]));
            if (success)
            {
                Response.Redirect("~");
            }
        }

        public void ShowSubjectPanel(object sender, EventArgs e)
        {

        }

    }
}