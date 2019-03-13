using System.ComponentModel.DataAnnotations;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Collections.Generic;

namespace Ubilingua.Models
{
    [Serializable]
    public class Block
    {
        [ScaffoldColumn(false)]
        public int BlockID { get; set; }

        [Required, Display(Name = "Name")]
        public string BlockName { get; set; }

        [ScaffoldColumn(false)]
        public int SubjectID { get; set; }

        [ForeignKey("BlockID")]
        public ICollection<Resource> Resources { get; set; }
    }
}