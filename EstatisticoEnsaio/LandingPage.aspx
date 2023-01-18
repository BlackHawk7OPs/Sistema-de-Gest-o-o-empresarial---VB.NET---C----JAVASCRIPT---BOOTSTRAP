<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="LandingPage.aspx.vb" Inherits="Relatorios_EstatisticoEnsaio_LandingPage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../funcoes.js" type="text/javascript"></script>
    <style type="text/css">
        .style1
        {
            width: 837px;
        }
        .style2
        {
            width: 270px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <table width="100%" border="0" cellspacing="0" cellpadding="3"><tr><td class="style1"><span class="conteudo_interno_titulo">
        Estatístico de Ensaio</span></td></tr><tr><td><img height="1" src="../../App_Themes/SISTEC_WEB_THEME/imagens/line_01.gif" 
        width="90%" /></td></tr></table>

    <br />

    <table width="100%" border="0" cellspacing="0" cellpadding="3"><tr><td class="style1">
        <span class="conteudo_interno_subtitulo">Selecione o intervalo para o relatório</span></table>

    <br />

    <asp:Panel ID="pnlFiltro" runat="server" GroupingText="Filtos" Width="862px" 
        Visible="False">
        <br />
        <table cellpadding="2" border="0">
            <tr>
                <td class="style1">
                    <asp:RadioButton ID="rdbTodos" Text="Todos" GroupName="TipoFiltro" CssClass="radio" Checked="true" runat="server" />
                    <br />
                    <asp:RadioButton ID="rdbLista" Text="Apenas os listados abaixo" GroupName="TipoFiltro" CssClass="radio" runat="server" />
                    <br /><br />
                    <asp:Panel ID="pnlGrid" runat="server" ScrollBars="Vertical" Width="845px" 
                        Height="250px">
                        <asp:GridView ID="grvLista" Height="250px" Width="835px" runat="server" />
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </asp:Panel>

    <br /><br />

    <asp:Panel ID="pnlOrdenacao" runat="server" GroupingText="Ordem do relatório" 
        Width="550" Visible="False">
        <table width="100%">
            <tr>
                <td width="33%"><asp:RadioButton ID="rdbQuantidade" Text="Quantidade" GroupName="Ordenacao" Checked="true" CssClass="radio" runat="server" /></td>
                <td width="33%"><asp:RadioButton ID="rdbNomeEnsaio" Text="Nome do Ensaio" GroupName="Ordenacao" CssClass="radio" runat="server" /></td>
                <td width="33%"><asp:RadioButton ID="rdbCodigoEnsaio" Text="Código do Ensaio" GroupName="Ordenacao" CssClass="radio" runat="server" /></td>
            </tr>
        </table>
    </asp:Panel>

    <table cellpadding="5" width="550">
        <tr>
            <td align="center" class="style2"><b>Início</b></td>
            <td align="center"><b>Término</b></td>
        </tr>
        <tr>
            <td align="center" class="style2"><asp:Calendar ID="cldDataInicial" runat="server"></asp:Calendar>
                <br />
            </td>
            <td align="center"><asp:Calendar ID="cldDataFinal" runat="server"></asp:Calendar></td>
        <script type="text/javascript" language="javascript">
            function onCalendarShown(sender, args) {
                sender._switchMode("years", true);
            }
            </script>
        </tr>
        <tr>
            <td align="center">
                <asp:TextBox ID="txtInicio" runat="server" Text='' AutoPostBack="True" 
                    Width="160px" />
                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtInicio" Format="dd/MM/yyyy" OnClientShown="onCalendarShown" />
           </td>
            <td align="center">
                <asp:TextBox ID="txtFim" runat="server" Text='' AutoPostBack="True" 
                    Width="160px" />
                <cc1:CalendarExtender ID="txtFim_CalendarExtender" runat="server" 
                    TargetControlID="txtFim" Format="dd/MM/yyyy" 
                    OnClientShown="onCalendarShown" /></td>
        </tr>
        <tr><td colspan="2"><br /><br /></td></tr>
        <tr>
            <td colspan="2"><asp:Button ID="btnEnviar" OnClick="btnEnviar_Click" Text="Exibir Relatório" runat="server" /></td>
        </tr>
    </table>

</asp:Content>

