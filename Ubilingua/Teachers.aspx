﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Teachers.aspx.cs" Inherits="Ubilingua.Teachers" Culture="auto:es-ES" UICulture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" StaticEnableDefaultPopOutImage="false" OnMenuItemClick="Menu_Click" CssClass="tab">
        <StaticMenuItemStyle CssClass="tab-item" />
        <StaticSelectedStyle BackColor="#cccccc" BorderStyle="inset" />
        <StaticHoverStyle BackColor="#bbbbbb" />
    </asp:Menu>
    <asp:Panel runat="server" CssClass="tab-content" >
        <asp:Literal runat="server" ID="content"></asp:Literal>
    </asp:Panel>
            </ContentTemplate>
        <Triggers></Triggers>
        </asp:UpdatePanel>
</asp:Content>
