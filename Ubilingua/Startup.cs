using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Ubilingua.Startup))]
namespace Ubilingua
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
