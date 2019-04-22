<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateSubject.aspx.cs" Inherits="Ubilingua.CreateSubject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:Panel runat="server" CssClass="panel">
        <div class="form-horizontal">
            <h2>Crear nuevo curso</h2>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="SubjectName" CssClass="col-md-2 control-label" meta:resourcekey="nombre"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="SubjectName" CssClass="form-control" TextMode="SingleLine" /> 
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="SubjectName"
                        CssClass="text-danger" meta:resourcekey="valid" />
                </div>


            </div>
            <div class="form-group" >
                <asp:Label runat="server" meta:resourcekey="cont" AssociatedControlID="Password" CssClass="col-md-2 control-label" ></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="Password" CssClass="form-control" TextMode="Password" meta:resourcekey="cont"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="FileUpload" CssClass="col-md-2 control-label" meta:resourcekey="img"></asp:Label>
                <div class="col-md-10">
                    <asp:FileUpload runat="server" ID="FileUpload" />
                </div>

            </div>
            <asp:Label runat="server" Text="<%$ Resources:General, campoObligatorio %>" ></asp:Label>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button runat="server" OnClick="CreateSubject_Click" Text="<%$ Resources:General, aceptar %>" CssClass="panel-button" />
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
