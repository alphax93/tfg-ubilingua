<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewTask.aspx.cs" Inherits="Ubilingua.ViewTask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:Panel runat="server" CssClass="panel">
        <asp:Label runat="server" ID="name" CssClass="panel-title"></asp:Label>
        <br />
        <br />
        <p style="white-space: pre" runat="server" id="description"></p>
        <br />
        <asp:LoginView runat="server">
            <RoleGroups>
                <asp:RoleGroup Roles="Profesor">
                    <ContentTemplate>

                        <asp:Table runat="server" CssClass="table-bordered" BorderStyle="Solid" BorderWidth="0.5">

                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th">Fecha de entrega</asp:TableHeaderCell>
                                <asp:TableCell ID="date" CssClass="td"></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th">Tiempo restante</asp:TableHeaderCell>
                                <asp:TableCell ID="leftTime" CssClass="td"></asp:TableCell>
                            </asp:TableRow>

                        </asp:Table>
                        <br />
                        <asp:Label runat="server" CssClass="panel-title" Text="Entregas"></asp:Label>
                        <asp:GridView ID="fileList" runat="server" GridLines="Horizontal" ItemType="Ubilingua.Models.joinusermarks" SelectMethod="GetElements" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField HeaderText="Nombre">
                                    <ItemTemplate>
                                        <%#:Item.User %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fecha de entrega">
                                    <ItemTemplate>
                                        <%#:Item.Delivered %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Archivo">
                                    <ItemTemplate>
                                        <a href="Subject/<%#:subjectID %>/Tasks/<%#:id %>/<%#:Item.FilePath %>" download><%#:Item.FilePath %></a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Calificación">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" id="mark" Text="<%#:Item.Mark %>" ></asp:TextBox>
                                        <asp:RangeValidator runat="server" ControlToValidate="mark" MinimumValue="0" MaximumValue="10" Type="Double" Text="Debe introducir un número entre 0 y 10"></asp:RangeValidator>
                                        <asp:HiddenField runat="server" ID="userid" Value="<%#:Item.UserID %>" />
                                        <asp:HiddenField runat="server" ID="resourceid" Value="<%#:Item.ResourceID %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                            </Columns>
                        </asp:GridView>
                        <asp:Button runat="server" ID="SaveMarksButton" CssClass="panel-button" Text="Guardar" OnClick="SaveMarks"/>
                    </ContentTemplate>
                </asp:RoleGroup>
                <asp:RoleGroup Roles="Alumno">
                    <ContentTemplate>
                        <asp:Table runat="server" CssClass="table-bordered" BorderStyle="Solid" BorderWidth="0.5">

                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th">Fecha de entrega</asp:TableHeaderCell>
                                <asp:TableCell ID="date" CssClass="td"></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th">Tiempo restante</asp:TableHeaderCell>
                                <asp:TableCell ID="leftTime" CssClass="td"></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th">Estado</asp:TableHeaderCell>
                                <asp:TableCell CssClass="td" ID="status">Sin entregar</asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th">Archivo</asp:TableHeaderCell>
                                <asp:TableCell CssClass="td" ID="file"> - </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th">Subir archivo</asp:TableHeaderCell>
                                <asp:TableCell CssClass="td" ID="uploadCell">
                                    <asp:FileUpload runat="server" ID="fileUpload" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th">Calificación</asp:TableHeaderCell>
                                <asp:TableCell ID="mark" CssClass="td">-</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <br />
                        <asp:Button runat="server" Text="Subir Archivo" OnClick="Upload_Click" ID="uploadButton" CssClass="panel-button" />
                        <asp:Label runat="server" ID="warning">Se sobreescribirá el archivo anterior</asp:Label>
                    </ContentTemplate>
                </asp:RoleGroup>
            </RoleGroups>
        </asp:LoginView>
    </asp:Panel>
</asp:Content>
