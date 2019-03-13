using System.ComponentModel.DataAnnotations;
using System;

namespace Ubilingua.Models
{
    public class TeacherPassword
    {
        [Key]
        public int Id { get; set; }
        [Required, ScaffoldColumn(false)]
        public string Password { get; set; }
    }
}