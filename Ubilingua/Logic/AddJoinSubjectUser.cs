using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ubilingua.Models;

namespace Ubilingua.Logic
{
    public class AddJoinSubjectUser
    {
        public bool AddJoinSubjectUsers(int SubjectID, string UserID)
        {
            var myJoinSubjectUser = new joinsubjectusers();
            myJoinSubjectUser.UserID = UserID;
            myJoinSubjectUser.SubjectID = SubjectID;
            using (Model1 _db = new Model1())
            {
                _db.joinsubjectusers.Add(myJoinSubjectUser);
                _db.SaveChanges();
            }
            return true;
        }

        public bool RemoveJoinSubjectUsers(int subjectID, string userID)
        {
            using (Model1 _db = new Model1())
            {
                var myJoinSubjectUser = (from members in _db.joinsubjectusers where members.SubjectID == subjectID && members.UserID == userID select members).FirstOrDefault();
                if (myJoinSubjectUser != null)
                {
                    _db.joinsubjectusers.Remove(myJoinSubjectUser);
                }
                _db.SaveChanges();
            }
            return true;
        }

    }
}