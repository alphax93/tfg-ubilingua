namespace Ubilingua.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("subjects")]
    public partial class subjects
    {
        [Key]
        public int SubjectID { get; set; }

        [Required]
        [StringLength(50)]
        public string SubjectName { get; set; }

        public bool IsPrivate { get; set; }

        [StringLength(50)]
        public string SubjectPassword { get; set; }

        [StringLength(50)]
        public string ImagePath { get; set; }
    }
}
