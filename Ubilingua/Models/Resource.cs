using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ubilingua.Models
{
    public class Resource
    {
        [ScaffoldColumn(false)]
        public int ResourceID { get; set; }

        [Required, Display(Name = "Name")]
        public string ResourceName { get; set; }

        [Required]
        public string ResourcePath { get; set; }

        [Required]
        public int BlockID { get; set; }

        [Required]
        public bool IsVisible { get; set; }

        [Required]
        public string ResourceType { get; set; }

        [ForeignKey("ResourceID")]
        public ICollection<JoinUserMark> JoinUserMarks { get; set; }
        [ForeignKey("ResourceID")]
        public ICollection<TaskResource> TaskResources { get; set; }
        [ForeignKey("ResourceID")]
        public ICollection<RiddleResource> RiddleResources { get; set; }
    }
}