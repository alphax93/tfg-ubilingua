<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="adminPanel.aspx.cs" Inherits="Ubilingua.adminPanel" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:Panel runat="server" CssClass="panel">
        <h2>Panel de administración</h2>
            <asp:Button runat="server" Text="Crear copia de seguridad" CssClass="btn" OnClick="Backup" />
        <br /><br />
        
        <asp:Label ID="tittle" runat="server" Text="Profesores" CssClass="h3"></asp:Label>
            <asp:GridView runat="server" id="teacherGrid" ItemType="Ubilingua.Models.ApplicationUser" SelectMethod="ViewTeachers" GridLines="Horizontal" AutoGenerateColumns="false" DeleteMethod="DeleteUser">
                <Columns>
                    <asp:TemplateField HeaderText="ID">
                        <ItemTemplate>
                            <%#Item.Id %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Nombre">
                        <ItemTemplate>
                            <%#Item.Name + " " + Item.Surname1 + " " + Item.Surname2 %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Correo electrónico">
                        <ItemTemplate>
                            <%#Item.Email %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button runat="server" OnCommand="DeleteUser" Text="Eliminar usuario" CommandArgument="<%# Item.Id %>" OnClientClick="if (!confirm('¿Está seguro de que desea borrar?')) return false;" CssClass="btn"/>
                            <asp:Button runat="server" OnCommand="ChangeToStudent" Text="Convertir en alumno" CommandArgument="<%# Item.Id %>" OnClientClick="if (!confirm('¿Está seguro de que desea convertir al usuario en alumno?')) return false;" CssClass="btn"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                </Columns>
            </asp:GridView>
        <br /><br />
        <asp:Label ID="tittleStudent" runat="server" Text="Alumnos" CssClass="h3"></asp:Label>
            <asp:GridView runat="server" id="studentGrid" ItemType="Ubilingua.Models.ApplicationUser" SelectMethod="ViewStudents" GridLines="Horizontal" AutoGenerateColumns="false" DeleteMethod="DeleteUser">
                <Columns>
                    <asp:TemplateField HeaderText="ID">
                        <ItemTemplate>
                            <%#Item.Id %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Nombre">
                        <ItemTemplate>
                            <%#Item.Name + " " + Item.Surname1 + " " + Item.Surname2 %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Correo electrónico">
                        <ItemTemplate>
                            <%#Item.Email %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button runat="server" OnCommand="DeleteUser" Text="Eliminar usuario" CommandArgument="<%# Item.Id %>" OnClientClick="if (!confirm('¿Está seguro de que desea borrar?')) return false;" CssClass="btn"/>
                            <asp:Button runat="server" OnCommand="ChangeToTeacher" Text="Convertir en profesor" CommandArgument="<%# Item.Id %>" OnClientClick="if (!confirm('¿Está seguro de que desea convertir al usuario en profesor?')) return false;" CssClass="btn"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                </Columns>
            </asp:GridView>
    </asp:Panel>
</asp:Content>
