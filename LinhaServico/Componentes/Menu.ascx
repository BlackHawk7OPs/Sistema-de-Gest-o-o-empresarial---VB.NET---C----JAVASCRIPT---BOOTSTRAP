<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Menu.ascx.cs" Inherits="Cadastros_LinhaServicos_Componentes_Menu" %>

<div class="row mt-4 mb-0">
    <div class="col-12">
       
         <asp:LinkButton ID="btn_cadastrarLinha" runat="server" CssClass="btn btn-primary btn-menu" CausesValidation="False" OnClick="btn_cadastrarLinha_Click"> 
            <i class="glyphicon glyphicon-pencil" title="Cadastro"></i>&nbsp;&nbsp;Cadastrar Linha de Serviço
        </asp:LinkButton>

        <asp:LinkButton ID="btn_listaServicos" runat="server" CssClass="btn btn-primary btn-menu" CausesValidation="False" PostBackUrl="~/Cadastros/LinhaServico/Default.aspx"> 
            <i class="glyphicon glyphicon-th-list" title="Detalhar"></i>&nbsp;&nbsp;Listagem/Busca
        </asp:LinkButton>

        <hr class="div-content-3" /> 
    </div>
</div>