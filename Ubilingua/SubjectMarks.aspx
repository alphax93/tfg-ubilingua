<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubjectMarks.aspx.cs" Inherits="Ubilingua.SubjectMarks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <h3>Calificaciones</h3>
    <asp:Panel runat="server" CssClass="panel">
    <asp:GridView ID="markList" runat="server" GridLines="Horizontal" ItemType="Ubilingua.Models.JoinUserMark" SelectMethod="GetElements" AutoGenerateColumns="false" CssClass="table-responsive">
        <Columns>
            <asp:TemplateField HeaderText="Nombre" HeaderStyle-CssClass="panel-body" ItemStyle-CssClass="panel-body">
                <ItemTemplate>
                    <%#:Item.TaskName %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Fecha de entrega" HeaderStyle-CssClass="panel-body" ItemStyle-CssClass="panel-body">
                <ItemTemplate>
                    <%#:Item.Delivered %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Calificación" HeaderStyle-CssClass="panel-body" ItemStyle-CssClass="panel-body">
                <ItemTemplate>
                    <%#: Item.Mark %>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
        </asp:Panel>
</asp:Content>
