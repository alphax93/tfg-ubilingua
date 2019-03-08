using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ubilingua.Models;

namespace Ubilingua.Logic
{
    public class AddJoinUserMark
    {
        public bool AddJoinUserMarks(int ResourceID, string UserID, string filepath, string user, int subjectID)
        {
            var myJoinUserMarks = new JoinUserMark();
            myJoinUserMarks.ResourceID = ResourceID;
            myJoinUserMarks.UserID = UserID;
            myJoinUserMarks.FilePath = filepath;
            myJoinUserMarks.Delivered = DateTime.Now;
            myJoinUserMarks.User = user;
            myJoinUserMarks.SubjectID = subjectID;
            using (SubjectContext _db = new SubjectContext())
            {
                TaskResource task = (from tasks in _db.TaskResources where tasks.ResourceID == ResourceID select tasks).FirstOrDefault();
                myJoinUserMarks.TaskName = task.TaskName;
                _db.JoinUserMark.Add(myJoinUserMarks);
                _db.SaveChanges();
            }
            return true;
        }

        public bool UpdateJoinUserMarks(int ResourceID, string UserID, string filepath)
        {

            using (SubjectContext _db = new SubjectContext())
            {
                var myJoinUserMarks = (from joins in _db.JoinUserMark where joins.ResourceID == ResourceID && joins.UserID == UserID select joins).FirstOrDefault();
                string oldFile = "Resources/UserTasks/" + myJoinUserMarks.FilePath;
                myJoinUserMarks.FilePath = filepath;
                myJoinUserMarks.Delivered = DateTime.Now;
                _db.SaveChanges();
                if ((System.IO.File.Exists(oldFile)))
                {
                    System.IO.File.Delete(oldFile);
                }
            }
            return true;
        }

        public bool UpdateMark(int ResourceID, string UserID, float mark)
        {
            using (SubjectContext _db = new SubjectContext())
            {
                var myJoinUserMarks = (from joins in _db.JoinUserMark where joins.ResourceID == ResourceID && joins.UserID == UserID select joins).FirstOrDefault();
                myJoinUserMarks.Mark = mark;
                _db.SaveChanges();
            }
            return true;
        }
    }
}