<%@ Page Title="" Language="C#" MasterPageFile="~/Sistec-V.2.0.master" AutoEventWireup="true" CodeFile="Formulario.aspx.cs" Inherits="Cadastros_CategoriaServicos_Formulario" %>
<%@ Register Src="~/Cadastros/CategoriaServicos/Componentes/Cabecalho.ascx" TagPrefix="uc1" TagName="Cabecalho" %>
<%@ Register Src="~/Cadastros/CategoriaServicos/Componentes/Menu.ascx" TagPrefix="uc1" TagName="Menu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <uc1:Cabecalho runat="server" ID="Cabecalho" />
    <uc1:Menu runat="server" ID="Menu" />
    
    <asp:HiddenField ID="hfdidCategoriaServicos" Value="0" runat="server" ClientIDMode="Static" />

    <div id="formulario">
        <div class="row">
            <div class="col-12">
                <asp:ImageButton ID="btnNew" runat="server" AlternateText="Novo" BorderWidth="0px" CausesValidation="False" 
                    ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/new.png" ToolTip="Novo" Visible="false" OnClick="btnNew_Click" />
                <asp:ImageButton ID="btnSave" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save.png"
                    ToolTip="Salvar" OnClick="btnSave_Click" Visible="false" ValidationGroup="CategoriaServicos" />
                <asp:ImageButton ID="btnEdit" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/edit.png"
                    ToolTip="Editar" Visible="false" OnClick="btnEdit_Click" />
                <asp:ImageButton ID="btnDelete" runat="server" BorderWidth="0px" OnClientClick="return confirm('Deletar Categoria de Serviços?');"
                    ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/exclude.png" ToolTip="Deletar" Visible="false" OnClick="btnDelete_Click" />
                <asp:ImageButton ID="btnCancel" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/cancel.png" 
                    ToolTip="Cancelar" CausesValidation="false" Visible="false" OnClick="btnCancel_Click" />
                <asp:ImageButton ID="btnHelp" runat="server" BorderWidth="0px"
                    ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/help.png"  ToolTip="Ajuda" CausesValidation="False" Visible="false" OnClick="btnHelp_Click " 
                    OnClientClick="javascript: window.open('../../Manual/index.htm')" />
                
            </div>
        </div>
        </div>

      <div class="row">

           <div class="form-group col-md-4">
                    <label>Linha</label>
                    <asp:DropDownList ID="ddlLinha" CssClass="form-control required"  AutoPostBack="true" runat="server" ViewStateMode="Enabled"></asp:DropDownList>
             
                </div>
                

          <div class="form-group col-md-3">
                
                    <label for="txbcodDN">Código DN</label>
                    <asp:TextBox ID="txbcodDN" runat="server" CssClass="Categoria form-control mask-int2 required" onchange="CategoriaServicos.ValidarCategoria();"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvcodDN" runat="server" ControlToValidate="txbcodDN" />
                         
                
          </div>

           <div class="col-md-4">
                <div class="form-group">
                    <label for="txbcodSgt">Código SGT</label>
                    <asp:TextBox ID="txbcodSgt" runat="server" CssClass="Categoria form-control mask-int2 required" onchange="CategoriaServicos.ValidarCategoria();"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfvcodSgt" runat="server" ControlToValidate="txbcodSgt" />
                        
                </div>
          </div>

          
          <div class="col-11">
                <div class="form-group">
                    <label for="txbcategoria">Nome da Categoria</label>
                    <asp:TextBox ID="txbcategoria" runat="server" CssClass="categoria form-control required" onchange="CategoriaServicos.Validarcategoria();"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvcategoria" runat="server" ControlToValidate="txbcategoria"
                        ErrorMessage="Campo obrigatório." Text="Campo obrigatório." ValidationGroup="CategoriaServicos" CssClass="balao" />

                </div>
            </div>       
       </div>
               
</asp:Content>
   
<asp:Content ID="Content3" ContentPlaceHolderID="scripts" Runat="Server">
</asp:Content>

