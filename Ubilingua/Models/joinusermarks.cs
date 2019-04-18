namespace Ubilingua.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("joinusermarks")]
    public partial class joinusermarks
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ResourceID { get; set; }

        [Key]
        [Column(Order = 1)]
        public string UserID { get; set; }

        [StringLength(1073741823)]
        public string User { get; set; }

        public int SubjectID { get; set; }

        [StringLength(1073741823)]
        public string TaskName { get; set; }

        public double Mark { get; set; }

        [StringLength(1073741823)]
        public string FilePath { get; set; }

        public DateTime Delivered { get; set; }
    }
}
