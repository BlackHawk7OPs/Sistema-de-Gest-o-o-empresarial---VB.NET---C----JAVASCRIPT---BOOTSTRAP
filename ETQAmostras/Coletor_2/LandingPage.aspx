<%@ Page Language="vb" MasterPageFile="~/Sistec-V.2.0.master" AutoEventWireup="false"
    CodeFile="LandingPage.aspx.vb" Inherits="LandingPage" %>

<%@ Register Src="../../FiltroETQ.ascx" TagName="FiltroETQ" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../funcoes.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        <h3>Coletor</h3>
    <hr />
    <br />
    <br />

    <br />

<h4>Filtros</h4>
            
            
                <br />
               <div class="row">
                <div class="col-md-4 col-md-4">
                           <%-- <label>Último nº Usado:</label>--%>

                            <asp:TextBox ID="TextBoxUltimo" CssClass="form-control" visible="false" runat="server" />
                    </div>
                        </div>
                    <div class="row">
                <div class="col-md-4 col-md-4">
                         <label>Número Inicial:</label>
                        
                        
                            <asp:TextBox ID="TextBoxInicio" runat="server" CssClass="form-control" />
                            <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="TextBoxInicio"
                                Mask="999999999" MessageValidatorTip="true" OnInvalidCssClass="MaskedEditError"
                                OnFocusCssClass="MaskedEditFocus" MaskType="Number" InputDirection="RightToLeft"
                                ErrorTooltipEnabled="True" />
                        </div>
                        
                    
                        </div>
                       <div class="row">
                <div class="col-md-4 col-md-4">
                            <label>Número Final:</label>
                       
                        
                            <asp:TextBox ID="TextBoxFim" runat="server" CssClass="form-control" />
                            <asp:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="TextBoxFim"
                                Mask="999999999" MessageValidatorTip="true" OnInvalidCssClass="MaskedEditError"
                                OnFocusCssClass="MaskedEditFocus" MaskType="Number" InputDirection="RightToLeft"
                                ErrorTooltipEnabled="True" />
                       </div>
                           </div>
             <div class="row">
                    <div class="col-md-4 col-md-2">
                            <label>Etiqueta Inicial para Impressão (De cima para baixo):</label>                      
                            <asp:TextBox ID="TextBoxETQ" runat="server" CssClass="form-control" />                   
                    </div>
                 </div>
                    <div class="row">
                  <div class="col-md-2 col-md-4">                            
                            <asp:Button ID="btnOK" runat="server" OnClick="btnOk_Click" CssClass="btn btn-primary" Text="Exibir Etiqueta" />                   
                          <asp:Button ID="btnCancelar" runat="server" CssClass="btn btn-light" Visible="false" OnClick="btnCancelar_Click" Text="Cancelar" />
                        </div>
                        </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
