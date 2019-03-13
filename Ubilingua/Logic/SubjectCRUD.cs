using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using Ubilingua.Models;

namespace Ubilingua.Logic
{
    public class SubjectCRUD
    {
        public bool AddSubjects(string SubjectName, string ImagePath, string password, string userID)
        {
            var mySubject = new Models.Subject
            {
                SubjectName = SubjectName,
                ImagePath = ImagePath,
                IsPrivate = false
            };

            using (SubjectContext _db = new SubjectContext())
            {
                if (!string.IsNullOrEmpty(password))
                {
                    mySubject.SubjectPassword = password;
                    mySubject.IsPrivate = true;
                }
                _db.Subjects.Add(mySubject);
                _db.SaveChanges();

                if (!string.IsNullOrEmpty(password))
                {
                    AddJoinSubjectUser join = new AddJoinSubjectUser();
                    join.AddJoinSubjectUsers(mySubject.SubjectID, userID);
                }
                
                Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/Subjects/" + mySubject.SubjectID));
                Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/Subjects/" + mySubject.SubjectID)+"/Images");
                Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/Subjects/" + mySubject.SubjectID)+"/Tasks");
                Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/Subjects/" + mySubject.SubjectID)+"/Downloadables");
                Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/Subjects/" + mySubject.SubjectID) + "/Audios");


            }
            return true;
        }

        public bool DeleteSubject(int subjectID)
        {
            using (SubjectContext _db = new SubjectContext())
            {
                Models.Subject sub = (from subjects in _db.Subjects where subjects.SubjectID == subjectID select subjects).FirstOrDefault();
                _db.Subjects.Remove(sub);
                _db.SaveChanges();
            }
            return true;
        }

        public bool MakePublic(int subjectID)
        {
            using (SubjectContext _db = new SubjectContext())
            {
                Models.Subject sub = (from subjects in _db.Subjects where subjects.SubjectID == subjectID select subjects).FirstOrDefault();
                sub.IsPrivate = false;
                sub.SubjectPassword = "";
                _db.SaveChanges();
            }
            return true;
        }

        public bool MakePrivate(int subjectID, string password, string userID)
        {
            using (SubjectContext _db = new SubjectContext())
            {
                Models.Subject sub = (from subjects in _db.Subjects where subjects.SubjectID == subjectID select subjects).FirstOrDefault();
                sub.IsPrivate = true;
                sub.SubjectPassword = password;
                _db.SaveChanges();


                JoinSubjectUser join = (from joins in _db.JoinSubjectUser where joins.SubjectID == subjectID && joins.UserID == userID select joins).FirstOrDefault();
                if (join == null)
                {
                    AddJoinSubjectUser addJoin = new AddJoinSubjectUser();
                    addJoin.AddJoinSubjectUsers(subjectID, userID);

                }


            }
            return true;
        }

        public bool UpdatePassword(int subjectID, string password)
        {
            using (SubjectContext _db = new SubjectContext())
            {
                Models.Subject sub = (from subjects in _db.Subjects where subjects.SubjectID == subjectID select subjects).FirstOrDefault();
                sub.SubjectPassword = password;
                _db.SaveChanges();
            }
            return true;
        }

        public bool UpdateName(int subjectID, string name)
        {
            using (SubjectContext _db = new SubjectContext())
            {
                Models.Subject sub = (from subjects in _db.Subjects where subjects.SubjectID == subjectID select subjects).FirstOrDefault();
                sub.SubjectName = name;
                _db.SaveChanges();
            }
            return true;
        }

    }
}