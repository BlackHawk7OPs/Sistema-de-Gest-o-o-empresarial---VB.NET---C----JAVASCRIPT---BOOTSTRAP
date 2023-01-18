 <%@ Page Title="" Language="C#" MasterPageFile="~/Sistec-V.2.0.master" AutoEventWireup="true" CodeFile="Formulario.aspx.cs" Inherits="Cadastros_LinhaServicos_Formulario" %>

<%@ Register Src="~/Cadastros/LinhaServico/Componentes/Cabecalho.ascx" TagPrefix="uc1" TagName="Cabecalho" %>
<%@ Register Src="~/Cadastros/LinhaServico/Componentes/Menu.ascx" TagPrefix="uc1" TagName="Menu" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <uc1:Cabecalho runat="server" ID="Cabecalho" />
    <uc1:Menu runat="server" ID="Menu" />
    
    <asp:HiddenField ID="hfdidLinhaServicos" Value="0" runat="server" ClientIDMode="Static" />

    <div id="formulario">
        <div class="row">
            <div class="col-12">
                <asp:ImageButton ID="btnNew" runat="server" AlternateText="Novo" BorderWidth="0px" CausesValidation="False" 
                    ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/new.png" ToolTip="Novo" Visible="false" OnClick="btnNew_Click" />
                <asp:ImageButton ID="btnSave" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save.png"
                    ToolTip="Salvar" OnClick="btnSave_Click" Visible="false" ValidationGroup="LinhaServicos" />
                <asp:ImageButton ID="btnEdit" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/edit.png"
                    ToolTip="Editar" Visible="false" OnClick="btnEdit_Click" />
                <asp:ImageButton ID="btnDelete" runat="server" BorderWidth="0px" OnClientClick="return confirm('Deletar Linha de Serviços?');"
                    ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/exclude.png" ToolTip="Deletar" Visible="false" OnClick="btnDelete_Click" />
                <asp:ImageButton ID="btnCancel" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/cancel.png" 
                    ToolTip="Cancelar" CausesValidation="false" Visible="false" OnClick="btnCancel_Click" />
                <asp:ImageButton ID="btnHelp" runat="server" BorderWidth="0px"
                    ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/help.png" ToolTip="Ajuda" CausesValidation="False" Visible="false" OnClick="btnHelp_Click" 
                    OnClientClick="javascript: window.open('../../Manual/index.htm') " />

                
            </div>
        </div>


        <div class="row">
            <div class="col-11">
                <div class="form-group">
                    <label for="txblinha">Nome da Linha</label>
                    <asp:TextBox ID="txblinha" runat="server" CssClass="Linha form-control required" onchange="LinhaServicos.ValidarLinha();"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvlinha" runat="server" ControlToValidate="txblinha"
                        ErrorMessage="Campo obrigatório." Text="Campo obrigatório." ValidationGroup="LinhaServicos" CssClass="balao" />
                </div>

            </div>


          <div class="col-4">
                <div class="form-group">
                    <label for="txbcodDN">Código DN</label>
                    <asp:TextBox ID="txbcodDN" runat="server" CssClass="Linha form-control mask-int2" onchange="LinhaServicos.ValidarLinha();"></asp:TextBox>
                   
                </div>
          </div>

            <div class="col-4">
                <div class="form-group">
                    <label for="txbcodSgt">Código SGT</label>
                    <asp:TextBox ID="txbcodSgt" runat="server" CssClass="Linha form-control mask-int2" onchange="LinhaServicos.ValidarLinha();"></asp:TextBox>
                    
                </div>
          </div>

             <div class="col-3">
                <div class="form-group">
                    <label for="txbcodProdERP">Código do Produto ERP</label>
                    <asp:TextBox ID="txbcodProdERP" runat="server" CssClass="Linha form-control required" onchange="LinhaServicos.ValidarLinha();"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvcodProdERP" runat="server" ControlToValidate="txbcodProdERP"
                        ErrorMessage="Campo obrigatório." Text="Campo obrigatório." ValidationGroup="LinhaServicos" CssClass="balao" />
                </div>
          </div>

             <div class="col-4">
                <div class="form-group">
                    <label for="txbcontaContabil">Conta Contabil</label>
                    <asp:TextBox ID="txbcontaContabil" runat="server" CssClass="Linha form-control required" onchange="LinhaServicos.ValidarLinha();"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvcontaContabil" runat="server" ControlToValidate="txbcontaContabil"
                        ErrorMessage="Campo obrigatório." Text="Campo obrigatório." ValidationGroup="LinhaServicos" CssClass="balao" />
                </div>
          </div>

            <div class="col-4">
                <div class="form-group">
                    <label for="txbordemValor"> Ordem Valor</label>
                    <asp:TextBox ID="txbordemValor" runat="server" CssClass="Linha form-control mask-int2" onchange="LinhaServicos.ValidarLinha();"></asp:TextBox>
                    
                </div>
          </div>
           
        </div>

    </div>
    
</asp:Content>
   
<asp:Content ID="Content3" ContentPlaceHolderID="scripts" Runat="Server">
</asp:Content>

