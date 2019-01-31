using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ubilingua.Models;

namespace Ubilingua.Logic
{
    public class AddBlock
    {
        public bool AddBlocks(int SubjectID)
        {
            var MyBlock = new Block
            {
                BlockName = "Nuevo Tema",
                SubjectID = SubjectID
            };
            using (SubjectContext _db = new SubjectContext())
            {
                _db.Blocks.Add(MyBlock);
                _db.SaveChanges();
            }
            return true;
        }
    }
}