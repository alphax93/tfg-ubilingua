using System.ComponentModel.DataAnnotations;

namespace Ubilingua.Models
{
    public class Resource
    {
        [ScaffoldColumn(false)]
        public int ResourceID { get; set; }

        [Required, StringLength(20), Display(Name = "Name")]
        public string ResourceName { get; set; }

        [Required]
        public string ResourcePath { get; set; }

        [Required]
        public int BlockId { get; set; }

        [Required]
        public bool IsVisible { get; set; }

        [Required]
        public string ResourceType { get; set; }
    }
}