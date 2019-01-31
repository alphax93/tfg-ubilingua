using System.ComponentModel.DataAnnotations;

namespace Ubilingua.Models
{
    public class RiddleResource
    {
        [ScaffoldColumn(false)]
        [Key]
        public int RiddleID { get; set; }

        [Required]
        [ScaffoldColumn(false)]
        public int ResourceID { get; set; }

        [Required]
        public string RiddleName { get; set; }

        [Required]
        public string AudioPath { get; set; }
        
        public string ImagePath { get; set; }
        
        public string Text { get; set; }
        
        public string TranslatedText { get; set; }

        [Required]
        public string Answer { get; set; }
    }
}