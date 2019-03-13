﻿using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Ubilingua.Models
{
    public class JoinSubjectUser
    {
        [Key][System.ComponentModel.DataAnnotations.Schema.Column(Order=0)]
        public int SubjectID { get; set; }

        [Key]
        [System.ComponentModel.DataAnnotations.Schema.Column(Order =1)]
        public string UserID { get; set; }

    }
}