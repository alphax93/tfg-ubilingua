<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Teachers.aspx.cs" Inherits="Ubilingua.Teachers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" StaticEnableDefaultPopOutImage="false" OnMenuItemClick="Menu_Click" CssClass="tab">
        <StaticMenuItemStyle CssClass="tab-item" />
        <StaticSelectedStyle BackColor="#cccccc" BorderStyle="inset" />
        <StaticHoverStyle BackColor="#bbbbbb" />
    </asp:Menu>
    <asp:Panel runat="server" CssClass="tab-content">
        <asp:MultiView ID="Multiview" runat="server">
        </asp:MultiView>
    </asp:Panel>
</asp:Content>
