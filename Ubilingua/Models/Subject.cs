using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ubilingua.Models
{
    public class Subject
    {
        [Required, Key]
        public int SubjectID { get; set; }

        [Required, Display(Name ="Name")]
        public string SubjectName { get; set; }

        [Required]
        public bool IsPrivate { get; set; }

        public string SubjectPassword { get; set; }

        public string ImagePath { get; set; }

        [ForeignKey("SubjectID")]
        public ICollection<Block> Blocks { get; set; }

        [ForeignKey("SubjectID")]
        public ICollection<JoinSubjectUser> JoinSubjectUsers { get; set; }

       
    }
}