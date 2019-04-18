<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewTest.aspx.cs" Inherits="Ubilingua.ViewTest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    
    <iframe runat="server" id="frame" height="500" width="100%" >

    </iframe>

    

    <script>
        window.onbeforeunload = function (e) {
            var dialogText = '¿Seguro que quieres salir?';
  e.returnValue = dialogText;
  return dialogText;
            ////var r = confirm("desea abandonar?");
            //if (r) {
            //    alert("aaaaaa");
            //} else {
            //    alert("sdsdgsdgsd");
            //}
            //return r;
        }

        


    </script>

    <input type="button" id="but" onclick="alert(document.getElementById('MainContent_frame').contentWindow.actualScore); return false;"/>
</asp:Content>
