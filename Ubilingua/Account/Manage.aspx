<%@ Page Title="Administrar cuenta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="Ubilingua.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Import Namespace="Ubilingua.NewExtensions" %>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:UpdatePanel runat="server" ID="updatePanel" UpdateMode="Conditional">
        <Triggers></Triggers>
        <ContentTemplate>
            <asp:Panel runat="server" CssClass="panel">
                <h2><%: User.Identity.GetName() + " " + User.Identity.GetSurname1() + " " + User.Identity.GetSurname2() %></h2>
                <b>Correo electrónico: </b>
                <br />
                <p id="email" runat="server">&emsp;</p>
                <div>
                    <h3>Mis cursos privados</h3>
                    <asp:ListView runat="server" ID="SubjectList" SelectMethod="GetSubjects" ItemType="Ubilingua.Models.Subject">
                        <EmptyItemTemplate>
                            <p>No es miembro de ningún curso privado</p>
                        </EmptyItemTemplate>
                        <ItemTemplate>
                            &emsp; <a href="../Subject.aspx?subjectID=<%#: Item.SubjectID %>"><%#: Item.SubjectName %></a>
                        </ItemTemplate>
                    </asp:ListView>

                </div>
                <br />
                <div class="btn-group">
                    <asp:Button Text="Editar Datos" runat="server" CssClass="btn" OnClick="ShowProfilePopu" OnClientClick="return true" CausesValidation="false" />
                    <asp:Button Text="Cambiar Contraseña Acceso" runat="server" CssClass="btn" OnClick="GoToChangePassword" OnClientClick="return true" CausesValidation="false" />
                    <asp:LoginView runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Profesor">
                                <ContentTemplate>
                                    <asp:Button Text="Cambiar Contraseña Profesor" runat="server" CssClass="btn" OnClick="GoToChangeTeacherPassword" OnClientClick="return true" CausesValidation="false" />
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                    </asp:LoginView>
                    <asp:Button Text="Eliminar Cuenta" runat="server" CssClass="btn" OnClick="DeleteAccount" OnClientClick="if (!confirm('¿Está seguro de que desea eliminar su cuenta?')) return false;" CausesValidation="false" />
                </div>
            </asp:Panel>

            <asp:HiddenField ID="EditUserDummy" runat="server" />
            <asp:ModalPopupExtender ID="EditUserPopup" runat="server"
                CancelControlID="EditUserBtnCancel"
                TargetControlID="EditUserDummy" PopupControlID="EditUserPanel"
                PopupDragHandleControlID="EditUserPopupHeader" Drag="true">
            </asp:ModalPopupExtender>
            <asp:Panel ID="EditUserPanel" Style="display: none" runat="server" CssClass="panel-popup">
                <div>
                    <div id="EditUserPopupHeader" class="modal-header">
                        <h4>Editar Tema</h4>
                    </div>
                    <br />
                    <div class="form-group">
                        <asp:Label runat="server">Nombre</asp:Label>
                        <asp:TextBox runat="server" ID="EditUserName" TextMode="SingleLine" ClientIDMode="Static"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="EditUserName" ID="EditUserValidator" ClientIDMode="Static"
                            CssClass="text-danger" ErrorMessage="El campo de nombre es obligatorio." />
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server">Primer Apellido</asp:Label>
                        <asp:TextBox runat="server" ID="EditSurname1" TextMode="SingleLine" ClientIDMode="Static"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="EditSurname1" ID="RequiredFieldValidator1" ClientIDMode="Static"
                            CssClass="text-danger" ErrorMessage="El primer apellido es obligatorio." />
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server">Segundo Apellido</asp:Label>
                        <asp:TextBox runat="server" ID="EditSurname2" TextMode="SingleLine" ClientIDMode="Static"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server">Correo Electrónico</asp:Label>
                        <asp:TextBox runat="server" ID="EditEmail" TextMode="Email" ClientIDMode="Static"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="EditUserName" ID="RequiredFieldValidator2" ClientIDMode="Static"
                            CssClass="text-danger" ErrorMessage="El correo electrónico es obligatorio." />
                    </div>
                    <div class="modal-footer">
                        <asp:Button Text="Aceptar" OnClick="EditUser_Click" CssClass="panel-button" runat="server" OnClientClick="return checkEditUser()" ID="createEditUserButton" />

                        <input id="EditUserBtnCancel" type="button" value="Cancelar" class="panel-button" />
                    </div>
                </div>
            </asp:Panel>
            
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
