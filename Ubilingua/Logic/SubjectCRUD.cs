using System;
using System.Collections.Generic;
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
                ImagePath = ImagePath
            };
            
            using (SubjectContext _db = new SubjectContext())
            {
                if (!string.IsNullOrEmpty(password)) mySubject.SubjectPassword = password;
                _db.Subjects.Add(mySubject);
                _db.SaveChanges();

                if (!string.IsNullOrEmpty(password))
                {
                    AddJoinSubjectUser join = new AddJoinSubjectUser();
                    join.AddJoinSubjectUsers(mySubject.SubjectID, userID);
                }

            }
            return true;
        }

        public bool DeleteSubject(int subjectID)
        {
            using(SubjectContext _db = new SubjectContext())
            {
                Models.Subject sub = (from subjects in _db.Subjects where subjects.SubjectID == subjectID select subjects).FirstOrDefault();
                _db.Subjects.Remove(sub);
                _db.SaveChanges();
            }
            return true;
        }

    }
}