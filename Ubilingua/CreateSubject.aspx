<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateSubject.aspx.cs" Inherits="Ubilingua.CreateSubject" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-horizontal">
        <h2>Crear nuevo curso</h2>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="SubjectName" CssClass="col-md-2 control-label">Nombre del curso</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="SubjectName" CssClass="form-control" TextMode="SingleLine" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="SubjectName"
                    CssClass="text-danger" ErrorMessage="El campo de nombre es obligatorio." />
            </div>
            

        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Contraseña (Opcional)</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Password" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="FileUpload" CssClass="col-md-2 control-label">Imagen del curso</asp:Label>
            <div class="col-md-10">
                <asp:FileUpload runat="server" id="FileUpload" />
            </div>

        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="CreateSubject_Click" Text="Crear curso" CssClass="btn btn-default" />
            </div>
        </div>
    </div>
</asp:Content>
