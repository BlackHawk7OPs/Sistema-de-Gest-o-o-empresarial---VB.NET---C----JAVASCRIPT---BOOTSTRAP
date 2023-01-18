<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Menu.ascx.cs" Inherits="Cadastros_CategoriaServicos_Componentes_Menu" %>

<div class="row mt-4 mb-0">
    <div class="col-12">
       
         <asp:LinkButton ID="btn_cadastrarCategoria" runat="server" CssClass="btn btn-primary btn-menu" CausesValidation="False" OnClick="btn_cadastrarCategoria_Click"> 
            <i class="glyphicon glyphicon-pencil" title="Cadastro"></i>&nbsp;&nbsp;Cadastrar Categoria de Serviços
        </asp:LinkButton>

        <asp:LinkButton ID="btn_categoria" runat="server" CssClass="btn btn-primary btn-menu" CausesValidation="False" PostBackUrl="~/Cadastros/CategoriaServicos/Default.aspx"> 
            <i class="glyphicon glyphicon-th-list" title="Detalhar"></i>&nbsp;&nbsp;Consulta/Listagem
        </asp:LinkButton>

        <hr class="div-content-3" /> 
    </div>
</div>