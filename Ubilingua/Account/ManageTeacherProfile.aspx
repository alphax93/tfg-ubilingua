<%@ Page Title="Perfil de profesor" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageTeacherProfile.aspx.cs" Inherits="Ubilingua.Account.ManageTeacherProfile" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:Panel runat="server" CssClass="panel">
        <h2><%: Title %>.</h2>
        <div class="form-group">
            <asp:Label runat="server">Responsable de </asp:Label>
            <asp:TextBox runat="server" ID="Position" TextMode="MultiLine" ClientIDMode="Static" Width="100%"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label runat="server">Función en el grupo (español)</asp:Label>
            <asp:TextBox runat="server" ID="SpanishRole" TextMode="MultiLine" ClientIDMode="Static" Width="100%"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label runat="server">Función en el grupo (otro idioma)</asp:Label>
            <asp:TextBox runat="server" ID="OtherRole" TextMode="MultiLine" ClientIDMode="Static" Width="100%"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label runat="server">CV (español)</asp:Label>
            <asp:TextBox runat="server" ID="SpanishCV" TextMode="MultiLine" ClientIDMode="Static" Width="100%"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label runat="server">CV (otro idioma)</asp:Label>
            <asp:TextBox runat="server" ID="OtherCV" TextMode="MultiLine" ClientIDMode="Static" Width="100%"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label runat="server">Contacto</asp:Label>
            <asp:TextBox runat="server" ID="Contact" TextMode="MultiLine" ClientIDMode="Static" Width="100%"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label runat="server">Foto</asp:Label>
            <asp:FileUpload runat="server" ID="Image"/>
        </div>
        <asp:Button Text="Crear" OnClick="TeacherProfile_Click" CssClass="panel-button" runat="server"  ID="create" Visible="false"/>
        <asp:Button Text="Actualizar" OnClick="UpdateTeacherProfile_Click" CssClass="panel-button" runat="server" ID="update" Visible="false"/>
        <asp:Button Text="Eliminar" OnClick="DeleteTeacherProfile_Click" CssClass="panel-button" runat="server" OnClientClick="if (!confirm('¿Está seguro de que desea eliminar?')) return false;"/>
    </asp:Panel>
</asp:Content>
