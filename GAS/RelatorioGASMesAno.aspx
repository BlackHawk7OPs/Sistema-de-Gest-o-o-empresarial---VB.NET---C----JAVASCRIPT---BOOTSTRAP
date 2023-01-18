<%@ Page Title="" Language="VB" MasterPageFile="~/Relatorio.master" AutoEventWireup="false" CodeFile="RelatorioGASMesAno.aspx.vb" Inherits="Relatorios_GAS_RelatorioGASMesAno" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" Namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadRelatorio" Runat="Server">
    <style type="text/css">
        .conteudoGeral {
            margin-left: 50%;
            left: -10.5cm;
            width: 21cm;
        }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentRelatorio" Runat="Server">
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" 
        Height="100%" AsyncRendering="false" ShowPrintButton="False" BackColor="White" ShowRefreshButton="False" ShowZoomControl="False">
        <LocalReport ReportPath="Relatorios\GAS\RelatorioGASMesAno.rdlc">
        </LocalReport>
    </rsweb:ReportViewer>
</asp:Content>

