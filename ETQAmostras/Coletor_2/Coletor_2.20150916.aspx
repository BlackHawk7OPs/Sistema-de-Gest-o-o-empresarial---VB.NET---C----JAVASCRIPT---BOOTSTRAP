<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Coletor_2.aspx.vb" Inherits="Coletor_2" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" EnableScriptGlobalization="True" runat="server" />
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
            Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
            WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" 
            Width="193.9mm" Height="256.9972mm" ShowPrintButton="True">
            <LocalReport ReportPath="Relatorios\ETQAmostras\Coletor_2\Relatorio_Coletor.rdlc">
            </LocalReport>
        </rsweb:ReportViewer>
    </form>
    </div>
</body>
</html>