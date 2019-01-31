using System.ComponentModel.DataAnnotations;

namespace Ubilingua.Models
{
    public class Teacher
    {
        [Required, Key]
        public int TeacherID { get; set; }

        [Required]
        public string TeacherName { get; set; }

        [Required]
        public string Position { get; set; }

        public string SpanishRole { get; set; }
        public string OtherRole { get; set; }
        public string SpanishCV { get; set; }
        public string OtherCV { get; set; }

        public string Image { get; set; }
    }
}