<%@ Page Title="Registrarse" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Ubilingua.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <asp:Label runat="server" CssClass="h2" meta:resourcekey="reg1"></asp:Label>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>
    <asp:Panel runat="server" CssClass="panel">
    <div class="form-horizontal">
        <asp:Label runat="server" CssClass="h4" meta:resourcekey="crear"></asp:Label>
        <hr />
        
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Username" CssClass="col-md-2 control-label" meta:resourcekey="nombre"></asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Username" CssClass="form-control" TextMode="SingleLine" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Username"
                    CssClass="text-danger" meta:resourcekey="validNombre" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Surname1" CssClass="col-md-2 control-label" meta:resourcekey="pApellido"></asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Surname1" CssClass="form-control" TextMode="SingleLine" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Surname1"
                    CssClass="text-danger" meta:resourcekey="validAp"/>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Surname2" CssClass="col-md-2 control-label" meta:resourcekey="sApellido"></asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Surname2" CssClass="form-control" TextMode="SingleLine" />
            </div>
        </div>
        <br />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label" meta:resourcekey="email"></asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                    CssClass="text-danger" meta:resourcekey="validEmail" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label" meta:resourcekey="cont"></asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" meta:resourcekey="validCont" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label" meta:resourcekey="cont2"></asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" meta:resourcekey="validCont2" />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" meta:resourcekey="validCont3" />
            </div>
        </div>
        <asp:Label runat="server" Text="<%$ Resources:General, campoObligatorio %>" ></asp:Label>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="CreateUser_Click" meta:resourcekey="reg2" CssClass="btn panel-button" />
            </div>
        </div>
    </div>
        </asp:Panel>
</asp:Content>
