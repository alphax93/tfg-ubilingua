namespace Ubilingua.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("resources")]
    public partial class resources
    {
        [Key]
        public int ResourceID { get; set; }

        [Required]
        [StringLength(1073741823)]
        public string ResourceName { get; set; }

        [Required]
        [StringLength(1073741823)]
        public string ResourcePath { get; set; }

        public int BlockID { get; set; }

        public bool IsVisible { get; set; }

        [Required]
        [StringLength(1073741823)]
        public string ResourceType { get; set; }
    }
}
