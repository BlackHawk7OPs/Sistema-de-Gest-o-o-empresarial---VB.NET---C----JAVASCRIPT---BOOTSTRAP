<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Menu.ascx.cs" Inherits="Cadastros_ProdutoNacional_Componentes_Menu" %>

<div class="row mt-4 mb-0">
    <div class="col-12">
       
         <asp:LinkButton ID="btn_cadastrarProduto" runat="server" CssClass="btn btn-primary btn-menu" CausesValidation="False" OnClick="btn_cadastrarProduto_Click"> 
            <i class="glyphicon glyphicon-pencil" title="Cadastro"></i>&nbsp;&nbsp;Cadastrar Produto Nacional
        </asp:LinkButton>

        <asp:LinkButton ID="btn_produtoNacional" runat="server" CssClass="btn btn-primary btn-menu" CausesValidation="False" PostBackUrl="~/Cadastros/ProdutoNacional/Default.aspx"> 
            <i class="glyphicon glyphicon-th-list" title="Detalhar"></i>&nbsp;&nbsp;Consulta/Listagem
        </asp:LinkButton>

        <hr class="div-content-3" /> 
    </div>
</div>