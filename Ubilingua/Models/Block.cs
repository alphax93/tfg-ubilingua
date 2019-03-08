using System.ComponentModel.DataAnnotations;
using System;
using System.ComponentModel.DataAnnotations.Schema;
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
    }
}