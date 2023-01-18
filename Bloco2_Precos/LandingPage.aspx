<%@ Page Language="vb" MasterPageFile="~/Sistec-V.2.0.master" AutoEventWireup="false" CodeFile="LandingPage.aspx.vb" Inherits="LandingPage" %>
<%@ Register src="../FiltroBloco.ascx" tagname="FiltroBloco" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../funcoes.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">

    <h3>Bloco 2 - Preços</h3>
    <hr />
    
    <br/>
    <br />

    
        <h5>Selecione o intervalo para o relatório</h5>
        <hr/>
        
    
    <br />
    <asp:FiltroBloco ID="FiltroBloco" OnAbrirRelatorio="FiltroBloco_AbrirRelatorio"  width="100%" runat="server" />
</asp:Content>