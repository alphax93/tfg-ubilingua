<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewTest.aspx.cs" Inherits="Ubilingua.ViewTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <script type="text/javascript" src="js/SCORM_API_wrapper.js"></script>
<script type="text/javascript" src="js/SCOFunctions.js"></script>
    <script>
        var scorm = pipwerks.SCORM;
        var lmsConnected = false;
        lmsConnected = scorm.init();
    </script>

    <iframe runat="server" id="frame" height="500" width="100%"></iframe>

    <script type="text/javascript">
        
        
        
        //window.onbeforeunload = function (e) {
        //    var dialogText = '¿Seguro que quieres salir?';
        //    e.returnValue = dialogText;
        //    return dialogText;
            ////var r = confirm("desea abandonar?");
            //if (r) {
            //    alert("aaaaaa");
            //} else {
            //    alert("sdsdgsdgsd");
            //}
            //return r;
        //}


        function saveScore() {

            var score = document.getElementById('MainContent_frame').contentWindow.actualScore;
            $.ajax(
                {
                    type: "POST",
                    url: "ViewTest.aspx/SaveScore",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: "{a: " + score + "}",
                    success: function (msg) {
                        alert("exito");
                    },
                    failure: function (msg) {
                        alert("fallo");
                    }
                });
        }

    </script>

    <input type="button" id="but" onclick="saveScore();" />
</asp:Content>
