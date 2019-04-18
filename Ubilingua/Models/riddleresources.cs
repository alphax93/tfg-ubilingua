namespace Ubilingua.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("riddleresources")]
    public partial class riddleresources
    {
        [Key]
        public int RiddleID { get; set; }

        public int ResourceID { get; set; }

        [Required]
        [StringLength(1073741823)]
        public string RiddleName { get; set; }

        [Required]
        [StringLength(1073741823)]
        public string AudioPath { get; set; }

        [StringLength(1073741823)]
        public string ImagePath { get; set; }

        [StringLength(1073741823)]
        public string Text { get; set; }

        [StringLength(1073741823)]
        public string TranslatedText { get; set; }

        [Required]
        [StringLength(1073741823)]
        public string Answer { get; set; }
    }
}
