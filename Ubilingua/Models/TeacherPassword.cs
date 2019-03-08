using System.ComponentModel.DataAnnotations;
using System;

namespace Ubilingua.Models
{
    public class TeacherPassword
    {
        [Required, ScaffoldColumn(false), Key]
        public string Password { get; set; }
    }
}