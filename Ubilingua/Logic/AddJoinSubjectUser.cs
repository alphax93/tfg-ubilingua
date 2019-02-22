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
            var myJoinSubjectUser = new JoinSubjectUser();
            myJoinSubjectUser.UserID = UserID;
            myJoinSubjectUser.SubjectID = SubjectID;
            using (SubjectContext _db = new SubjectContext())
            {
                _db.JoinSubjectUser.Add(myJoinSubjectUser);
                _db.SaveChanges();
            }
            return true;
        }

        public bool RemoveJoinSubjectUsers(int subjectID, string userID)
        {
            using (SubjectContext _db = new SubjectContext())
            {
                var myJoinSubjectUser = (from members in _db.JoinSubjectUser where members.SubjectID == subjectID && members.UserID == userID select members).FirstOrDefault();
                if (myJoinSubjectUser != null)
                {
                    _db.JoinSubjectUser.Remove(myJoinSubjectUser);
                }
                _db.SaveChanges();
            }
            return true;
        }

    }
}