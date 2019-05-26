<%@ Page Title="Perfil de profesor" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageTeacherProfile.aspx.cs" Inherits="Ubilingua.Account.ManageTeacherProfile" Culture="auto:es-ES" UICulture="auto" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:Panel runat="server" CssClass="panel">
        <h2><%: Title %>.</h2>
        <div class="form-group">
            <asp:Label runat="server" meta:resourcekey="resp"> </asp:Label>
            <asp:TextBox runat="server" ID="Position" TextMode="MultiLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label runat="server" meta:resourcekey="funEsp"></asp:Label>
            <asp:TextBox runat="server" ID="SpanishRole" TextMode="MultiLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label runat="server" meta:resourcekey="funOt"></asp:Label>
            <asp:TextBox runat="server" ID="OtherRole" TextMode="MultiLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label runat="server" meta:resourcekey="cvEsp"></asp:Label>
            <asp:TextBox runat="server" ID="SpanishCV" TextMode="MultiLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label runat="server" meta:resourcekey="cvOt"></asp:Label>
            <asp:TextBox runat="server" ID="OtherCV" TextMode="MultiLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label runat="server" meta:resourcekey="contact"></asp:Label>
            <asp:TextBox runat="server" ID="Contact" TextMode="MultiLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label runat="server" meta:resourcekey="foto"></asp:Label>
            <asp:FileUpload runat="server" ID="Image"/>
            <asp:RegularExpressionValidator runat="server" ControlToValidate="Image" ClientIDMode="Static" ID="imageExtensionValidator"
                                            CssClass="text-danger" ErrorMessage="Formato de imagen incorrecto." ValidationExpression="^.+\.(jpg|JPG|png|PNG|gif|GIF)$" />
        </div>
        <asp:Button meta:resourcekey="crear" OnClick="TeacherProfile_Click" CssClass="panel-button" runat="server"  ID="create" Visible="false" OnClientClick="return checkProfileImage()"/>
        <asp:Button meta:resourcekey="act" OnClick="UpdateTeacherProfile_Click" CssClass="panel-button" runat="server" ID="update" Visible="false" OnClientClick="return checkProfileImage()"/>
        <asp:Button meta:resourcekey="elim" OnClick="DeleteTeacherProfile_Click" CssClass="panel-button" runat="server" OnClientClick=""/>
    </asp:Panel>
</asp:Content>
