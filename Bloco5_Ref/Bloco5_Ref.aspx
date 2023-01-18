<%@ Page Language="vb" AutoEventWireup="false" CodeFile="Bloco5_Ref.aspx.vb" Inherits="Bloco5_Ref" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />  
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
            Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
            WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt"  
            Width="1330px" Height="1200px" ShowPrintButton="True">
            <LocalReport ReportPath="Relatorios\Bloco5_Ref\Relatorio_Bloco5.rdlc">
               
            </LocalReport>
        </rsweb:ReportViewer>
    
    </div>
    <asp:Label ID="Label1" runat="server"></asp:Label>
    </form>
</body>
</html>
