using System.ComponentModel.DataAnnotations;
using System;

namespace Ubilingua.Models
{
    public class TaskResource
    {
        [Required]
        [ScaffoldColumn(false)]
        [Key]
        public int TaskID { get; set; }

        [Required]
        [ScaffoldColumn(false)]
        public int ResourceID { get; set; }

        [Required]
        public string TaskName { get; set; }

        [Required]
        public DateTime Deadline { get; set; }

        [Required]
        public string Text { get; set; }
        
    }
}