namespace Ubilingua.Models
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    [DbConfigurationType(typeof(MySql.Data.EntityFramework.MySqlEFConfiguration))]
    public partial class Model1 : DbContext
    {
        public Model1()
            : base("name=Model1")
        {
        }

        static Model1()
        {
            DbConfiguration.SetConfiguration(new MySql.Data.EntityFramework.MySqlEFConfiguration());
        }

        public virtual DbSet<blocks> blocks { get; set; }
        public virtual DbSet<joinsubjectusers> joinsubjectusers { get; set; }
        public virtual DbSet<joinusermarks> joinusermarks { get; set; }
        public virtual DbSet<resources> resources { get; set; }
        public virtual DbSet<riddleresources> riddleresources { get; set; }
        public virtual DbSet<subjects> subjects { get; set; }
        public virtual DbSet<taskresources> taskresources { get; set; }
        public virtual DbSet<teachers> teachers { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<blocks>()
                .Property(e => e.BlockName)
                .IsUnicode(false);

            modelBuilder.Entity<joinsubjectusers>()
                .Property(e => e.UserID)
                .IsUnicode(false);

            modelBuilder.Entity<joinusermarks>()
                .Property(e => e.UserID)
                .IsUnicode(false);

            modelBuilder.Entity<joinusermarks>()
                .Property(e => e.User)
                .IsUnicode(false);

            modelBuilder.Entity<joinusermarks>()
                .Property(e => e.TaskName)
                .IsUnicode(false);

            modelBuilder.Entity<joinusermarks>()
                .Property(e => e.FilePath)
                .IsUnicode(false);

            modelBuilder.Entity<joinusermarks>()
                .Property(e => e.Delivered)
                .HasPrecision(3);

            modelBuilder.Entity<resources>()
                .Property(e => e.ResourceName)
                .IsUnicode(false);

            modelBuilder.Entity<resources>()
                .Property(e => e.ResourcePath)
                .IsUnicode(false);

            modelBuilder.Entity<resources>()
                .Property(e => e.ResourceType)
                .IsUnicode(false);

            modelBuilder.Entity<riddleresources>()
                .Property(e => e.RiddleName)
                .IsUnicode(false);

            modelBuilder.Entity<riddleresources>()
                .Property(e => e.AudioPath)
                .IsUnicode(false);

            modelBuilder.Entity<riddleresources>()
                .Property(e => e.ImagePath)
                .IsUnicode(false);

            modelBuilder.Entity<riddleresources>()
                .Property(e => e.Text)
                .IsUnicode(false);

            modelBuilder.Entity<riddleresources>()
                .Property(e => e.TranslatedText)
                .IsUnicode(false);

            modelBuilder.Entity<riddleresources>()
                .Property(e => e.Answer)
                .IsUnicode(false);

            modelBuilder.Entity<subjects>()
                .Property(e => e.SubjectName)
                .IsUnicode(false);

            modelBuilder.Entity<subjects>()
                .Property(e => e.SubjectPassword)
                .IsUnicode(false);

            modelBuilder.Entity<subjects>()
                .Property(e => e.ImagePath)
                .IsUnicode(false);

            modelBuilder.Entity<taskresources>()
                .Property(e => e.TaskName)
                .IsUnicode(false);

            modelBuilder.Entity<taskresources>()
                .Property(e => e.Deadline)
                .HasPrecision(3);

            modelBuilder.Entity<taskresources>()
                .Property(e => e.Text)
                .IsUnicode(false);

            modelBuilder.Entity<teachers>()
                .Property(e => e.UserID)
                .IsUnicode(false);

            modelBuilder.Entity<teachers>()
                .Property(e => e.TeacherName)
                .IsUnicode(false);

            modelBuilder.Entity<teachers>()
                .Property(e => e.Position)
                .IsUnicode(false);

            modelBuilder.Entity<teachers>()
                .Property(e => e.Contact)
                .IsUnicode(false);

            modelBuilder.Entity<teachers>()
                .Property(e => e.SpanishRole)
                .IsUnicode(false);

            modelBuilder.Entity<teachers>()
                .Property(e => e.OtherRole)
                .IsUnicode(false);

            modelBuilder.Entity<teachers>()
                .Property(e => e.SpanishCV)
                .IsUnicode(false);

            modelBuilder.Entity<teachers>()
                .Property(e => e.OtherCV)
                .IsUnicode(false);

            modelBuilder.Entity<teachers>()
                .Property(e => e.Image)
                .IsUnicode(false);
        }
    }
}
