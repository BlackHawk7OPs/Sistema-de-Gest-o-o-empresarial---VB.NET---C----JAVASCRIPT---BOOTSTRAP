<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="Relatorios_ClientesAtendidos_Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../funcoes.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="3">
       <tr>
           <td class="style1">
               <span class="conteudo_interno_titulo">Relatórios Clientes Atendidos</span>
               <hr class="linhaHorizontal" />
           </td>
        </tr>
   </table>

    <table cellpadding="5">
        <tr>
            <td valign="middle" style="width: 100px"><b>Instituição: </b></td>
            <td>
                <asp:DropDownList ID="ddlInstituicao" runat="server" AppendDataBoundItems="True"
                    Font-Size="9pt" Width="150px" Enabled="True">
                    <asp:ListItem Value="0" Text="" Enabled="false"></asp:ListItem>
                    <asp:ListItem Value="1" Text="CETEC" Enabled="false"></asp:ListItem>
                    <asp:ListItem Value="2" Text="SENAI" Selected="True"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td valign="middle"><b>Area: </b></td>
            <td>
                <asp:DropDownList ID="ddlSetor" runat="server" Width="400px" Font-Size="9pt" 
                    DataSourceID="SqlSetor" DataTextField="gerencia" DataValueField="id" 
                    AppendDataBoundItems="True">
                    <asp:ListItem Value="0" Text="CIT"></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlSetor" runat="server" 
                  SelectCommand="SELECT id, nomeSetorSenai AS gerencia FROM Unidades WHERE codSatt IS NOT NULL AND (ativo = @ativo) AND campus = 0">
                  <SelectParameters>
                      <asp:Parameter DefaultValue="S" Name="ativo" Type="String" />
                  </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td valign="middle"><b>Ano: </b></td>
            <td>
                <asp:DropDownList ID="ddlAno" runat="server" AppendDataBoundItems="True"
                    Font-Size="9pt" Width="150px" Enabled="True">
                    <asp:ListItem Value="" Text=""></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>

    <table cellpadding="5">
        <tr>
            <td>
                <br /><br />
                <asp:Button ID="btnEnviar" Text="Exibir Relatório" runat="server" />
            </td>
        </tr>
    </table>

</asp:Content>

