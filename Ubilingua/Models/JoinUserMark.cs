using System.ComponentModel.DataAnnotations;
using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ubilingua.Models
{
    public class JoinUserMark
    {
        [Key]
        [System.ComponentModel.DataAnnotations.Schema.Column(Order = 0)]
        public int ResourceID { get; set; }

        [Key]
        [System.ComponentModel.DataAnnotations.Schema.Column(Order = 1)]
        public string UserID { get; set; }

        public string User { get; set; }

        public int SubjectID { get; set; }

        public string TaskName { get; set; }

        public float Mark { get; set; }

        public string FilePath { get; set; }

        public DateTime Delivered { get; set; }
    }
}