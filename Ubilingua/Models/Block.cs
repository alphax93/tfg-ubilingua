using System.ComponentModel.DataAnnotations;
using System;
namespace Ubilingua.Models
{
    [Serializable]
    public class Block
    {
        [ScaffoldColumn(false)]
        public int BlockID { get; set; }

        [Required, StringLength(30), Display(Name = "Name")]
        public string BlockName { get; set; }

        [ScaffoldColumn(false)]
        public int SubjectID { get; set; }
    }
}