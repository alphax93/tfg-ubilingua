<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Riddle.aspx.cs" Inherits="Ubilingua.Riddle" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:LoginView runat="server">
        <AnonymousTemplate>
        </AnonymousTemplate>
        <LoggedInTemplate>
            <asp:Panel runat="server">
                <asp:Label runat="server" ID="name" CssClass="panel-title"></asp:Label>
                <br />
                <audio controls>
                    <source id="audioSource" runat="server" />
                </audio>
                <a id="audioLink" runat="server" download><asp:Label runat="server" meta:resourcekey="download"></asp:Label></a>
                <asp:Panel runat="server" ID="imagePanelContainer" CssClass="panel">
                    <asp:Panel runat="server" ID="imagePanelExtender">
                        <asp:Image ID="imagePanelImage" runat="server" CssClass="first" ImageUrl="Subjects/Images/uparrow.png" Width="20px" Height="20px" />
                        <asp:Label runat="server" meta:resourcekey="img"></asp:Label>
                    </asp:Panel>
                    <asp:Panel runat="server" ID="imagePanel">
                        <asp:Image runat="server" ID="imageImage" />
                    </asp:Panel>
                    <asp:CollapsiblePanelExtender ID="cpe1" runat="server" TargetControlID="imagePanel" CollapsedSize="0" Collapsed="true" ExpandControlID="imagePanelExtender" CollapseControlID="imagePanelExtender"
                        AutoCollapse="false" AutoExpand="false" ScrollContents="false" ImageControlID="imagePanelImage" ExpandDirection="Vertical"
                        ExpandedImage="Subjects/Images/downarrow.png" CollapsedImage="Subjects/Images/uparrow.png"></asp:CollapsiblePanelExtender>
                </asp:Panel>

                <asp:Panel runat="server" ID="OGTextPanelContainer" CssClass="panel">
                    <asp:Panel runat="server" ID="OGTextPanelExtender">
                        <asp:Image ID="OGTextPanelImage" runat="server" CssClass="first" ImageUrl="Subjects/Images/uparrow.png" Width="20px" Height="20px" />
                        <asp:Label runat="server" meta:resourcekey="transcripcion"></asp:Label>
                    </asp:Panel>
                    <asp:Panel runat="server" ID="OGTextPanel">
                        <p style="white-space: pre" id="ogtext" runat="server"></p>
                    </asp:Panel>
                    <asp:CollapsiblePanelExtender ID="cpe2" runat="server" TargetControlID="OGTextPanel" CollapsedSize="0" Collapsed="true" ExpandControlID="OGTextPanelExtender" CollapseControlID="OGTextPanelExtender"
                        AutoCollapse="false" AutoExpand="false" ScrollContents="false" ImageControlID="OGTextPanelImage" ExpandDirection="Vertical"
                        ExpandedImage="Subjects/Images/downarrow.png" CollapsedImage="Subjects/Images/uparrow.png"></asp:CollapsiblePanelExtender>
                </asp:Panel>

                <asp:Panel runat="server" ID="TransTextPanelContainer" CssClass="panel">
                    <asp:Panel runat="server" ID="TransTextPanelExtender">
                        <asp:Image ID="TransTextPanelImage" runat="server" CssClass="first" ImageUrl="Subjects/Images/uparrow.png" Width="20px" Height="20px" />
                        <asp:Label runat="server" meta:resourcekey="traduccion"></asp:Label>
                    </asp:Panel>
                    <asp:Panel runat="server" ID="TransTextPanel">
                        <p style="white-space: pre" id="transtext" runat="server"></p>
                    </asp:Panel>
                    <asp:CollapsiblePanelExtender ID="cpe3" runat="server" TargetControlID="TransTextPanel" CollapsedSize="0" Collapsed="true" ExpandControlID="TransTextPanelExtender" CollapseControlID="TransTextPanelExtender"
                        AutoCollapse="false" AutoExpand="false" ScrollContents="false" ImageControlID="TransTextPanelImage" ExpandDirection="Vertical"
                        ExpandedImage="Subjects/Images/downarrow.png" CollapsedImage="Subjects/Images/uparrow.png"></asp:CollapsiblePanelExtender>
                </asp:Panel>

                <asp:Panel runat="server" ID="AnswerPanelContainer" CssClass="panel">
                    <asp:Panel runat="server" ID="AnswerPanelExtender">
                        <asp:Image ID="AnswerPanelImage" runat="server" CssClass="first" ImageUrl="Subjects/Images/uparrow.png" Width="20px" Height="20px" />
                        <asp:Label runat="server" meta:resourcekey="sol"></asp:Label>
                    </asp:Panel>
                    <asp:Panel runat="server" ID="AnswerPanel">
                        <p style="white-space: pre" id="answer" runat="server"></p>
                    </asp:Panel>
                    <asp:CollapsiblePanelExtender ID="cpe4" runat="server" TargetControlID="AnswerPanel" CollapsedSize="0" Collapsed="true" ExpandControlID="AnswerPanelExtender" CollapseControlID="AnswerPanelExtender"
                        AutoCollapse="false" AutoExpand="false" ScrollContents="false" ImageControlID="AnswerPanelImage" ExpandDirection="Vertical"
                        ExpandedImage="Subjects/Images/downarrow.png" CollapsedImage="Subjects/Images/uparrow.png"></asp:CollapsiblePanelExtender>
                </asp:Panel>
            </asp:Panel>
        </LoggedInTemplate>
    </asp:LoginView>
</asp:Content>
