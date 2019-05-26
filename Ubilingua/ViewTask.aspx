<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewTask.aspx.cs" Inherits="Ubilingua.ViewTask" Culture="auto:es-ES" UICulture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:Panel runat="server" CssClass="panel">
        <asp:Label runat="server" ID="name" CssClass="panel-title"></asp:Label>
        <br />
        <br />
        <div style="width:100%; display:block; overflow-y:scroll">
        <p style="white-space: pre; word-wrap:hyphenate" runat="server" id="description"></p>
            </div>
        <br />
        <asp:LoginView runat="server">
            <RoleGroups>
                <asp:RoleGroup Roles="Profesor,admin">
                    <ContentTemplate>

                        <asp:Table runat="server" CssClass="table-bordered" BorderStyle="Solid" BorderWidth="0.5">

                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th" meta:resourcekey="fecha"></asp:TableHeaderCell>
                                <asp:TableCell ID="date" CssClass="td"></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th" meta:resourcekey="tiempo"></asp:TableHeaderCell>
                                <asp:TableCell ID="leftTime" CssClass="td"></asp:TableCell>
                            </asp:TableRow>

                        </asp:Table>
                        <br />
                        <asp:Label runat="server" CssClass="panel-title" meta:resourcekey="entregas"></asp:Label>
                        <asp:GridView ID="fileList" runat="server" GridLines="Horizontal" ItemType="Ubilingua.Models.joinusermarks" SelectMethod="GetElements" AutoGenerateColumns="false" CssClass="table table-responsive">
                            <Columns>
                                <asp:TemplateField meta:resourcekey="nombre">
                                    <ItemTemplate>
                                        <%#:Item.User %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField meta:resourcekey="fecha2">
                                    <ItemTemplate>
                                        <%#:Item.Delivered %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField meta:resourcekey="archivo">
                                    <ItemTemplate>
                                        <a href="Subject/<%#:subjectID %>/Tasks/<%#:id %>/<%#:Item.FilePath %>" download><%#:Item.FilePath %></a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField meta:resourcekey="calif">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" id="mark" Text="<%#:Item.Mark %>" ></asp:TextBox>
                                        <asp:RangeValidator runat="server" ControlToValidate="mark" MinimumValue="0" MaximumValue="10" Type="Double" meta:resourcekey="validCalif"></asp:RangeValidator>
                                        <asp:HiddenField runat="server" ID="userid" Value="<%#:Item.UserID %>" />
                                        <asp:HiddenField runat="server" ID="resourceid" Value="<%#:Item.ResourceID %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                            </Columns>
                        </asp:GridView>
                        <asp:Button runat="server" ID="SaveMarksButton" CssClass="panel-button" meta:resourcekey="guardar" OnClick="SaveMarks"/>
                    </ContentTemplate>
                </asp:RoleGroup>
                <asp:RoleGroup Roles="Alumno">
                    <ContentTemplate>
                        <asp:Table runat="server" CssClass="table-bordered" BorderStyle="Solid" BorderWidth="0.5">

                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th" meta:resourcekey="fecha"></asp:TableHeaderCell>
                                <asp:TableCell ID="date" CssClass="td"></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th" meta:resourcekey="tiempo"></asp:TableHeaderCell>
                                <asp:TableCell ID="leftTime" CssClass="td"></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th" meta:resourcekey="estado"></asp:TableHeaderCell>
                                <asp:TableCell CssClass="td" ID="status">Sin entregar</asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th" meta:resourcekey="archivo2"></asp:TableHeaderCell>
                                <asp:TableCell CssClass="td" ID="file"> - </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th" meta:resourcekey="subir"></asp:TableHeaderCell>
                                <asp:TableCell CssClass="td" ID="uploadCell">
                                    <asp:FileUpload runat="server" ID="fileUpload" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server">
                                <asp:TableHeaderCell CssClass="th" meta:resourcekey="calif2"></asp:TableHeaderCell>
                                <asp:TableCell ID="mark" CssClass="td">-</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <br />
                        <asp:Button runat="server" meta:resourcekey="subir" OnClick="Upload_Click" ID="uploadButton" CssClass="panel-button" />
                        <asp:Label runat="server" ID="warning" meta:resourcekey="warning"></asp:Label>
                    </ContentTemplate>
                </asp:RoleGroup>
            </RoleGroups>
        </asp:LoginView>
    </asp:Panel>
</asp:Content>
