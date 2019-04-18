namespace Ubilingua.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("teachers")]
    public partial class teachers
    {
        [Key]
        public int TeacherID { get; set; }

        [StringLength(1073741823)]
        public string UserID { get; set; }

        [Required]
        [StringLength(1073741823)]
        public string TeacherName { get; set; }

        [StringLength(1073741823)]
        public string Position { get; set; }

        [StringLength(1073741823)]
        public string Contact { get; set; }

        [StringLength(1073741823)]
        public string SpanishRole { get; set; }

        [StringLength(1073741823)]
        public string OtherRole { get; set; }

        [StringLength(1073741823)]
        public string SpanishCV { get; set; }

        [StringLength(1073741823)]
        public string OtherCV { get; set; }

        [StringLength(1073741823)]
        public string Image { get; set; }
    }
}
