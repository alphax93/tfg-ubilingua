namespace Ubilingua.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("joinsubjectusers")]
    public partial class joinsubjectusers
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int SubjectID { get; set; }

        [Key]
        [Column(Order = 1)]
        public string UserID { get; set; }
    }
}
