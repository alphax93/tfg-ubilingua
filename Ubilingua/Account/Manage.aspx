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
                <asp:Label runat="server" CssClass="h4" meta:resourcekey="correo"></asp:Label>
                <br />
                <p id="email" runat="server">&emsp;</p>
                <div>
                    <asp:Label runat="server" CssClass="h3" meta:resourcekey="miscursos"></asp:Label>
                    <br />
                    <asp:ListView runat="server" ID="SubjectList" SelectMethod="GetSubjects" ItemType="Ubilingua.Models.subjects">
                        <EmptyItemTemplate>
                            <asp:Label runat="server" meta:resourcekey="ninguncurso"></asp:Label>
                        </EmptyItemTemplate>
                        <ItemTemplate>
                            &emsp; <a href="../Subject.aspx?subjectID=<%#: Item.SubjectID %>"><%#: Item.SubjectName %></a>
                        </ItemTemplate>
                    </asp:ListView>

                </div>
                <br />
                <div class="btn-group">
                    <asp:Button meta:resourcekey="editar" runat="server" CssClass="btn" OnClick="ShowProfilePopu" OnClientClick="return true" CausesValidation="false" />
                    <asp:Button meta:resourcekey="cambiarcont" runat="server" CssClass="btn" OnClick="GoToChangePassword" OnClientClick="return true" CausesValidation="false" />
                    <asp:LoginView runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Profesor">
                                <ContentTemplate>
                                    <asp:Button meta:resourcekey="datosProf" runat="server" CssClass="btn" OnClick="GoToTeacherProfile" OnClientClick="return true" CausesValidation="false" />
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                    </asp:LoginView>
                    <asp:Button meta:resourcekey="elim" runat="server" CssClass="btn" OnClick="DeleteAccount" CausesValidation="false" />
                </div>
                <br />
                <asp:Label meta:resourcekey="okCont" runat="server" Visible="false" CssClass="text-danger" ID="successChangePass"></asp:Label>
                <asp:Label meta:resourcekey="okDatos" runat="server" Visible="false" CssClass="text-danger" ID="successChangeUser"></asp:Label>
                <asp:Label meta:resourcekey="okPerfil" runat="server" Visible="false" CssClass="text-danger" ID="successTeacherProf"></asp:Label>
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
                        <asp:Label runat="server" meta:resourcekey="nombre"></asp:Label> *
                        <asp:TextBox runat="server" ID="EditUserName" TextMode="SingleLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="EditUserName" ID="EditUserValidator" ClientIDMode="Static"
                            CssClass="text-danger" meta:resourcekey="validNombre" />
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" meta:resourcekey="pApellido"></asp:Label> *
                        <asp:TextBox runat="server" ID="EditSurname1" TextMode="SingleLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="EditSurname1" ID="EditSurname1Validator" ClientIDMode="Static"
                            CssClass="text-danger" meta:resourcekey="validApellido" />
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" meta:resourcekey="sApellido"></asp:Label>
                        <asp:TextBox runat="server" ID="EditSurname2" TextMode="SingleLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" meta:resourcekey="correo"></asp:Label> *
                        <asp:TextBox runat="server" ID="EditEmail" TextMode="Email" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>
                    </div>
                    <asp:Label runat="server" Text="<%$ Resources:General, campoObligatorio %>" ></asp:Label>
                    <div class="modal-footer">
                        <asp:Button Text="<%$ Resources:General, aceptar%>" OnClick="EditUser_Click" CssClass="panel-button" runat="server" OnClientClick="return checkEditUser()" ID="createEditUserButton" />

                        <asp:Button runat="server" Text="<%$ Resources:General, cancelar%>"  ID="EditUserBtnCancel" CssClass="panel-button" />
                    </div>
                </div>
            </asp:Panel>
            
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
