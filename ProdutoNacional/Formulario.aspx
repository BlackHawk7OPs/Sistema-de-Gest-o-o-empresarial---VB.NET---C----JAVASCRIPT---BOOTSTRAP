<%@ Page Title="" Language="C#" MasterPageFile="~/Sistec-V.2.0.master" AutoEventWireup="true" CodeFile="Formulario.aspx.cs" Inherits="Cadastros_ProdutoNacional_Formulario" %>
<%@ Register Src="~/Cadastros/ProdutoNacional/Componentes/Cabecalho.ascx" TagPrefix="uc1" TagName="Cabecalho" %>
<%@ Register Src="~/Cadastros/ProdutoNacional/Componentes/Menu.ascx" TagPrefix="uc1" TagName="Menu" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <uc1:Cabecalho runat="server" ID="Cabecalho" />
    <uc1:Menu runat="server" ID="Menu" />
    
    <asp:HiddenField ID="hfdidProdutoNacional" Value="0" runat="server" ClientIDMode="Static" />

 <div id="formulario">
        <div class="row">
            <div class="col-12">
                <asp:ImageButton ID="btnNew" runat="server" AlternateText="Novo" BorderWidth="0px" CausesValidation="False" 
                    ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/new.png" ToolTip="Novo" Visible="false" OnClick="btnNew_Click" />
                <asp:ImageButton ID="btnSave" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save.png"
                    ToolTip="Salvar" OnClick="btnSave_Click" Visible="false" ValidationGroup="ProdutoNacional" />
                <asp:ImageButton ID="btnEdit" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/edit.png"
                    ToolTip="Editar" Visible="false" OnClick="btnEdit_Click" />
                <asp:ImageButton ID="btnDelete" runat="server" BorderWidth="0px" OnClientClick="return confirm('Deletar Produto Nacional?');"
                    ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/exclude.png" ToolTip="Deletar" Visible="false" OnClick="btnDelete_Click" />
                <asp:ImageButton ID="btnCancel" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/cancel.png" 
                    ToolTip="Cancelar" CausesValidation="false" Visible="false" OnClick="btnCancel_Click" />
                <asp:ImageButton ID="btnHelp" runat="server" BorderWidth="0px"
                    ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/help.png" ToolTip="Ajuda" CausesValidation="False" Visible="false" OnClick="btnHelp_Click" 
                    OnClientClick="javascript: window.open('../../Manual/index.htm')" />    
            </div>
        </div>


     <div class="row">

         <div class="form-group col-md-4">
                    <label>Categoria</label>
                    <asp:DropDownList ID="ddlCategoria" CssClass="form-control required"  AutoPostBack="true" runat="server" ViewStateMode="Enabled"></asp:DropDownList>
              <asp:RequiredFieldValidator ID="rfvddlCategoria" runat="server" ControlToValidate="ddlCategoria"
                        ErrorMessage="Campo obrigatório." Text="Campo obrigatório." ValidationGroup="ProdutoNacional" CssClass="balao" />
                </div>

           
          <div class="col-4">
                <div class="form-group">
                    <label for="txbcodSGT">Código SGT</label>
                    <asp:TextBox ID="txbcodSGT" runat="server" CssClass="Produto form-control mask-int2 required " onchange="ProdutoNacional.ValidarProduto();"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfvcodSGT" runat="server" ControlToValidate="txbcodSGT"
                        />
                   
                </div>
          </div>

          <div class="col-sm-3">
                <div class="form-group">
                    <label for="txbcodDN">Código DN</label>
                    <asp:TextBox ID="txbcodDN" runat="server" CssClass="Produto form-control mask-int2 required " onchange="ProdutoNacional.ValidarProduto();"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfvcodDN" runat="server" ControlToValidate="txbcodDN"
                         />
                </div>
          </div>

         <div class="col-sm-11">
                <div class="form-group">
                    <label for="txbprodutoNacional">Nome do Produto Nacional</label>
                    <asp:TextBox ID="txbprodutoNacional" runat="server" CssClass="Produto form-control required" onchange="ProdutoNacional.ValidarProduto();"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvprodutoNacional" runat="server" ControlToValidate="txbprodutoNacional"
                        ErrorMessage="Campo obrigatório." Text="Campo obrigatório." ValidationGroup="ProdutoNacional" CssClass="balao" />                        

                </div>

          </div>

       </div>          
  </div>  
     
</asp:Content>
   
<asp:Content ID="Content3" ContentPlaceHolderID="scripts" Runat="Server">
</asp:Content>

