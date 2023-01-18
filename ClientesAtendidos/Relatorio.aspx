<%@ Page Title="Relatório de Clientes Atendidos" Language="VB" MasterPageFile="~/Relatorio.master" AutoEventWireup="false" CodeFile="Relatorio.aspx.vb" Inherits="Relatorios_ClientesAtendidos_Relatorio" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadRelatorio" Runat="Server">
    <style type="text/css">
        .conteudoGeral {
            width: 29.7cm;
            margin-left: 50%;
            left: -14.85cm;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentRelatorio" Runat="Server">
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" 
        Height="100%" AsyncRendering="false" ProcessingMode="Local" SizeToReportContent="False" DocumentMapWidth="100%"
        ShowPrintButton="False" BackColor="White" ShowRefreshButton="False" ShowZoomControl="False">
        <LocalReport ReportPath="Relatorios\ClientesAtendidos\Relatorio.rdlc">
        </LocalReport>
    </rsweb:ReportViewer>
</asp:Content>

