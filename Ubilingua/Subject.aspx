<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Subject.aspx.cs" Inherits="Ubilingua.Subject" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section>
        <br />

        <div>

            <asp:LoginView runat="server">
                <AnonymousTemplate>
                    <%Response.Redirect("./Account/Login"); %>
                </AnonymousTemplate>
                <RoleGroups>
                    <asp:RoleGroup Roles="Profesor">
                        <ContentTemplate>
                            <asp:UpdatePanel runat="server" UpdateMode="Conditional" ID="UpdatePanel" ChildrenAsTriggers="false">
                                <ContentTemplate>
                                    <asp:Label runat="server" ID="subjectName" CssClass="h2"><%#: subject.SubjectName %></asp:Label>
                                    <br />
                                    <br />
                                    <asp:Panel runat="server" CssClass="btn-group-vertical">
                                        <asp:Button runat="server" Text="Añadir Tema" CssClass="btn" OnClick="ShowBlockPanel" CausesValidation="false" />
                                        <asp:Button runat="server" Text="Editar Nombre Curso" CssClass="btn" OnClick="ShowSubjectPanel" CausesValidation="false" />
                                        <asp:Button runat="server" ID="MakePrivate" Text="Hacer Privado" OnClick="ShowMakePrivate" CssClass="btn" CausesValidation="false" Visible="false" ClientIDMode="Static" />
                                        <asp:Button runat="server" ID="ChangePassword" Text="Cambiar Contraseña" OnClick="ShowChangePassword" CssClass="btn" CausesValidation="false" ClientIDMode="Static" />
                                        <asp:Button runat="server" ID="MakePublic" Text="Hacer Público" OnClick="MakePublicClick" CssClass="btn" CausesValidation="false" Visible="false" ClientIDMode="Static" OnClientClick="if (!confirm('¿Está seguro de que desea hacer público el curso?')) return false;" />
                                        <asp:Button runat="server" Text="Abandonar Curso" CssClass="btn" CausesValidation="false" OnClientClick="if (!confirm('¿Está seguro de que desea abandonar el curso?')) return false;" OnClick="LeaveSubject" ID="LeaveButton" Visible="false" />
                                        <asp:Button runat="server" Text="Eliminar Curso" CssClass="btn" CausesValidation="false" OnClientClick="if (!confirm('¿Está seguro de que desea borrar?')) return false;" OnClick="DeleteSubject" />
                                    </asp:Panel>

                                    <div class="col-md-11">


                                        <asp:ListView ID="blockList" runat="server" DataKeyNames="BlockID" GroupItemCount="1" ItemType="Ubilingua.Models.Block" SelectMethod="GetBlocks">
                                            <EmptyDataTemplate>
                                                <table>
                                                    <tr>
                                                        <td>Curso vacío.</td>
                                                    </tr>
                                                </table>
                                            </EmptyDataTemplate>
                                            <EmptyItemTemplate>
                                                </td>
                                            </EmptyItemTemplate>
                                            <ItemTemplate>

                                                <td runat="server">
                                                    <asp:Panel CssClass="panel" ID="pnlCategories" runat="server">

                                                        <asp:Panel runat="server" ID="panelExtenderControl">
                                                            <asp:Image ID="imgCollapsible" CssClass="first" ImageUrl="~/Subjects/Images/uparrow.jpg" runat="server" Width="20px" Height="20px" />
                                                        </asp:Panel>
                                                        <span class="panel-title panel-heading" style="display: inline-block"><%#:Item.BlockName %></span>
                                                        <asp:LinkButton runat="server" OnCommand="DeleteBlock" ID="deleteBlockButton" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false" OnClientClick="if (!confirm('¿Está seguro de que desea borrar?')) return false;"><span class="glyphicon glyphicon-remove"></span></asp:LinkButton>

                                                        <asp:LinkButton runat="server" OnCommand="ShowEditBlock" ID="editBlockButton" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false"><span class="glyphicon glyphicon-pencil"></span></asp:LinkButton>

                                                        <asp:Panel ID="pnlProducts" runat="server" CssClass="panel-body">

                                                            <asp:ListView ID="resourceList" runat="server" DataKeyNames="BlockID" GroupItemCount="1" ItemType="Ubilingua.Models.Resource" SelectMethod="GetResources" UpdateMethod="GetResources">
                                                                <EmptyDataTemplate>

                                                                    <p></p>

                                                                </EmptyDataTemplate>
                                                                <EmptyItemTemplate>
                                                                    </td>
                                                                </EmptyItemTemplate>

                                                                <ItemTemplate>
                                                                    <div class="row">
                                                                        <div class="col-md-1">
                                                                            <asp:LinkButton runat="server" OnCommand="DeleteResource" ID="deleteButton" CommandArgument="<%#:Item.ResourceID %>" CausesValidation="false" OnClientClick="if (!confirm('¿Está seguro de que desea borrar?')) return false;"><span class="glyphicon glyphicon-remove <%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"></span></asp:LinkButton>
                                                                            <asp:LinkButton runat="server" OnCommand="ChangeVisibility" ID="visibleButton" CommandArgument="<%#:Item.ResourceID %>" CausesValidation="false"><span class="<%#:(Item.IsVisible == true ? "glyphicon glyphicon-eye-open visible" : "glyphicon glyphicon-eye-close notvisible")%>" id="eye"></span></asp:LinkButton>

                                                                            <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="text"? true : false%>'>
                                                                                <asp:LinkButton runat="server" OnCommand="ShowEditText" CommandArgument="<%#:Item.ResourceID %>" CausesValidation="false" OnClientClick="return true"><span class="glyphicon glyphicon-pencil <%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"></span></asp:LinkButton>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <p style="white-space: pre" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#: HttpUtility.HtmlEncode(Item.ResourcePath) %></p>

                                                                            </asp:PlaceHolder>

                                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="download"? true : false %>'>
                                                                            <asp:LinkButton runat="server" OnCommand="ShowEditDownload" CommandArgument="<%#:Item.ResourceID %>" CausesValidation="false" OnClientClick="return true"><span class="glyphicon glyphicon-pencil <%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"></span></asp:LinkButton>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="glyphicon glyphicon-save"></span>
                                                                            <a href="Subjects/<%#: subjectID%>/Downloadables/<%#Item.ResourcePath %>" download class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#Item.ResourceName %></a><br />
                                                                            </asp:PlaceHolder>

                                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="img"? true : false %>'>
                                                                            <asp:LinkButton runat="server" OnCommand="ShowEditImage" CommandArgument="<%#:Item.ResourceID %>" CausesValidation="false" OnClientClick="return true"><span class="glyphicon glyphicon-pencil <%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"></span></asp:LinkButton>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <img src="Subjects/<%#: subjectID%>/Images/<%#Item.ResourcePath %>" alt="<%#: Item.ResourceName %>" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"></img><br />
                                                                            </asp:PlaceHolder>

                                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="video"? true : false %>'>
                                                                            <asp:LinkButton runat="server" OnCommand="ShowEditVideo" CommandArgument="<%#:Item.ResourceID %>" CausesValidation="false" OnClientClick="return true"><span class="glyphicon glyphicon-pencil <%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"></span></asp:LinkButton>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <iframe src="<%#Item.ResourcePath %>" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#Item.ResourceName %></iframe>

                                                                            </asp:PlaceHolder>
                                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="riddle"? true : false %>'>
                                                                            <asp:LinkButton runat="server" OnCommand="ShowEditRiddle" CommandArgument="<%#:Item.ResourceID %>" CausesValidation="false" OnClientClick="return true"><span class="glyphicon glyphicon-pencil <%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"></span></asp:LinkButton>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="glyphicon glyphicon-headphones"></span>
                                                                            <a href="Riddle.aspx?ResourceID=<%#Item.ResourceID %>" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#Item.ResourceName %></a>

                                                                            </asp:PlaceHolder>
                                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="task"? true : false %>'>
                                                                            <asp:LinkButton runat="server" OnCommand="ShowEditTask" CommandArgument="<%#:Item.ResourceID %>" CausesValidation="false" OnClientClick="return true"><span class="glyphicon glyphicon-pencil <%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"></span></asp:LinkButton>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="glyphicon glyphicon-open"></span>
                                                                            <a href="ViewTask.aspx?ResourceID=<%#Item.ResourceID %>" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#Item.ResourceName %></a>

                                                                            </asp:PlaceHolder>
                                                                        </div>

                                                                    </div>
                                                                    <br />
                                                                </ItemTemplate>
                                                            </asp:ListView>
                                                            <br />
                                                            <div class="btn-group">
                                                                <asp:Button ID="AddDownload" runat="server" Text="Añadir Recurso Descargable" OnCommand="ShowDownloadPopup" CssClass="btn" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false" />
                                                                <asp:Button ID="AddVideo" runat="server" Text="Añadir Video" OnCommand="ShowVideoPopup" CssClass="btn" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false" />
                                                                <asp:Button ID="AddImage" runat="server" Text="Añadir Imagen" OnCommand="ShowImagePopup" CssClass="btn" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false" />
                                                                <asp:Button ID="AddText" runat="server" Text="Añadir Texto" OnCommand="ShowTextPopup" CssClass="btn" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false" />
                                                                <asp:Button ID="AddRiddle" runat="server" Text="Añadir Adivinanza" OnCommand="ShowRiddlePopup" CssClass="btn" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false" />
                                                                <asp:Button ID="AddTask" runat="server" Text="Añadir Tarea" OnCommand="ShowTaskPopup" CssClass="btn" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false" />
                                                            </div>
                                                        </asp:Panel>

                                                    </asp:Panel>
                                                    <asp:CollapsiblePanelExtender ID="cpe" runat="server" TargetControlID="pnlProducts" CollapsedSize="0" Collapsed="False" ExpandControlID="panelExtenderControl" CollapseControlID="panelExtenderControl"
                                                        AutoCollapse="False" AutoExpand="False" ScrollContents="false" ImageControlID="imgCollapsible" ExpandDirection="Vertical" ExpandedImage="~/Subjects/Images/downarrow.png" CollapsedImage="~/Subjects/Images/uparrow.png"></asp:CollapsiblePanelExtender>
                                                </td>
                                            </ItemTemplate>

                                        </asp:ListView>
                                    </div>
                                    <asp:HiddenField ID="EditSubjectDummy" runat="server" />
                                    <asp:ModalPopupExtender ID="EditSubjectPopup" runat="server"
                                        CancelControlID="EditSubjectBtnCancel"
                                        TargetControlID="EditSubjectDummy" PopupControlID="EditSubjectPanel"
                                        PopupDragHandleControlID="EditSubjectPopupHeader" Drag="true">
                                    </asp:ModalPopupExtender>
                                    <asp:Panel ID="EditSubjectPanel" Style="display: none" runat="server" CssClass="panel-popup">
                                        <div>
                                            <div id="EditSubjectPopupHeader" class="modal-header">
                                                <h4>Editar Curso</h4>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <asp:Label runat="server">Nombre</asp:Label>
                                                <asp:TextBox runat="server" ID="EditSubjectName" TextMode="SingleLine" ClientIDMode="Static"></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="EditSubjectName" ID="EditSubjectValidator" ClientIDMode="Static"
                                                    CssClass="text-danger" ErrorMessage="El campo de nombre es obligatorio." />
                                            </div>

                                            <div class="modal-footer">
                                                <asp:Button Text="Aceptar" OnClick="EditSubject_Click" CssClass="panel-button" runat="server" OnClientClick="return checkEditSubject()" ID="EditSubjectButton" />

                                                <input id="EditSubjectBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                            </div>
                                        </div>
                                    </asp:Panel>

                                    <asp:HiddenField ID="EditSubjectPasswordDummy" runat="server" />
                                    <asp:ModalPopupExtender ID="EditSubjectPasswordPopup" runat="server"
                                        CancelControlID="EditSubjectPasswordBtnCancel"
                                        TargetControlID="EditSubjectPasswordDummy" PopupControlID="EditSubjectPasswordPanel"
                                        PopupDragHandleControlID="EditSubjectPasswordPopupHeader" Drag="true">
                                    </asp:ModalPopupExtender>
                                    <asp:Panel ID="EditSubjectPasswordPanel" Style="display: none" runat="server" CssClass="panel-popup">
                                        <div>
                                            <div id="EditSubjectPasswordPopupHeader" class="modal-header">
                                                <h4>Hacer Curso Privado</h4>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <asp:Label runat="server">Contraseña</asp:Label>
                                                <asp:TextBox runat="server" ID="EditSubjectPassword" TextMode="Password" ClientIDMode="Static"></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="EditSubjectPassword" ID="EditSubjectPasswordValidator" ClientIDMode="Static"
                                                    CssClass="text-danger" ErrorMessage="El campo de contraseña es obligatorio." />
                                            </div>

                                            <div class="modal-footer">
                                                <asp:Button Text="Aceptar" OnClick="EditSubjectPassword_Click" CssClass="panel-button" runat="server" OnClientClick="return checkEditSubjectPassword()" ID="EditSubjectPasswordButton" />

                                                <input id="EditSubjectPasswordBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                            </div>
                                        </div>
                                    </asp:Panel>

                                    <asp:HiddenField ID="ChangeSubjectPasswordDummy" runat="server" />
                                    <asp:ModalPopupExtender ID="ChangeSubjectPasswordPopup" runat="server"
                                        CancelControlID="ChangeSubjectPasswordBtnCancel"
                                        TargetControlID="ChangeSubjectPasswordDummy" PopupControlID="ChangeSubjectPasswordPanel"
                                        PopupDragHandleControlID="ChangeSubjectPasswordPopupHeader" Drag="true">
                                    </asp:ModalPopupExtender>
                                    <asp:Panel ID="ChangeSubjectPasswordPanel" Style="display: none" runat="server" CssClass="panel-popup">
                                        <div>
                                            <div id="ChangeSubjectPasswordPopupHeader" class="modal-header">
                                                <h4>Cambiar Contraseña</h4>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <asp:Label runat="server">Nueva contraseña</asp:Label>
                                                <asp:TextBox runat="server" ID="ChangeSubjectPassword" TextMode="Password" ClientIDMode="Static"></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ChangeSubjectPassword" ID="ChangeSubjectPasswordValidator" ClientIDMode="Static"
                                                    CssClass="text-danger" ErrorMessage="El campo de contraseña es obligatorio." />
                                            </div>

                                            <div class="modal-footer">
                                                <asp:Button Text="Aceptar" OnClick="ChangeSubjectPassword_Click" CssClass="panel-button" runat="server" OnClientClick="return checkChangeSubjectPassword()" ID="ChangeSubjectPasswordButton" />

                                                <input id="ChangeSubjectPasswordBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                            </div>
                                        </div>
                                    </asp:Panel>

                                    <asp:HiddenField ID="BlockDummy" runat="server" />
                                    <asp:ModalPopupExtender ID="BlockPopup" runat="server"
                                        CancelControlID="BlockBtnCancel"
                                        TargetControlID="BlockDummy" PopupControlID="BlockPanel"
                                        PopupDragHandleControlID="BlockPopupHeader" Drag="true">
                                    </asp:ModalPopupExtender>
                                    <asp:Panel ID="BlockPanel" Style="display: none" runat="server" CssClass="panel-popup">
                                        <div>
                                            <div id="BlockPopupHeader" class="modal-header">
                                                <h4>Nuevo Tema</h4>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <asp:Label runat="server">Nombre</asp:Label>
                                                <asp:TextBox runat="server" ID="BlockName" TextMode="SingleLine" ClientIDMode="Static"></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="BlockName" ID="BlockValidator" ClientIDMode="Static"
                                                    CssClass="text-danger" ErrorMessage="El campo de nombre es obligatorio." />
                                            </div>

                                            <div class="modal-footer">
                                                <asp:Button Text="Aceptar" OnClick="CreateBlock_Click" CssClass="panel-button" runat="server" OnClientClick="return checkBlock()" ID="createBlockButton" />

                                                <input id="BlockBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                            </div>
                                        </div>
                                    </asp:Panel>

                                    <asp:HiddenField ID="EditBlockDummy" runat="server" />
                                    <asp:ModalPopupExtender ID="EditBlockPopup" runat="server"
                                        CancelControlID="EditBlockBtnCancel"
                                        TargetControlID="EditBlockDummy" PopupControlID="EditBlockPanel"
                                        PopupDragHandleControlID="EditBlockPopupHeader" Drag="true">
                                    </asp:ModalPopupExtender>
                                    <asp:Panel ID="EditBlockPanel" Style="display: none" runat="server" CssClass="panel-popup">
                                        <div>
                                            <div id="EditBlockPopupHeader" class="modal-header">
                                                <h4>Editar Tema</h4>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <asp:Label runat="server">Nombre</asp:Label>
                                                <asp:TextBox runat="server" ID="EditBlockName" TextMode="SingleLine" ClientIDMode="Static"></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="EditBlockName" ID="EditBlockValidator" ClientIDMode="Static"
                                                    CssClass="text-danger" ErrorMessage="El campo de nombre es obligatorio." />
                                            </div>

                                            <div class="modal-footer">
                                                <asp:Button Text="Aceptar" OnClick="EditBlock_Click" CssClass="panel-button" runat="server" OnClientClick="return checkEditBlock()" ID="createEditBlockButton" />

                                                <input id="EditBlockBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                            </div>
                                        </div>
                                    </asp:Panel>

                                    <asp:HiddenField ID="textDummy" runat="server" />
                                    <asp:ModalPopupExtender ID="AddTextPopup" runat="server"
                                        CancelControlID="textBtnCancel"
                                        TargetControlID="textDummy" PopupControlID="textPanel"
                                        PopupDragHandleControlID="textPopupHeader" Drag="true">
                                    </asp:ModalPopupExtender>
                                    <asp:Panel ID="textPanel" Style="display: none" runat="server" CssClass="panel-popup">
                                        <div>
                                            <div id="textPopupHeader" class="modal-header">
                                                <h4>Nuevo bloque de texto</h4>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <asp:TextBox runat="server" ID="textResource" TextMode="MultiLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="textResource" ID="textValidator" ClientIDMode="Static"
                                                    CssClass="text-danger" ErrorMessage="El campo de texto es obligatorio." />
                                            </div>

                                            <div class="modal-footer">
                                                <asp:Button Text="Aceptar" OnClick="NewTextResource" CssClass="panel-button" runat="server" OnClientClick="return checkText()" />

                                                <input id="textBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                            </div>
                                        </div>
                                    </asp:Panel>

                                    <asp:HiddenField ID="editTextDummy" runat="server" />
                                    <asp:ModalPopupExtender ID="EditTextPopup" runat="server"
                                        CancelControlID="editTextBtnCancel"
                                        TargetControlID="editTextDummy" PopupControlID="editTextPanel"
                                        PopupDragHandleControlID="editTextPopupHeader" Drag="true">
                                    </asp:ModalPopupExtender>
                                    <asp:Panel ID="editTextPanel" Style="display: none" runat="server" CssClass="panel-popup">
                                        <div>
                                            <div id="editTextPopupHeader" class="modal-header">
                                                <h4>Editar bloque de texto</h4>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <asp:TextBox runat="server" ID="editTextResource" TextMode="MultiLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="editTextResource" ID="editTextValidator" ClientIDMode="Static"
                                                    CssClass="text-danger" ErrorMessage="El campo de texto es obligatorio." />
                                            </div>

                                            <div class="modal-footer">
                                                <asp:Button Text="Aceptar" OnClick="EditTextResource" CssClass="panel-button" runat="server" OnClientClick="return checkTextEdit()" />

                                                <input id="editTextBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                            </div>
                                        </div>
                                    </asp:Panel>

                                    <asp:HiddenField ID="videoDummy" runat="server" />
                                    <asp:ModalPopupExtender ID="addVideoPopup" runat="server"
                                        CancelControlID="videoBtnCancel"
                                        TargetControlID="videoDummy" PopupControlID="videoPanel"
                                        PopupDragHandleControlID="videoPopupHeader" Drag="true">
                                    </asp:ModalPopupExtender>
                                    <asp:Panel ID="videoPanel" Style="display: none" runat="server" CssClass="panel-popup">
                                        <div>
                                            <div id="videoPopupHeader" class="modal-header">
                                                <h4>Editar Video (Youtube)</h4>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <asp:Label runat="server" AssociatedControlID="videoResourceName">Nombre del Video</asp:Label>
                                                <asp:TextBox runat="server" ID="videoResourceName" CssClass="form-control" TextMode="SingleLine" ClientIDMode="Static" />
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="videoResourceName" ClientIDMode="Static" ID="videoResourceNameValidator"
                                                    CssClass="text-danger" ErrorMessage="El campo de nombre es obligatorio." />
                                            </div>
                                            <div class="form-group">
                                                <asp:Label runat="server" AssociatedControlID="videoPath">Enlace</asp:Label>
                                                <asp:TextBox runat="server" ID="videoPath" CssClass="form-control" TextMode="SingleLine" ClientIDMode="Static" />
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="videoPath" ClientIDMode="Static" ID="videoResourcePathValidator"
                                                    CssClass="text-danger" ErrorMessage="El campo de enlace es obligatorio." />
                                                <asp:RegularExpressionValidator runat="server" ControlToValidate="videoPath" ClientIDMode="Static" ID="youtubeValidator" ValidationExpression="(https:\/\/)?www\.youtube\.com\/watch\?v=.*|https:\/\/www\.youtube\.com\/embed\/.*"
                                                    CssClass="text-danger" ErrorMessage="El enlace debe ser de youtube." />
                                            </div>
                                            <div class="modal-footer">
                                                <asp:Button Text="Aceptar" OnClick="NewVideoResource" CssClass="panel-button" runat="server" OnClientClick="return checkVideo()" />

                                                <input id="videoBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                            </div>
                                        </div>
                                    </asp:Panel>

                                    <asp:HiddenField ID="EditVideoDummy" runat="server" />
                                    <asp:ModalPopupExtender ID="EditVideoPopup" runat="server"
                                        CancelControlID="EditVideoBtnCancel"
                                        TargetControlID="EditVideoDummy" PopupControlID="EditVideoPanel"
                                        PopupDragHandleControlID="EditVideoPopupHeader" Drag="true">
                                    </asp:ModalPopupExtender>
                                    <asp:Panel ID="EditVideoPanel" Style="display: none" runat="server" CssClass="panel-popup">
                                        <div>
                                            <div id="EditVideoPopupHeader" class="modal-header">
                                                <h4>Editar Video (Youtube)</h4>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <asp:Label runat="server" AssociatedControlID="EditVideoResourceName">Nombre del Video</asp:Label>
                                                <asp:TextBox runat="server" ID="EditVideoResourceName" CssClass="form-control" TextMode="SingleLine" ClientIDMode="Static" />
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="EditVideoResourceName" ClientIDMode="Static" ID="EditVideoResourceNameValidator"
                                                    CssClass="text-danger" ErrorMessage="El campo de nombre es obligatorio." />
                                            </div>
                                            <div class="form-group">
                                                <asp:Label runat="server" AssociatedControlID="EditVideoPath">Enlace</asp:Label>
                                                <asp:TextBox runat="server" ID="EditVideoPath" CssClass="form-control" TextMode="SingleLine" ClientIDMode="Static" />
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="EditVideoPath" ClientIDMode="Static" ID="EditVideoResourcePathValidator"
                                                    CssClass="text-danger" ErrorMessage="El campo de enlace es obligatorio." />
                                                <asp:RegularExpressionValidator runat="server" ControlToValidate="EditVideoPath" ClientIDMode="Static" ID="RegularExpressionValidator1" ValidationExpression="https:\/\/www\.youtube\.com\/watch\?v=\w*|https:\/\/www\.youtube\.com\/embed\/\w*"
                                                    CssClass="text-danger" ErrorMessage="El enlace debe ser de youtube." />
                                            </div>
                                            <div class="modal-footer">
                                                <asp:Button Text="Aceptar" OnClick="EditVideoResource" CssClass="panel-button" runat="server" OnClientClick="return checkEditVideo()" />

                                                <input id="EditVideoBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                            </div>
                                        </div>
                                    </asp:Panel>






                                    <asp:HiddenField ID="taskDummy" runat="server" />
                                    <asp:ModalPopupExtender ID="AddTaskPopup" runat="server"
                                        CancelControlID="taskBtnCancel"
                                        TargetControlID="taskDummy" PopupControlID="taskPanel"
                                        PopupDragHandleControlID="taskPopupHeader" Drag="true">
                                    </asp:ModalPopupExtender>
                                    <asp:Panel ID="taskPanel" Style="display: none" runat="server" CssClass="panel-popup">
                                        <div>
                                            <div id="taskPopupHeader" class="modal-header">
                                                <h4>Nueva tarea</h4>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <asp:Label runat="server" AssociatedControlID="taskName">Nombre</asp:Label>
                                                <asp:TextBox runat="server" ID="taskName" CssClass="form-control" TextMode="SingleLine" ClientIDMode="Static" />
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="taskName" ClientIDMode="Static" ID="taskNameValidator"
                                                    CssClass="text-danger" ErrorMessage="El campo de nombre es obligatorio." />
                                            </div>
                                            <div class="form-group">
                                                <asp:Label runat="server" AssociatedControlID="taskText">Descripción</asp:Label>
                                                <asp:TextBox runat="server" ID="taskText" CssClass="form-control" TextMode="MultiLine" ClientIDMode="Static" Width="100%"/>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="taskText" ClientIDMode="Static" ID="taskTextValidator"
                                                    CssClass="text-danger" ErrorMessage="El campo de descripción es obligatorio." />
                                            </div>
                                            <div class="form-group">
                                                <asp:Label runat="server" AssociatedControlID="taskDate">Fecha de entrega</asp:Label>
                                                <asp:TextBox runat="server" ID="taskDate" CssClass="form-control" TextMode="DateTimeLocal" ClientIDMode="Static" />
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="taskDate" ClientIDMode="Static" ID="taskDateValidator"
                                                    CssClass="text-danger" ErrorMessage="El campo de fecha es obligatorio." />
                                            </div>
                                            <div class="modal-footer">
                                                <asp:Button Text="Aceptar" OnClick="NewTaskResource" CssClass="panel-button" runat="server" OnClientClick="return checkTask()" />
                                                <input id="taskBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                            </div>
                                        </div>
                                    </asp:Panel>

                                    <asp:HiddenField ID="EditTaskDummy" runat="server" />
                                    <asp:ModalPopupExtender ID="EditTaskPopup" runat="server"
                                        CancelControlID="EditTaskBtnCancel"
                                        TargetControlID="EditTaskDummy" PopupControlID="EditTaskPanel"
                                        PopupDragHandleControlID="EditTaskPopupHeader" Drag="true">
                                    </asp:ModalPopupExtender>
                                    <asp:Panel ID="EditTaskPanel" Style="display: none" runat="server" CssClass="panel-popup">
                                        <div>
                                            <div id="EditTaskPopupHeader" class="modal-header">
                                                <h4>Nueva tarea</h4>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <asp:Label runat="server" AssociatedControlID="EditTaskName">Nombre</asp:Label>
                                                <asp:TextBox runat="server" ID="EditTaskName" CssClass="form-control" TextMode="SingleLine" ClientIDMode="Static" />
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="EditTaskName" ClientIDMode="Static" ID="EditTaskNameValidator"
                                                    CssClass="text-danger" ErrorMessage="El campo de nombre es obligatorio." />
                                            </div>
                                            <div class="form-group">
                                                <asp:Label runat="server" AssociatedControlID="EditTaskText">Descripción</asp:Label>
                                                <asp:TextBox runat="server" ID="EditTaskText" CssClass="form-control" TextMode="MultiLine" ClientIDMode="Static" Width="100%"/>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="EditTaskText" ClientIDMode="Static" ID="EditTaskTextValidator"
                                                    CssClass="text-danger" ErrorMessage="El campo de descripción es obligatorio." />
                                            </div>
                                            <div class="form-group">
                                                <asp:Label runat="server" AssociatedControlID="EditTaskDate">Fecha de entrega</asp:Label>
                                                <asp:TextBox runat="server" ID="EditTaskDate" CssClass="form-control" TextMode="DateTimeLocal" ClientIDMode="Static" />
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="EditTaskDate" ClientIDMode="Static" ID="EditTaskDateValidator"
                                                    CssClass="text-danger" ErrorMessage="El campo de fecha es obligatorio." />
                                            </div>
                                            <asp:HiddenField runat="server" ID="deadlineHidden" ClientIDMode="Static"/>
                                            <div class="modal-footer">
                                                <asp:Button Text="Aceptar" OnClick="EditTaskResource" CssClass="panel-button" runat="server" OnClientClick="return checkEditTask()" />
                                                <input id="EditTaskBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                            </div>
                                        </div>
                                    </asp:Panel>



                                </ContentTemplate>
                                <Triggers>
                                </Triggers>
                            </asp:UpdatePanel>
                            <asp:HiddenField ID="downloadDummy" runat="server" />
                            <asp:ModalPopupExtender ID="AddDownloadPopup" runat="server"
                                CancelControlID="downloadBtnCancel"
                                TargetControlID="downloadDummy" PopupControlID="downloadPanel"
                                PopupDragHandleControlID="downloadPopupHeader" Drag="true">
                            </asp:ModalPopupExtender>

                            <asp:Panel ID="downloadPanel" Style="display: none" runat="server" CssClass="panel-popup">
                                <div>
                                    <div id="downloadPopupHeader" class="modal-header">
                                        <h4>Nuevo Recurso Descargable (PDF, Word, PowerPoint...)</h4>
                                    </div>
                                    <br />
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="downloadResourceName">Nombre del Recurso</asp:Label>
                                        <asp:TextBox runat="server" ID="downloadResourceName" CssClass="form-control" TextMode="SingleLine" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="downloadResourceName" ClientIDMode="Static" ID="downloadNameValidator"
                                            CssClass="text-danger" ErrorMessage="El campo de nombre es obligatorio." />
                                    </div>
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="downloadResourceFile">Archivo</asp:Label>
                                        <asp:FileUpload ID="downloadResourceFile" runat="server" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="downloadResourceFile" ClientIDMode="Static" ID="downloadFileValidator"
                                            CssClass="text-danger" ErrorMessage="El campo de archivo es obligatorio"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Button Text="Aceptar" OnClick="NewDownloadableResource" CssClass="panel-button" runat="server" OnClientClick="return checkDownload()" />
                                        <input id="downloadBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                    </div>
                                </div>
                            </asp:Panel>

                            <asp:HiddenField ID="editDownloadDummy" runat="server" />
                            <asp:ModalPopupExtender ID="editDownloadPopup" runat="server"
                                CancelControlID="editDownloadBtnCancel"
                                TargetControlID="editDownloadDummy" PopupControlID="editDownloadPanel"
                                PopupDragHandleControlID="editDownloadPopupHeader" Drag="true">
                            </asp:ModalPopupExtender>

                            <asp:Panel ID="editDownloadPanel" Style="display: none" runat="server" CssClass="panel-popup">
                                <div>
                                    <div id="editDownloadPopupHeader" class="modal-header">
                                        <h4>Nuevo Recurso Descargable (PDF, Word, PowerPoint...)</h4>
                                    </div>
                                    <br />
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="editDownloadResourceName">Nombre del Recurso</asp:Label>
                                        <asp:TextBox runat="server" ID="editDownloadResourceName" CssClass="form-control" TextMode="SingleLine" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="editDownloadResourceName" ClientIDMode="Static" ID="editDownloadNameValidator"
                                            CssClass="text-danger" ErrorMessage="El campo de nombre es obligatorio." />
                                    </div>
                                    <div class="form-group">
                                        <asp:Label runat="server">Archivo en el servidor: </asp:Label>
                                        <asp:Label runat="server" ID="oldFileName" ClientIDMode="Static"></asp:Label><br />
                                        <asp:Label runat="server" AssociatedControlID="editDownloadResourceFile">Nuevo archivo</asp:Label>
                                        <asp:FileUpload ID="editDownloadResourceFile" runat="server" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="editDownloadResourceFile" ClientIDMode="Static" ID="editDownloadFileValidator"
                                            CssClass="text-danger" ErrorMessage="El campo de archivo es obligatorio"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Button Text="Aceptar" OnClick="editDownloadableResource" CssClass="panel-button" runat="server" OnClientClick="return checkeditDownload()" />
                                        <input id="editDownloadBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:HiddenField ID="imageDummy" runat="server" />
                            <asp:ModalPopupExtender ID="addImagePopup" runat="server"
                                CancelControlID="imageBtnCancel"
                                TargetControlID="imageDummy" PopupControlID="imagePanel"
                                PopupDragHandleControlID="imagePopupHeader" Drag="true">
                            </asp:ModalPopupExtender>
                            <asp:Panel ID="imagePanel" Style="display: none" runat="server" CssClass="panel-popup">
                                <div>
                                    <div id="imagePopupHeader" class="modal-header">
                                        <h4>Nueva Imagen (jpg, png o gif)</h4>
                                    </div>
                                    <br />
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="imageResourceFile">Archivo</asp:Label>
                                        <asp:FileUpload ID="imageResourceFile" runat="server" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="imageResourceFile" ClientIDMode="Static" ID="imageValidator"
                                            CssClass="text-danger" ErrorMessage="El campo de archivo es obligatorio." />
                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="imageResourceFile" ClientIDMode="Static" ID="imageExtensionValidator"
                                            CssClass="text-danger" ErrorMessage="Formato de imagen incorrecto." ValidationExpression="^.+\.(jpg|JPG|png|PNG|gif|GIF)$" />
                                    </div>

                                    <div class="modal-footer">
                                        <asp:Button Text="Aceptar" OnClick="NewImageResource" CssClass="panel-button" runat="server" OnClientClick="return checkImage()" />

                                        <input id="imageBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                    </div>
                                </div>
                            </asp:Panel>

                            <asp:HiddenField ID="EditImageDummy" runat="server" />
                            <asp:ModalPopupExtender ID="EditImagePopup" runat="server"
                                CancelControlID="EditImageBtnCancel"
                                TargetControlID="EditImageDummy" PopupControlID="EditImagePanel"
                                PopupDragHandleControlID="EditImagePopupHeader" Drag="true">
                            </asp:ModalPopupExtender>
                            <asp:Panel ID="EditImagePanel" Style="display: none" runat="server" CssClass="panel-popup">
                                <div>
                                    <div id="EditImagePopupHeader" class="modal-header">
                                        <h4>Cambiar Imagen (jpg, png o gif)</h4>
                                    </div>
                                    <br />
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="EditImageResourceFile">Archivo</asp:Label>
                                        <asp:FileUpload ID="EditImageResourceFile" runat="server" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="EditImageResourceFile" ClientIDMode="Static" ID="EditImageValidator"
                                            CssClass="text-danger" ErrorMessage="El campo de archivo es obligatorio." />
                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="EditImageResourceFile" ClientIDMode="Static" ID="EditImageExtensionValidator"
                                            CssClass="text-danger" ErrorMessage="Formato de imagen incorrecto." ValidationExpression="^.+\.(jpg|JPG|png|PNG|gif|GIF)$" />
                                    </div>

                                    <div class="modal-footer">
                                        <asp:Button Text="Aceptar" OnClick="EditImageResource" CssClass="panel-button" runat="server" OnClientClick="return checkEditImage()" />

                                        <input id="EditImageBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:HiddenField ID="riddleDummy" runat="server" />
                            <asp:ModalPopupExtender ID="AddRiddlePopup" runat="server"
                                CancelControlID="riddleBtnCancel"
                                TargetControlID="riddleDummy" PopupControlID="riddlePanel"
                                PopupDragHandleControlID="riddlePopupHeader" Drag="true">
                            </asp:ModalPopupExtender>
                            <asp:Panel ID="riddlePanel" Style="display: none" runat="server" CssClass="panel-popup">
                                <div>
                                    <div id="riddlePopupHeader" class="modal-header">
                                        <h4>Nueva adivinanza</h4>
                                    </div>
                                    <br />
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="riddleName">Nombre</asp:Label>
                                        <asp:TextBox runat="server" ID="riddleName" CssClass="form-control" TextMode="SingleLine" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="riddleName" ClientIDMode="Static" ID="riddleNameValidator"
                                            CssClass="text-danger" ErrorMessage="El campo de nombre es obligatorio." />
                                    </div>
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="riddleAudioFile">Audio</asp:Label>
                                        <asp:FileUpload ID="riddleAudioFile" runat="server" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="riddleAudioFile" ClientIDMode="Static" ID="AudioFileValidator"
                                            CssClass="text-danger" ErrorMessage="El archivo de audio es obligatorio." />
                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="riddleAudioFile" ClientIDMode="Static" ID="riddleAudioFileExtValidator"
                                            CssClass="text-danger" ErrorMessage="Formato de imagen incorrecto." ValidationExpression="^.+\.(mp3|MP3)$" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="riddleImageFile">Imagen</asp:Label>
                                        <asp:FileUpload ID="riddleImageFile" runat="server" ClientIDMode="Static" />

                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="riddleImageFile" ClientIDMode="Static" ID="riddleImageFileExtValidator"
                                            CssClass="text-danger" ErrorMessage="Formato de imagen incorrecto." ValidationExpression="^.+\.(jpg|JPG|png|PNG|gif|GIF)$" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="OGText">Texto sin traducir</asp:Label>
                                        <br />
                                        <asp:TextBox runat="server" ID="OGTExt" TextMode="MultiLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>

                                    </div>

                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="TransText">Traducción</asp:Label>
                                        <br />
                                        <asp:TextBox runat="server" ID="TransText" TextMode="MultiLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>

                                    </div>
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="riddleAnswer">Solución</asp:Label>
                                        <br />
                                        <asp:TextBox runat="server" ID="riddleAnswer" TextMode="SingleLine" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="riddleAnswer" ClientIDMode="Static" ID="riddleAnswerValidator"
                                            CssClass="text-danger" ErrorMessage="La solución es obligatoria." />
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Button Text="Aceptar" OnClick="NewRiddleResource" CssClass="panel-button" runat="server" OnClientClick="return checkRiddle()"  />

                                        <input id="riddleBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                    </div>
                                </div>
                            </asp:Panel>

                            <asp:HiddenField ID="EditRiddleDummy" runat="server" />
                            <asp:ModalPopupExtender ID="EditRiddlePopup" runat="server"
                                CancelControlID="EditRiddleBtnCancel"
                                TargetControlID="EditRiddleDummy" PopupControlID="EditRiddlePanel"
                                PopupDragHandleControlID="EditRiddlePopupHeader" Drag="true">
                            </asp:ModalPopupExtender>
                            <asp:Panel ID="EditRiddlePanel" Style="display: none" runat="server" CssClass="panel-popup">
                                <div>
                                    <div id="EditRiddlePopupHeader" class="modal-header">
                                        <h4>Nueva adivinanza</h4>
                                    </div>
                                    <br />
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="EditRiddleName">Nombre</asp:Label>
                                        <asp:TextBox runat="server" ID="EditRiddleName" CssClass="form-control" TextMode="SingleLine" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="EditRiddleName" ClientIDMode="Static" ID="EditRiddleNameValidator"
                                            CssClass="text-danger" ErrorMessage="El campo de nombre es obligatorio." />
                                    </div>
                                    <div class="form-group">
                                        <asp:Label runat="server">Audio en el servidor: </asp:Label>
                                        <asp:Label ID="oldRiddleAudio" runat="server"></asp:Label><br />
                                        <asp:Label runat="server" AssociatedControlID="EditRiddleAudioFile">Audio</asp:Label>
                                        <asp:FileUpload ID="EditRiddleAudioFile" runat="server" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="EditRiddleAudioFile" ClientIDMode="Static" ID="EditRiddleAudioValidator"
                                            CssClass="text-danger" ErrorMessage="El archivo de audio es obligatorio." />
                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="EditRiddleAudioFile" ClientIDMode="Static" ID="EditRiddleAudioFileExtValidator"
                                            CssClass="text-danger" ErrorMessage="Formato de imagen incorrecto." ValidationExpression="^.+\.(mp3|MP3)$" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Label runat="server">Imagen en el servidor: </asp:Label>
                                        <asp:Label ID="oldRiddleImage" runat="server"></asp:Label><br />
                                        <asp:Label runat="server" AssociatedControlID="EditRiddleImageFile">Imagen</asp:Label>
                                        <asp:FileUpload ID="EditRiddleImageFile" runat="server" ClientIDMode="Static" />

                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="EditRiddleImageFile" ClientIDMode="Static" ID="EditRiddleImageFileExtValidator"
                                            CssClass="text-danger" ErrorMessage="Formato de imagen incorrecto." ValidationExpression="^.+\.(jpg|JPG|png|PNG|gif|GIF)$" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="EditOGText">Texto sin traducir</asp:Label>
                                        <br />
                                        <asp:TextBox runat="server" ID="EditOGTExt" TextMode="MultiLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>

                                    </div>

                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="EditTransText">Traducción</asp:Label>
                                        <br />
                                        <asp:TextBox runat="server" ID="EditTransText" TextMode="MultiLine" ClientIDMode="Static" Width="100%" CssClass="form-control"></asp:TextBox>

                                    </div>
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="EditRiddleAnswer">Solución</asp:Label>
                                        <br />
                                        <asp:TextBox runat="server" ID="EditRiddleAnswer" TextMode="SingleLine" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="EditRiddleAnswer" ClientIDMode="Static" ID="EditRiddleAnswerValidator"
                                            CssClass="text-danger" ErrorMessage="La solución es obligatoria." />
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Button Text="Aceptar" OnClick="EditRiddleResource" CssClass="panel-button" runat="server" OnClientClick="return checkEditRiddle()" />

                                        <input id="EditRiddleBtnCancel" type="button" value="Cancelar" class="panel-button" />
                                    </div>
                                </div>
                            </asp:Panel>

                        </ContentTemplate>
                    </asp:RoleGroup>
                    <asp:RoleGroup Roles="Alumno">
                        <ContentTemplate>
                            <asp:Label runat="server" ID="subjectName" CssClass="h2"><%#: subject.SubjectName %></asp:Label>
                            <br />
                            <br />
                            <asp:Panel runat="server" CssClass="btn-group-vertical">
                                <asp:Button runat="server" Text="Ver Calificaciones" CssClass="btn" CausesValidation="false" OnClick="ViewMarks" />
                                <asp:Button runat="server" Text="Abandonar Curso" CssClass="btn" CausesValidation="false" OnClientClick="if (!confirm('¿Está seguro de que desea abandonar el curso?')) return false;" OnClick="LeaveSubject" ID="LeaveButton" Visible="false" />
                            </asp:Panel>
                            <div class="col-md-11">
                                <asp:ListView ID="blockList" runat="server" DataKeyNames="BlockID" GroupItemCount="1" ItemType="Ubilingua.Models.Block" SelectMethod="GetBlocks">
                                    <EmptyDataTemplate>
                                        <table>
                                            <tr>
                                                <td>Curso vacío.</td>
                                            </tr>
                                        </table>
                                    </EmptyDataTemplate>
                                    <EmptyItemTemplate>
                                        </td>
                                    </EmptyItemTemplate>
                                    <ItemTemplate>
                                        <td runat="server">
                                            <asp:Panel CssClass="panel" ID="pnlCategories" runat="server">
                                                <asp:Panel runat="server" ID="panelExtenderControl">
                                                    <asp:Image ID="imgCollapsible" CssClass="first" ImageUrl="~/Subjects/Images/uparrow.jpg" runat="server" Width="20px" Height="20px" />
                                                </asp:Panel>
                                                <span class="panel-title panel-heading" style="display: inline-block"><%#:Item.BlockName %></span>



                                                <asp:Panel ID="pnlProducts" runat="server" CssClass="panel-body">

                                                    <asp:ListView ID="resourceList" runat="server" DataKeyNames="BlockID" GroupItemCount="1" ItemType="Ubilingua.Models.Resource" SelectMethod="GetVisibleResources" UpdateMethod="GetVisibleResources">
                                                        <EmptyDataTemplate>

                                                            <p></p>

                                                        </EmptyDataTemplate>
                                                        <EmptyItemTemplate>
                                                            </td>
                                                        </EmptyItemTemplate>

                                                        <ItemTemplate>
                                                            <div class="row">


                                                                <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="text"? true : false%>'>

                                                                    <div class="col-md-4">
                                                                        <p style="white-space: pre" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#: HttpUtility.HtmlEncode(Item.ResourcePath) %></p>
                                                                </asp:PlaceHolder>

                                                                <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="download"? true : false %>'>

                                                                    <div class="col-md-4">
                                                                        <span class="glyphicon glyphicon-save"></span>
                                                                        <a href="Subjects/<%#: subjectID%>/Downloadables/<%#Item.ResourcePath %>" download class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#Item.ResourceName %></a><br />
                                                                </asp:PlaceHolder>

                                                                <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="img"? true : false %>'>

                                                                    <div class="col-md-4">
                                                                        <img src="Subjects/<%#: subjectID%>/Images/<%#Item.ResourcePath %>" alt="<%#: Item.ResourceName %>" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"></img><br />
                                                                </asp:PlaceHolder>

                                                                <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="video"? true : false %>'>

                                                                    <div class="col-md-4">
                                                                        <iframe src="<%#Item.ResourcePath %>" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#Item.ResourceName %></iframe>
                                                                </asp:PlaceHolder>
                                                                <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="riddle"? true : false %>'>

                                                                    <div class="col-md-4">
                                                                        <span class="glyphicon glyphicon-headphones"></span>
                                                                        <a href="Riddle.aspx?ResourceID=<%#Item.ResourceID %>" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#Item.ResourceName %></a>
                                                                </asp:PlaceHolder>
                                                                <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="task"? true : false %>'>

                                                                    <div class="col-md-4">
                                                                        <span class="glyphicon glyphicon-open"></span>
                                                                        <a href="ViewTask.aspx?ResourceID=<%#Item.ResourceID %>" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#Item.ResourceName %></a>
                                                                </asp:PlaceHolder>
                                                            </div>

                                                            </div>
                                                                <br />
                                                        </ItemTemplate>
                                                    </asp:ListView>
                                                    <br />

                                                </asp:Panel>

                                            </asp:Panel>
                                            <asp:CollapsiblePanelExtender ID="cpe" runat="server" TargetControlID="pnlProducts" CollapsedSize="0" Collapsed="False" ExpandControlID="panelExtenderControl" CollapseControlID="panelExtenderControl"
                                                AutoCollapse="False" AutoExpand="False" ScrollContents="false" ImageControlID="imgCollapsible" ExpandDirection="Vertical" ExpandedImage="~/Subjects/Images/downarrow.png" CollapsedImage="~/Subjects/Images/uparrow.png"></asp:CollapsiblePanelExtender>
                                        </td>
                                    </ItemTemplate>

                                </asp:ListView>
                            </div>
                        </ContentTemplate>
                    </asp:RoleGroup>
                </RoleGroups>
            </asp:LoginView>
        </div>
    </section>

</asp:Content>
