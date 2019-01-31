namespace Ubilingua.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class CreateSurname1Column : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.AspNetUsers", "Surname1", c => c.String());
            AddColumn("dbo.AspNetUsers", "Surname2", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.AspNetUsers", "Surname2");
            DropColumn("dbo.AspNetUsers", "Surname1");
        }
    }
}
