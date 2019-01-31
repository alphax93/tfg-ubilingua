<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubjectPassword.aspx.cs" Inherits="Ubilingua.SubjectPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-horizontal">
        
        <h3><asp:Label runat="server" ID="SubjectName"></asp:Label></h3>
        <asp:Label runat="server" CssClass="control-label">Necesita la contraseña para acceder a este curso</asp:Label>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Contraseña</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="El campo de contraseña es obligatorio." />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="AccessSubject_Click" Text="Acceder a curso" CssClass="btn btn-default" />
            </div>
        </div>

    </div>
</asp:Content>
