namespace Ubilingua.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("taskresources")]
    public partial class taskresources
    {
        [Key]
        public int TaskID { get; set; }

        public int ResourceID { get; set; }

        [Required]
        [StringLength(1073741823)]
        public string TaskName { get; set; }

        public DateTime Deadline { get; set; }

        [Required]
        [StringLength(1073741823)]
        public string Text { get; set; }
    }
}
