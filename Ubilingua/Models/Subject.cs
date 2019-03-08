using System.ComponentModel.DataAnnotations;

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
    }
}