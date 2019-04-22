<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="adminPanel.aspx.cs" Inherits="Ubilingua.adminPanel" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:Panel runat="server" CssClass="panel">
        <asp:Label runat="server" CssClass="h2" meta:resourcekey="title"></asp:Label>
            <asp:Button runat="server" meta:resourcekey="desc" CssClass="btn" OnClick="Backup" />
        <br /><br />
        
        <asp:Label ID="tittle" runat="server" meta:resourcekey="prof" CssClass="h3"></asp:Label>
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
                            <asp:Button runat="server" OnCommand="DeleteUser" meta:resourcekey="elim" CommandArgument="<%# Item.Id %>" CssClass="btn"/>
                            <asp:Button runat="server" OnCommand="ChangeToStudent" meta:resourcekey="convAAlum" CommandArgument="<%# Item.Id %>" CssClass="btn"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                </Columns>
            </asp:GridView>
        <br /><br />
        <asp:Label ID="tittleStudent" runat="server" meta:resourcekey="alum" CssClass="h3"></asp:Label>
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
                            <asp:Button runat="server" OnCommand="DeleteUser" meta:resourcekey="elim" CommandArgument="<%# Item.Id %>" CssClass="btn"/>
                            <asp:Button runat="server" OnCommand="ChangeToTeacher" meta:resourcekey="convAProf" CommandArgument="<%# Item.Id %>" CssClass="btn"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                </Columns>
            </asp:GridView>
    </asp:Panel>
</asp:Content>
