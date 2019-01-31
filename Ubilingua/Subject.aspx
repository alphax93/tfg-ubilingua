<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Subject.aspx.cs" Inherits="Ubilingua.Subject" %>

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
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:ListView ID="blockList" runat="server" DataKeyNames="BlockID" GroupItemCount="1" ItemType="Ubilingua.Models.Block" SelectMethod="GetBlocks">
                                        <EmptyDataTemplate>
                                            <table>
                                                <tr>
                                                    <td>No data was returned.</td>
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
                                                        <span class="panel-title panel-heading" style="display: inline-block" contenteditable="true"><%#:Item.BlockName %></span>
                                                        <asp:LinkButton runat="server" OnCommand="DeleteBlock" ID="deleteBlockButton" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false" OnClientClick="if (!confirm('¿Está seguro de que desea borrar?')) return false;"><span class="glyphicon glyphicon-remove"></span></asp:LinkButton>
                                                    </asp:Panel>
                                                    <asp:Panel ID="pnlProducts" runat="server">

                                                        <asp:ListView ID="resourceList" runat="server" DataKeyNames="BlockID" GroupItemCount="1" ItemType="Ubilingua.Models.Resource" SelectMethod="GetResources">
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
                                                                        <asp:LinkButton runat="server" OnCommand="ChangeVisibility" ID="visibleButton" CommandArgument="<%#:Item.ResourceID %>" CausesValidation="false" ><span class="<%#:(Item.IsVisible == true ? "glyphicon glyphicon-eye-open visible" : "glyphicon glyphicon-eye-close notvisible")%>" id="eye"></span></asp:LinkButton>
                                                                    </div>
                                                                    <div class="col-md-4">
                                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="text"? true : false%>'>
                                                                            
                                                                            <p style="white-space: pre" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#: HttpUtility.HtmlEncode(Item.ResourcePath) %></p>

                                                                        </asp:PlaceHolder>

                                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="download"? true : false %>'>
                                                                            <a href="Resources/<%#Item.ResourcePath %>" download class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#Item.ResourceName %></a><br />
                                                                        </asp:PlaceHolder>

                                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="img"? true : false %>'>
                                                                            <img src="Resources/<%#Item.ResourcePath %>" alt="<%#: Item.ResourceName %>" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"></img><br />
                                                                        </asp:PlaceHolder>

                                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="video"? true : false %>'>
                                                                            <iframe src="<%#Item.ResourcePath %>" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#Item.ResourceName %></iframe>

                                                                        </asp:PlaceHolder>
                                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="riddle"? true : false %>'>
                                                                            <a href="Riddle.aspx?ResourceID=<%#Item.ResourceID %>" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#Item.ResourceName %></a>

                                                                        </asp:PlaceHolder>
                                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="task"? true : false %>'>
                                                                            <a href="ViewTask.aspx?ResourceID=<%#Item.ResourceID %>" class="<%#:(Item.IsVisible == true ? "visible" : "notvisible")%>"><%#Item.ResourceName %></a>

                                                                        </asp:PlaceHolder>
                                                                    </div>
                                                                    
                                                                </div>
                                                                <br />
                                                            </ItemTemplate>
                                                        </asp:ListView>
                                                        <br />
                                                        <asp:Button ID="AddDownload" runat="server" Text="Añadir Recurso Descargable" OnCommand="ShowDownloadPopup" CssClass="panel-button" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false" />
                                                        <asp:Button ID="AddVideo" runat="server" Text="Añadir Video" OnCommand="ShowVideoPopup" CssClass="panel-button" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false" />
                                                        <asp:Button ID="AddImage" runat="server" Text="Añadir Imagen" OnCommand="ShowImagePopup" CssClass="panel-button" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false" />
                                                        <asp:Button ID="AddText" runat="server" Text="Añadir Texto" OnCommand="ShowTextPopup" CssClass="panel-button" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false" />
                                                        <asp:Button ID="AddRiddle" runat="server" Text="Añadir Adivinanza" OnCommand="ShowRiddlePopup" CssClass="panel-button" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false" />
                                                        <asp:Button ID="AddTask" runat="server" Text="Añadir Tarea" OnCommand="ShowTaskPopup" CssClass="panel-button" CommandArgument="<%#:Item.BlockID %>" CausesValidation="false" />
                                                    </asp:Panel>

                                                </asp:Panel>
                                                <asp:CollapsiblePanelExtender ID="cpe" runat="server" TargetControlID="pnlProducts" CollapsedSize="0" Collapsed="False" ExpandControlID="panelExtenderControl" CollapseControlID="panelExtenderControl"
                                                    AutoCollapse="False" AutoExpand="False" ScrollContents="false" ImageControlID="imgCollapsible" ExpandDirection="Vertical" ExpandedImage="~/Subjects/Images/downarrow.png" CollapsedImage="~/Subjects/Images/uparrow.png"></asp:CollapsiblePanelExtender>
                                            </td>
                                        </ItemTemplate>

                                    </asp:ListView>
                                </ContentTemplate>
                                <Triggers>
                                </Triggers>
                            </asp:UpdatePanel>
                            <asp:Panel runat="server" CssClass="panel">
                                <asp:Button runat="server" Text="Añadir Tema" CssClass="panel-button" OnClick="CreateBlock_Click" OnClientClick="CreateBloack_Click" />
                            </asp:Panel>
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


                            <asp:HiddenField ID="videoDummy" runat="server" />
                            <asp:ModalPopupExtender ID="addVideoPopup" runat="server"
                                CancelControlID="videoBtnCancel"
                                TargetControlID="videoDummy" PopupControlID="videoPanel"
                                PopupDragHandleControlID="videoPopupHeader" Drag="true">
                            </asp:ModalPopupExtender>
                            <asp:Panel ID="videoPanel" Style="display: none" runat="server" CssClass="panel-popup">
                                <div>
                                    <div id="videoPopupHeader" class="modal-header">
                                        <h4>Nuevo Video (Youtube)</h4>
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
                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="videoPath" ClientIDMode="Static" ID="youtubeValidator" ValidationExpression="https:\/\/www\.youtube\.com\/watch\?v=\w*|https:\/\/www\.youtube\.com\/embed\/\w*"
                                            CssClass="text-danger" ErrorMessage="El enlace debe ser de youtube." />
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Button Text="Aceptar" OnClick="NewVideoResource" CssClass="panel-button" runat="server" OnClientClick="return checkVideo()" />

                                        <input id="videoBtnCancel" type="button" value="Cancelar" class="panel-button" />
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
                                        <asp:TextBox runat="server" ID="textResource" TextMode="MultiLine" ClientIDMode="Static"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="textResource" ID="textValidator" ClientIDMode="Static"
                                            CssClass="text-danger" ErrorMessage="El campo de texto es obligatorio." />
                                    </div>

                                    <div class="modal-footer">
                                        <asp:Button Text="Aceptar" OnClick="NewTextResource" CssClass="panel-button" runat="server" OnClientClick="return checkText()" />

                                        <input id="textBtnCancel" type="button" value="Cancelar" class="panel-button" />
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
                                        <asp:TextBox runat="server" ID="OGTExt" TextMode="MultiLine" ClientIDMode="Static"></asp:TextBox>

                                    </div>

                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="TransText">Traducción</asp:Label>
                                        <br />
                                        <asp:TextBox runat="server" ID="TransText" TextMode="MultiLine" ClientIDMode="Static"></asp:TextBox>

                                    </div>
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="riddleAnswer">Solución</asp:Label>
                                        <br />
                                        <asp:TextBox runat="server" ID="riddleAnswer" TextMode="SingleLine" ClientIDMode="Static"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="riddleAnswer" ClientIDMode="Static" ID="riddleAnswerValidator"
                                            CssClass="text-danger" ErrorMessage="La solución es obligatoria." />
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Button Text="Aceptar" OnClick="NewRiddleResource" CssClass="panel-button" runat="server" OnClientClick="return checkRiddle()" />

                                        <input id="riddleBtnCancel" type="button" value="Cancelar" class="panel-button" />
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
                                        <asp:TextBox runat="server" ID="taskText" CssClass="form-control" TextMode="MultiLine" ClientIDMode="Static" />
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
                        </ContentTemplate>
                    </asp:RoleGroup>
                    <asp:RoleGroup Roles="Alumno">
                        <ContentTemplate>
                            <asp:ListView ID="blockList" runat="server" DataKeyNames="BlockID" GroupItemCount="1" ItemType="Ubilingua.Models.Block" SelectMethod="GetBlocks">
                                <EmptyDataTemplate>
                                    <table>
                                        <tr>
                                            <td>No data was returned.</td>
                                        </tr>
                                    </table>
                                </EmptyDataTemplate>
                                <EmptyItemTemplate>
                                    </td>
                                </EmptyItemTemplate>
                                <ItemTemplate>
                                    <td runat="server">
                                        <asp:Panel CssClass="panel" ID="pnlCategories" runat="server">
                                            <asp:Image ID="imgCollapsible" CssClass="first" ImageUrl="~/Subjects/Images/uparrow.jpg" runat="server" Width="20px" Height="20px" />
                                            <span class="panel-title panel-heading" style="display: inline-block"><%#:Item.BlockName %></span>

                                            <asp:Panel ID="pnlProducts" runat="server">
                                                <asp:ListView ID="resourceList" runat="server" DataKeyNames="BlockID" GroupItemCount="1" ItemType="Ubilingua.Models.Resource" SelectMethod="GetVisibleResources">
                                                    <EmptyDataTemplate>

                                                        <p></p>

                                                    </EmptyDataTemplate>
                                                    <EmptyItemTemplate>
                                                        </td>
                                                    </EmptyItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="text"? true : false%>'>
                                                            <pre><%#: HttpUtility.HtmlEncode(Item.ResourcePath) %></pre>
                                                            <br />
                                                        </asp:PlaceHolder>

                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="download"? true : false %>'>
                                                            <a href="Resources/<%#Item.ResourcePath %>" download><%#Item.ResourceName %></a><br />
                                                        </asp:PlaceHolder>

                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="img"? true : false %>'>
                                                            <img src="Resources/<%#Item.ResourcePath %>" alt="<%#: Item.ResourceName %>"></img><br />
                                                        </asp:PlaceHolder>

                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="video"? true : false %>'>
                                                            <iframe src="<%#Item.ResourcePath %>"><%#Item.ResourceName %></iframe>
                                                            <br />
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="riddle"? true : false %>'>
                                                            <a href="Riddle.aspx?ResourceID=<%#Item.ResourceID %>"><%#Item.ResourceName %></a>
                                                            <br />
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder runat="server" Visible='<%# Item.ResourceType=="task"? true : false %>'>
                                                            <a href="ViewTask.aspx?ResourceID=<%#Item.ResourceID %>"><%#Item.ResourceName %></a>
                                                            <br />
                                                        </asp:PlaceHolder>
                                                    </ItemTemplate>
                                                </asp:ListView>
                                            </asp:Panel>
                                        </asp:Panel>
                                        <asp:CollapsiblePanelExtender ID="cpe" runat="server" TargetControlID="pnlProducts" CollapsedSize="0" Collapsed="False" ExpandControlID="pnlCategories" CollapseControlID="pnlCategories"
                                            AutoCollapse="False" AutoExpand="False" ScrollContents="false" ImageControlID="imgCollapsible" ExpandDirection="Vertical" ExpandedImage="~/Subjects/Images/downarrow.png" CollapsedImage="~/Subjects/Images/uparrow.png"></asp:CollapsiblePanelExtender>
                                    </td>
                                </ItemTemplate>

                            </asp:ListView>
                        </ContentTemplate>
                    </asp:RoleGroup>
                </RoleGroups>
            </asp:LoginView>
        </div>
    </section>

</asp:Content>
