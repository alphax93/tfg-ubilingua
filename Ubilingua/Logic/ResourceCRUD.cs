using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.IO;
using System.Linq;
using System.Web;
using Ubilingua.Models;
using System.IO.Compression;

namespace Ubilingua.Logic
{
    public class ResourceCRUD
    {
        public bool AddResources(string resourceName, string resourcePath, int blockId, string resourceType)
        {
            var myResource = new resources();

            myResource.BlockID = blockId;
            myResource.ResourceName = resourceName;
            myResource.ResourcePath = resourcePath;
            myResource.IsVisible = false;
            myResource.ResourceType = resourceType;
            using (Model1 _db = new Model1())
            {
                _db.resources.Add(myResource);
                _db.SaveChanges();
            }
            return true;
        }

        public bool AddRiddleResource(int blockId, string name, string audioName, string imageName, string ogtext, string trtext, string answer)
        {
            var myResource = new resources();

            myResource.BlockID = blockId;
            myResource.ResourceName = name;
            myResource.ResourcePath = audioName;
            myResource.ResourceType = "riddle";
            myResource.IsVisible = false;

            using (Model1 _db = new Model1())
            {
                _db.resources.Add(myResource);

                _db.SaveChanges();

                var myRiddle = new riddleresources();
                myRiddle.ResourceID = myResource.ResourceID;
                myRiddle.AudioPath = audioName;
                myRiddle.ImagePath = imageName;
                myRiddle.RiddleName = name;
                myRiddle.Text = ogtext;
                myRiddle.TranslatedText = trtext;
                myRiddle.Answer = answer;

                _db.riddleresources.Add(myRiddle);

                _db.SaveChanges();


            }
            return true;
        }

        public bool AddTaskResource(int blockID, string taskName, string taskText, DateTime deadline)
        {
            var myResource = new resources();
            myResource.BlockID = blockID;
            myResource.ResourceName = taskName;
            myResource.ResourcePath = taskName;
            myResource.ResourceType = "task";
            myResource.IsVisible = false;

            using (Model1 _db = new Model1())
            {
                _db.resources.Add(myResource);
                _db.SaveChanges();

                var myTask = new taskresources();
                myTask.ResourceID = myResource.ResourceID;
                myTask.TaskName = taskName;
                myTask.Text = taskText;
                myTask.Deadline = deadline;

                _db.taskresources.Add(myTask);
                _db.SaveChanges();
                int subjectID = (from blocks in _db.blocks where blocks.BlockID == blockID select blocks.SubjectID).First();
                Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/Subjects/" + subjectID) + "/Tasks/" + myResource.ResourceID);

            }

            return true;
        }

        public int AddTestResource(int blockID, string testName, string zip)
        {
            var myResource = new resources();
            myResource.BlockID = blockID;
            myResource.IsVisible = false;
            myResource.ResourceName = testName;
            myResource.ResourceType = "test";
            myResource.ResourcePath = zip;
            using (Model1 _db = new Model1())
            {
                _db.resources.Add(myResource);
                _db.SaveChanges();
            }
            return myResource.ResourceID;
        }

        public bool AddZip(int resourceID, int subjectID, string zip, string savePath)
        {

            //using (ZipArchive archive = ZipFile.OpenRead(savePath + "/" + zip))
            //{
            //    System.Diagnostics.Debug.WriteLine(archive.ToString());
            //    foreach (ZipArchiveEntry entry in archive.Entries)
            //    {
            //        System.Diagnostics.Debug.WriteLine(entry.Name);
            //        entry.ExtractToFile(savePath);
            //    }
            //}
            ZipFile.ExtractToDirectory(savePath + "/" + zip, savePath);

            return true;
        }

        public bool DeleteResource(int id)
        {
            using (Model1 _db = new Model1())
            {
                resources res = (from resources in _db.resources where resources.ResourceID == id select resources).FirstOrDefault();
                if (res != null)
                {
                    _db.resources.Remove(res);
                    _db.SaveChanges();
                }
            }
            return true;
        }

    }
}