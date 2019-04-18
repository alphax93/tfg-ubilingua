namespace Ubilingua.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("blocks")]
    [Serializable]
    public partial class blocks
    {
        [Key]
        public int BlockID { get; set; }

        [Required]
        [StringLength(1073741823)]
        public string BlockName { get; set; }

        public int SubjectID { get; set; }
    }
}
