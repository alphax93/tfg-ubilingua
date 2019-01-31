﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace Ubilingua.NewExtensions
{
    public static class ControlExtensions
    {
        public static Control FindControlRecursive(this Control ctrl, string controlID)
        {
            if (string.Compare(ctrl.ID, controlID, true) == 0)
            {
                // We found the control!
                return ctrl;
            }
            else
            {
                // Recurse through ctrl's Controls collections
                foreach (Control child in ctrl.Controls)
                {
                    Control lookFor = FindControlRecursive(child, controlID);

                    if (lookFor != null)
                        return lookFor;  // We found the control
                }

                // If we reach here, control was not found
                return null;
            }
        }
    }
}