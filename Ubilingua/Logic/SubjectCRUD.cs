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
            var mySubject = new Models.subjects
            {
                SubjectName = SubjectName,
                ImagePath = ImagePath,
                IsPrivate = false
            };

            using (Model1 _db = new Model1())
            {
                if (!string.IsNullOrEmpty(password))
                {
                    mySubject.SubjectPassword = password;
                    mySubject.IsPrivate = true;
                }
                _db.subjects.Add(mySubject);
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
                Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/Subjects/" + mySubject.SubjectID) + "/Tests");

            }
            return true;
        }

        public bool DeleteSubject(int subjectID)
        {
            using (Model1 _db = new Model1())
            {
                Models.subjects sub = (from subjects in _db.subjects where subjects.SubjectID == subjectID select subjects).FirstOrDefault();
                _db.subjects.Remove(sub);
                _db.SaveChanges();
            }
            return true;
        }

        public bool MakePublic(int subjectID)
        {
            using (Model1 _db = new Model1())
            {
                Models.subjects sub = (from subjects in _db.subjects where subjects.SubjectID == subjectID select subjects).FirstOrDefault();
                sub.IsPrivate = false;
                sub.SubjectPassword = "";
                _db.SaveChanges();
            }
            return true;
        }

        public bool MakePrivate(int subjectID, string password, string userID)
        {
            using (Model1 _db = new Model1())
            {
                Models.subjects sub = (from subjects in _db.subjects where subjects.SubjectID == subjectID select subjects).FirstOrDefault();
                sub.IsPrivate = true;
                sub.SubjectPassword = password;
                _db.SaveChanges();


                joinsubjectusers join = (from joins in _db.joinsubjectusers where joins.SubjectID == subjectID && joins.UserID == userID select joins).FirstOrDefault();
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
            using (Model1 _db = new Model1())
            {
                Models.subjects sub = (from subjects in _db.subjects where subjects.SubjectID == subjectID select subjects).FirstOrDefault();
                sub.SubjectPassword = password;
                _db.SaveChanges();
            }
            return true;
        }

        public bool UpdateName(int subjectID, string name)
        {
            using (Model1 _db = new Model1())
            {
                Models.subjects sub = (from subjects in _db.subjects where subjects.SubjectID == subjectID select subjects).FirstOrDefault();
                sub.SubjectName = name;
                _db.SaveChanges();
            }
            return true;
        }

    }
}