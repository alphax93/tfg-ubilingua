using System.Data.Entity;

namespace Ubilingua.Models
{
    public class SubjectContext: DbContext
    {
        public SubjectContext(): base("Ubilingua") { }

        public DbSet<Subject> Subjects { get; set; }

        public DbSet<Block> Blocks { get; set; }
        public DbSet<Resource> Resources { get; set; }

        public DbSet<Teacher> Teachers { get; set; }

        public DbSet<JoinSubjectUser> JoinSubjectUser { get; set; }

        public DbSet<RiddleResource> RiddleResources { get; set; }

        public DbSet<TaskResource> TaskResources { get; set; }

        public DbSet<JoinUserMark> JoinUserMark { get; set; }
    }
}