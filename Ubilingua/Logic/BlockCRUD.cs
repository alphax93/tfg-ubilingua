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
            var MyBlock = new blocks
            {
                BlockName = name,
                SubjectID = SubjectID
            };
            using (Model1 _db = new Model1())
            {
                _db.blocks.Add(MyBlock);
                _db.SaveChanges();
            }
            return true;
        }

        public bool RemoveBlock(int id)
        {
            using (Model1 _db = new Model1())
            {
                blocks res = (from blocks in _db.blocks where blocks.BlockID == id select blocks).FirstOrDefault();
                if (res != null)
                {
                    _db.blocks.Remove(res);
                    _db.SaveChanges();
                }
            }
            return true;
        }

        public bool EditBlock(int id, string newName)
        {
            using(Model1 _db = new Model1())
            {
                blocks b = (from blocks in _db.blocks where blocks.BlockID == id select blocks).FirstOrDefault();
                b.BlockName = newName;
                _db.SaveChanges();
            }
            return true;
        }

    }
}