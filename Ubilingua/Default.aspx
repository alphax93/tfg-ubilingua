<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Ubilingua._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <section>
        <br />
        <div>

            <asp:ListView ID="ListView1" runat="server" DataKeyNames="SubjectID" GroupItemCount="3" ItemType="Ubilingua.Models.subjects" SelectMethod="GetSubjects">
                <EmptyDataTemplate>
                    <table>
                        <tr>
                            <td><asp:Label runat="server" Text="No hay ningún curso disponible"></asp:Label></td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <EmptyItemTemplate></td></EmptyItemTemplate>
                <GroupTemplate>
                    <tr id="itemPlaceholderContainer" runat="server">
                        <td id="itemPlaceholder" runat="server"></td>
                    </tr>
                </GroupTemplate>
                <ItemTemplate>
                    <td runat="server">
                        <table style="width: 100%;" class="table">
                            <tr>
                                <td align="center">
                                    <asp:Panel CssClass="panel-subject" runat="server">
                                        <br />

                                        <a href="Subject.aspx?subjectID=<%#:Item.SubjectID %>">
                                            <img src="Subjects/Images/<%#:Item.ImagePath %>" width="250" height="150" class="img-responsive" />
                                        </a>
                                        <br />
                                        <a href="Subject.aspx?subjectID=<%#:Item.SubjectID %>" class="panel-title">
                                            <p style="font-variant-caps: all-small-caps"><%#:Item.SubjectName %></p>
                                        </a>

                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        </table>

                    </td>
                </ItemTemplate>
                <LayoutTemplate>
                    <table style="width: 100%;">
                        <tbody>
                            <tr>
                                <td>
                                    <table id="groupPlaceholderContainer" runat="server" style="width: 100%;">
                                        <tr id="groupPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                            </tr>
                            <tr></tr>
                        </tbody>
                    </table>
                </LayoutTemplate>
            </asp:ListView>

        </div>
    </section>
    <section>
        <asp:LoginView runat="server">
            <RoleGroups>
                <asp:RoleGroup Roles="Profesor">
                    <ContentTemplate>
                        
                                    <a href="CreateSubject.aspx" class="panel-title" >
                                        <asp:Panel CssClass="panel-subject" runat="server" HorizontalAlign="Center" >
                                        <h1>+</h1>
                                            <p  style="font-variant-caps: all-small-caps">CREAR NUEVO CURSO</p>

                                    </asp:Panel>
                                        </a>
                                
                    </ContentTemplate>
                </asp:RoleGroup>
            </RoleGroups>
        </asp:LoginView>

    </section>

</asp:Content>
