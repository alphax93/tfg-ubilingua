using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Claims;
using System.Security.Principal;

namespace Ubilingua.NewExtensions
{
    public static class IdentityExtension
    {
        public static string GetSurname1(this IIdentity identity)
        {
            var claim = ((ClaimsIdentity)identity).FindFirst("Surname1");
            return (claim != null) ? claim.Value : string.Empty;
        }

        public static string GetSurname2(this IIdentity identity)
        {
            var claim = ((ClaimsIdentity)identity).FindFirst("Surname2");
            return (claim != null) ? claim.Value : string.Empty;
        }

        public static string GetName(this IIdentity identity)
        {
            var claim = ((ClaimsIdentity)identity).FindFirst("Name");
            return (claim != null) ? claim.Value : string.Empty;
        }
        
    }
}