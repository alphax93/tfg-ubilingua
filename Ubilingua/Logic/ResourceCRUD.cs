using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.IO;
using System.Linq;
using System.Web;
using Ubilingua.Models;

namespace Ubilingua.Logic
{
    public class ResourceCRUD
    {
        public bool AddResources(string resourceName, string resourcePath, int blockId, string resourceType)
        {
            var myResource = new Resource();

            myResource.BlockID = blockId;
            myResource.ResourceName = resourceName;
            myResource.ResourcePath = resourcePath;
            myResource.IsVisible = false;
            myResource.ResourceType = resourceType;
            using (SubjectContext _db = new SubjectContext())
            {
                _db.Resources.Add(myResource);
                _db.SaveChanges();
            }
            return true;
        }

        public bool AddRiddleResource(int blockId, string name, string audioName, string imageName, string ogtext, string trtext, string answer)
        {
            var myResource = new Resource();

            myResource.BlockID = blockId;
            myResource.ResourceName = name;
            myResource.ResourcePath = audioName;
            myResource.ResourceType = "riddle";
            myResource.IsVisible = false;

            using (SubjectContext _db = new SubjectContext())
            {
                _db.Resources.Add(myResource);

                _db.SaveChanges();

                var myRiddle = new RiddleResource();
                myRiddle.ResourceID = myResource.ResourceID;
                myRiddle.AudioPath = audioName;
                myRiddle.ImagePath = imageName;
                myRiddle.RiddleName = name;
                myRiddle.Text = ogtext;
                myRiddle.TranslatedText = trtext;
                myRiddle.Answer = answer;

                _db.RiddleResources.Add(myRiddle);

                _db.SaveChanges();


            }
            return true;
        }

        public bool AddTaskResource(int blockID, string taskName, string taskText, DateTime deadline)
        {
            var myResource = new Resource();
            myResource.BlockID = blockID;
            myResource.ResourceName = taskName;
            myResource.ResourcePath = taskName;
            myResource.ResourceType = "task";
            myResource.IsVisible = false;

            using (SubjectContext _db = new SubjectContext())
            {
                _db.Resources.Add(myResource);
                _db.SaveChanges();

                var myTask = new TaskResource();
                myTask.ResourceID = myResource.ResourceID;
                myTask.TaskName = taskName;
                myTask.Text = taskText;
                myTask.Deadline = deadline;

                _db.TaskResources.Add(myTask);
                _db.SaveChanges();
                int subjectID = (from blocks in _db.Blocks where blocks.BlockID == blockID select blocks.SubjectID).First();
                Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/Subjects/" + subjectID) + "/Tasks/"+myResource.ResourceID);

            }

            return true;
        }

        public bool DeleteResource(int id)
        {
            using (SubjectContext _db = new SubjectContext())
            {
                Resource res = (from resources in _db.Resources where resources.ResourceID == id select resources).FirstOrDefault();
                if (res != null)
                {
                    _db.Resources.Remove(res);
                    _db.SaveChanges();
                }
            }
            return true;
        }

    }
}