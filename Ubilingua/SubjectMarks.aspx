<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubjectMarks.aspx.cs" Inherits="Ubilingua.SubjectMarks" Culture="auto:es-ES" UICulture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    
    <asp:Panel runat="server" CssClass="panel">
        <h3>Calificaciones</h3>
        <asp:Label runat="server" CssClass="h3" meta:resourcekey="calificaciones"></asp:Label>
    <asp:GridView ID="markList" runat="server" GridLines="Horizontal" ItemType="Ubilingua.Models.joinusermarks" SelectMethod="GetElements" AutoGenerateColumns="false" CssClass="table table-responsive">
        <Columns>
            <asp:TemplateField meta:resourcekey="nombre" HeaderStyle-CssClass="panel-body" ItemStyle-CssClass="panel-body">
                <ItemTemplate>
                    <%#:Item.TaskName %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField meta:resourcekey="fecha" HeaderStyle-CssClass="panel-body" ItemStyle-CssClass="panel-body">
                <ItemTemplate>
                    <%#:Item.Delivered %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField meta:resourcekey="calificacion" HeaderStyle-CssClass="panel-body" ItemStyle-CssClass="panel-body">
                <ItemTemplate>
                    <%#: Item.Mark %>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
        </asp:Panel>
</asp:Content>
