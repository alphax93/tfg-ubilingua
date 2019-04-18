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
using System.Data.Entity.Validation;

namespace Ubilingua
{
    public partial class Subject : System.Web.UI.Page
    {
        List<blocks> blocks;
        int index = 0;
        public int? subjectID;
        public Models.subjects subject;
        UpdatePanel updatePanel;
        ListView blockList;
        ListView resourceList;

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.MaintainScrollPositionOnPostBack = true;
            Page.Form.Attributes.Add("enctype", "multipart/form-data");

            if (User.Identity.IsAuthenticated)
            {
                var db = new Model1();
                subjectID = Convert.ToInt32(Request.QueryString["subjectID"]);
                subject = (from subjects in db.subjects where subjects.SubjectID == subjectID select subjects).FirstOrDefault();
                //string pass = (string)(from subjects in db.Subjects where subjects.SubjectID == subjectID select subjects.SubjectPassword).Single<string>();
                if (subject.IsPrivate)
                {
                    string userID = User.Identity.GetUserId();
                    //int count = (from joinSubjectUser in db.JoinSubjectUser where joinSubjectUser.SubjectID == subjectID && joinSubjectUser.UserID == userID select joinSubjectUser.SubjectID).Count();
                    joinsubjectusers member = (from joinSubjectUser in db.joinsubjectusers where joinSubjectUser.SubjectID == subjectID && joinSubjectUser.UserID == userID select joinSubjectUser).SingleOrDefault();
                    if (member == null)
                    {
                        Response.Redirect("~/SubjectPassword?SubjectID=" + subjectID);
                    }

                }
                updatePanel = (UpdatePanel)Page.FindControlRecursive("UpdatePanel");

                blockList = (ListView)Page.FindControlRecursive("blockList");
                resourceList = (ListView)Page.FindControlRecursive("resourceList");
                if (User.IsInRole("Profesor"))
                {
                    if (subject.IsPrivate)
                    {
                        Button makePublicButton = (Button)Page.FindControlRecursive("MakePublic");
                        makePublicButton.Visible = true;
                        Button changePassword = (Button)Page.FindControlRecursive("ChangePassword");
                        changePassword.Visible = true;
                    }
                    else
                    {
                        Button makePrivateButton = (Button)Page.FindControlRecursive("MakePrivate");
                        makePrivateButton.Visible = true;
                    }
                }
                Label subjectName = (Label)Page.FindControlRecursive("subjectName");
                subjectName.Text = subject.SubjectName;
                if (subject.IsPrivate)
                {
                    Button leaveButton = (Button)Page.FindControlRecursive("LeaveButton");
                    leaveButton.Visible = true;
                }
            }

        }

        private void Refresh()
        {
            blockList.DataBind();
            resourceList.DataBind();
            updatePanel.Update();
        }

        #region Populate Listview Methods

        public IQueryable<Ubilingua.Models.blocks> GetBlocks([QueryString("subjectID")] int? subjectId)
        {
            var _db = new Model1();
            IQueryable<blocks> query = _db.blocks;
            if (subjectId.HasValue && subjectId > 0)
            {
                query = query.Where(b => b.SubjectID == subjectId);
            }
            blocks = query.ToList<blocks>();
            ViewState["blocks"] = blocks;
            ViewState["index"] = 0;
            return query;
        }

        public IQueryable<Ubilingua.Models.resources> GetResources()
        {
            var _db = new Model1();
            IQueryable<resources> query = _db.resources;
            blocks = (List<blocks>)ViewState["blocks"];
            index = (int)ViewState["index"];
            if (index < blocks.Count)
            {
                int? blockID = blocks[index].BlockID;

                if (blockID.HasValue && blockID > 0)
                {
                    query = query.Where(r => r.BlockID == blockID);
                }
            }
            index++;
            ViewState["index"] = index;
            return query;
        }

        public IQueryable<Ubilingua.Models.resources> GetVisibleResources()
        {
            var _db = new Model1();
            IQueryable<resources> query = _db.resources;
            int? blockID = blocks[index].BlockID;

            if (blockID.HasValue && blockID > 0)
            {
                query = query.Where(r => r.BlockID == blockID && r.IsVisible);
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
            //int id = Convert.ToInt32(Request.QueryString["subjectID"]);
            TextBox name = (TextBox)Page.FindControlRecursive("BlockName");
            BlockCRUD blocks = new BlockCRUD();
            bool addSuccess = blocks.AddBlocks((int)subjectID, name.Text);
            if (addSuccess)
            {
                blockList.DataBind();
                name.Text = string.Empty;
                updatePanel.Update();
            }
        }

        public void ShowEditBlock(object sender, CommandEventArgs e)
        {
            ModalPopupExtender popup = (ModalPopupExtender)Page.FindControlRecursive("EditBlockPopup");
            popup.Show();

            TextBox blockName = (TextBox)Page.FindControlRecursive("EditBlockName");
            Model1 _db = new Model1();
            ViewState["BlockID"] = e.CommandArgument.ToString();
            int id = int.Parse(ViewState["BlockID"].ToString());
            blocks b = (from blocks in _db.blocks where blocks.BlockID == id select blocks).FirstOrDefault();
            blockName.Text = b.BlockName;

        }

        public void EditBlock_Click(object sender, EventArgs e)
        {
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
                    string path = "~/Subjects/" + subjectID + "/Downloadables/";
                    fileUpload.SaveAs(Server.MapPath(path) + fileName);
                    ResourceCRUD resources = new ResourceCRUD();

                    bool addSuccess = resources.AddResources(resourceName.Text, fileName, int.Parse(ViewState["blockID"].ToString()), "download");
                    if (addSuccess)
                    {
                        resourceName.Text = string.Empty;
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

            Model1 _db = new Model1();
            int id = int.Parse(ViewState["ResID"].ToString());
            resources res = (from resources in _db.resources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox text = (TextBox)Page.FindControlRecursive("editDownloadResourceName");
            text.Text = res.ResourceName;

            Label fileName = (Label)Page.FindControlRecursive("oldFileName");
            fileName.Text = res.ResourcePath;

        }

        public void editDownloadableResource(object sender, EventArgs e)
        {
            Model1 _db = new Model1();
            int id = int.Parse(ViewState["ResID"].ToString());
            resources res = (from resources in _db.resources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox text = (TextBox)Page.FindControlRecursive("editDownloadResourceName");
            FileUpload file = (FileUpload)Page.FindControlRecursive("editDownloadResourceFile");

            if (file.HasFile)
            {
                string fileName = Path.GetFileName(file.FileName);
                string path = "~/Subjects/" + subjectID + "/Downloadables/";
                file.SaveAs(Server.MapPath(path) + fileName);

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
            string link = resourcePath.Text.Replace("watch?v=", "embed/");

            ResourceCRUD resources = new ResourceCRUD();
            bool addSuccess = resources.AddResources(resourceName.Text, link, int.Parse(ViewState["blockID"].ToString()), "video");
            if (addSuccess)
            {
                resourceName.Text = string.Empty;
                resourcePath.Text = string.Empty;
                Refresh();
            }
        }

        public void ShowEditVideo(object sender, CommandEventArgs e)
        {
            ViewState["ResID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("EditVideoPopup");
            modalPopupExtender.Show();

            Model1 _db = new Model1();
            int id = int.Parse(ViewState["ResID"].ToString());
            resources res = (from resources in _db.resources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox name = (TextBox)Page.FindControlRecursive("EditVideoResourceName");
            TextBox path = (TextBox)Page.FindControlRecursive("EditVideoPath");

            name.Text = res.ResourceName;
            path.Text = res.ResourcePath;

        }

        public void EditVideoResource(object sender, EventArgs e)
        {
            Model1 _db = new Model1();
            int id = int.Parse(ViewState["ResID"].ToString());
            resources res = (from resources in _db.resources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox name = (TextBox)Page.FindControlRecursive("EditVideoResourceName");
            TextBox path = (TextBox)Page.FindControlRecursive("EditVideoPath");

            string link = path.Text.Replace("watch?v=", "embed/");
            System.Diagnostics.Debug.WriteLine("hasta aqui");
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
                    string path = "~/Subjects/" + subjectID + "/Images/";
                    fileUpload.SaveAs(Server.MapPath(path) + fileName);
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
                string path = "~/Subjects/" + subjectID + "/Images/";
                fileUpload.SaveAs(Server.MapPath(path) + fileName);

                Model1 _db = new Model1();
                int id = int.Parse(ViewState["ResID"].ToString());
                resources res = (from resources in _db.resources where resources.ResourceID == id select resources).FirstOrDefault();

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
                resource.Text = string.Empty;
                Refresh();
            }

        }

        public void ShowEditText(object sender, CommandEventArgs e)
        {

            ViewState["ResID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("EditTextPopup");
            modalPopupExtender.Show();

            Model1 _db = new Model1();
            int id = int.Parse(ViewState["ResID"].ToString());
            resources res = (from resources in _db.resources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox text = (TextBox)Page.FindControlRecursive("editTextResource");
            text.Text = res.ResourcePath;
        }

        public void EditTextResource(object sender, EventArgs e)
        {
            Model1 _db = new Model1();
            int id = int.Parse(ViewState["ResID"].ToString());
            resources res = (from resources in _db.resources where resources.ResourceID == id select resources).FirstOrDefault();

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
                    string path = "~/Subjects/" + subjectID + "/Audios/";
                    audioFile.SaveAs(Server.MapPath(path) + audioFilename);

                    string imageFilename = Path.GetFileName(imageFile.FileName);
                    if (imageFilename != "")
                    {
                        string path2 = "~/Subjects/" + subjectID + "/Images/";
                        imageFile.SaveAs(Server.MapPath(path2) + imageFilename);
                    }

                    ResourceCRUD resources = new ResourceCRUD();
                    bool addSuccess = resources.AddRiddleResource(int.Parse(ViewState["blockID"].ToString()), riddleName.Text,
                        audioFilename, imageFilename, ogText.Text, transText.Text, answer.Text);

                    if (addSuccess)
                    {
                        riddleName.Text = string.Empty;
                        ogText.Text = string.Empty;
                        transText.Text = string.Empty;
                        answer.Text = string.Empty;
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

            Model1 _db = new Model1();
            int id = int.Parse(ViewState["ResID"].ToString());
            riddleresources riddle = (from resources in _db.riddleresources where resources.ResourceID == id select resources).FirstOrDefault();

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
            Model1 _db = new Model1();
            int id = int.Parse(ViewState["ResID"].ToString());
            riddleresources riddle = (from resources in _db.riddleresources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox name = (TextBox)Page.FindControlRecursive("EditRiddleName");
            TextBox ogText = (TextBox)Page.FindControlRecursive("EditOGTExt");
            TextBox transText = (TextBox)Page.FindControlRecursive("EditTransText");
            TextBox answer = (TextBox)Page.FindControlRecursive("EditRiddleAnswer");
            FileUpload audio = (FileUpload)Page.FindControlRecursive("EditRiddleAudioFile");
            FileUpload image = (FileUpload)Page.FindControlRecursive("EditRiddleImageFile");

            if (audio.HasFile)
            {
                string audioFilename = Path.GetFileName(audio.FileName);
                string path = "~/Subjects/" + subjectID + "/Audios/";
                audio.SaveAs(Server.MapPath(path) + audioFilename);
                riddle.AudioPath = audioFilename;

            }
            if (image.HasFile)
            {
                string imageFilename = Path.GetFileName(image.FileName);
                string path2 = "~/Subjects/" + subjectID + "/Images/";
                image.SaveAs(Server.MapPath(path2) + imageFilename);
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
                taskName.Text = string.Empty;
                taskText.Text = string.Empty;
                Refresh();
            }
        }

        public void ShowEditTask(object sender, CommandEventArgs e)
        {

            ViewState["ResID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("EditTaskPopup");
            modalPopupExtender.Show();

            Model1 _db = new Model1();
            int id = int.Parse(ViewState["ResID"].ToString());
            taskresources res = (from resources in _db.taskresources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox taskName = (TextBox)Page.FindControlRecursive("EditTaskName");
            TextBox taskText = (TextBox)Page.FindControlRecursive("EditTaskText");
            TextBox taskDate = (TextBox)Page.FindControlRecursive("EditTaskDate");
            HiddenField hidden = (HiddenField)Page.FindControlRecursive("deadlineHidden");

            taskName.Text = res.TaskName;
            taskText.Text = res.Text;
            taskDate.TextMode = TextBoxMode.DateTimeLocal;
            taskDate.Text = res.Deadline.ToString();
            hidden.Value = res.Deadline.ToString();
            
        }

        public void EditTaskResource(object sender, EventArgs e)
        {
            Model1 _db = new Model1();
            int id = int.Parse(ViewState["ResID"].ToString());
            taskresources res = (from resources in _db.taskresources where resources.ResourceID == id select resources).FirstOrDefault();

            TextBox taskName = (TextBox)Page.FindControlRecursive("EditTaskName");
            TextBox taskText = (TextBox)Page.FindControlRecursive("EditTaskText");
            TextBox taskDate = (TextBox)Page.FindControlRecursive("EditTaskDate");
            HiddenField hidden = (HiddenField)Page.FindControlRecursive("deadlineHidden");

            res.TaskName = taskName.Text;
            res.Text = taskText.Text;
            if(!string.IsNullOrEmpty(taskDate.Text))
            {
                res.Deadline = DateTime.Parse(taskDate.Text);
            } else
            {
                res.Deadline = DateTime.Parse(hidden.Value);
            }
            
            _db.SaveChanges();
            Refresh();

        }

        #endregion

        #region Test Resource

        public void ShowTestPopup(object sender, CommandEventArgs e)
        {
            ViewState["blockID"] = e.CommandArgument.ToString();
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("addTestPopup");
            modalPopupExtender.Show();
        }

        public void NewTestResource(object sender, EventArgs e)
        {
            TextBox testName = (TextBox)Page.FindControlRecursive("testName");
            FileUpload fileUpload = (FileUpload)Page.FindControlRecursive("testResourceFile");


            if (fileUpload.HasFile)
            {

                try
                {

                    string fileName = Path.GetFileName(fileUpload.FileName);
                    
                    
                    ResourceCRUD resources = new ResourceCRUD();


                    int resourceID = resources.AddTestResource(int.Parse(ViewState["blockID"].ToString()), testName.Text, fileName);
                    string path = "~/Subjects/" + subjectID + "/Tests/";
                    path = Server.MapPath(path) + resourceID;
                    
                    Directory.CreateDirectory(path);

                    fileUpload.SaveAs(path + "/" + fileName);

                    bool addSuccess = resources.AddZip(resourceID, (int)subjectID, fileName, path);

                    if (addSuccess)
                    {
                        testName.Text = string.Empty;
                        Refresh();
                    }

                }
                catch (Exception ex)
                {

                }

            }
        }

        public void ShowEditTest(object sender, CommandEventArgs e)
        { }

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
            Model1 _db = new Model1();
            int resID = int.Parse(e.CommandArgument.ToString());
            resources res = (from resources in _db.resources where resources.ResourceID == resID select resources).FirstOrDefault();
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
            bool success = add.DeleteSubject((int)subjectID);
            if (success)
            {
                string path = "Subjects/" + subjectID + "/";
                Directory.Delete(Server.MapPath(path), true);
                Response.Redirect("~");
            }
        }

        public void ShowSubjectPanel(object sender, EventArgs e)
        {
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("EditSubjectPopup");
            modalPopupExtender.Show();

            TextBox name = (TextBox)Page.FindControlRecursive("EditSubjectName");
            using (Model1 _db = new Model1())
            {
                Models.subjects sub = (from subjects in _db.subjects where subjects.SubjectID == subjectID select subjects).FirstOrDefault();

                name.Text = sub.SubjectName;
                updatePanel.Update();
            }


        }

        public void EditSubject_Click(object sender, EventArgs e)
        {
            TextBox name = (TextBox)Page.FindControlRecursive("EditSubjectName");
            SubjectCRUD subjects = new SubjectCRUD();
            bool success = subjects.UpdateName((int)subjectID, name.Text);
            if (success)
            {
                blockList.DataBind();
                updatePanel.Update();
            }
        }

        public void MakePublicClick(object sender, EventArgs e)
        {
            SubjectCRUD subjects = new SubjectCRUD();
            bool success = subjects.MakePublic((int)subjectID);
            if (success)
            {
                Response.Redirect("~/Subject?subjectID=" + subjectID);
            }
        }

        public void ShowMakePrivate(object sender, EventArgs e)
        {
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("EditSubjectPasswordPopup");
            modalPopupExtender.Show();
        }

        public void EditSubjectPassword_Click(object sender, EventArgs e)
        {
            TextBox password = (TextBox)Page.FindControlRecursive("EditSubjectPassword");
            SubjectCRUD subjects = new SubjectCRUD();
            bool success = subjects.MakePrivate((int)subjectID, password.Text, User.Identity.GetUserId());
            if (success)
            {
                Response.Redirect("~/Subject?subjectID=" + subjectID);
            }
        }

        public void ShowChangePassword(object sender, EventArgs e)
        {
            ModalPopupExtender modalPopupExtender = (ModalPopupExtender)Page.FindControlRecursive("ChangeSubjectPasswordPopup");
            modalPopupExtender.Show();
        }

        public void ChangeSubjectPassword_Click(object sender, EventArgs e)
        {
            TextBox password = (TextBox)Page.FindControlRecursive("ChangeSubjectPassword");
            SubjectCRUD subjects = new SubjectCRUD();
            bool success = subjects.UpdatePassword((int)subjectID, password.Text);
            
        }

        public void LeaveSubject(object sender, EventArgs e)
        {
            AddJoinSubjectUser member = new AddJoinSubjectUser();
            bool success = member.RemoveJoinSubjectUsers((int)subjectID, User.Identity.GetUserId());
            if (success)
            {
                Response.Redirect("~");
            }
        }

        public void ViewMarks(object sender, EventArgs e)
        {
            Response.Redirect("~/SubjectMarks?subjectID="+subjectID);
        }

    }
}