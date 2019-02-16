using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ubilingua.Models;

namespace Ubilingua.Logic
{
    public class BlockCRUD
    {
        public bool AddBlocks(int SubjectID, string name)
        {
            var MyBlock = new Block
            {
                BlockName = name,
                SubjectID = SubjectID
            };
            using (SubjectContext _db = new SubjectContext())
            {
                _db.Blocks.Add(MyBlock);
                _db.SaveChanges();
            }
            return true;
        }

        public bool RemoveBlock(int id)
        {
            using (SubjectContext _db = new SubjectContext())
            {
                Block res = (from blocks in _db.Blocks where blocks.BlockID == id select blocks).FirstOrDefault();
                if (res != null)
                {
                    _db.Blocks.Remove(res);
                    _db.SaveChanges();
                }
            }
            return true;
        }

        public bool EditBlock(int id, string newName)
        {
            using(SubjectContext _db = new SubjectContext())
            {
                Block b = (from blocks in _db.Blocks where blocks.BlockID == id select blocks).FirstOrDefault();
                b.BlockName = newName;
                _db.SaveChanges();
            }
            return true;
        }

    }
}