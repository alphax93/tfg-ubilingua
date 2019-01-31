using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ubilingua.Models;

namespace Ubilingua.Logic
{
    public class AddSubject
    {
        public bool AddSubjects(string SubjectName, string ImagePath, string password)
        {
            var mySubject = new Models.Subject
            {
                SubjectName = SubjectName,
                ImagePath = ImagePath
            };
            if (!string.IsNullOrEmpty(password)) mySubject.SubjectPassword = password;
            using (SubjectContext _db = new SubjectContext())
            {
                _db.Subjects.Add(mySubject);
                _db.SaveChanges();
            }
            return true;
        }
    }
}