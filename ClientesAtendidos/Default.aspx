<%@ Page Title="" Language="VB" MasterPageFile="~/Sistec-V.2.0.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="Relatorios_ClientesAtendidos_Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../funcoes.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
   <h3>Relatórios Clientes Atendidos</h3>
    <hr />
    <br />
    <br />

    <br />

     <div class="row">
        <div class="col-md-3 col-md-3">
         <label>Instituição:</label>
           
                <asp:DropDownList ID="ddlInstituicao"  CssClass="form-control" runat="server" AppendDataBoundItems="True"
                    Font-Size="9pt" Width="150px" Enabled="True">
                    <asp:ListItem Value="0" Text="" Enabled="false"></asp:ListItem>
                    <asp:ListItem Value="1" Text="CETEC" Enabled="false"></asp:ListItem>
                    <asp:ListItem Value="2" Text="SENAI" Selected="True"></asp:ListItem>
                </asp:DropDownList>
          </div>
         </div>
        <div class="row">
        <div class="col-md-6 col-md-6">
         <label>Área:</label>
                <asp:DropDownList ID="ddlSetor" runat="server" CssClass="form-control" Font-Size="9pt" 
                    DataSourceID="SqlSetor" DataTextField="gerencia" DataValueField="siglaSetorSenai" 
                    AppendDataBoundItems="True">
                    <asp:ListItem Value="0" Text="CIT"></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlSetor" runat="server" 
                  SelectCommand="SELECT id, siglaSetorSenai, nomeSetorSenai AS gerencia FROM Unidades WHERE siglaSetorSenai IS NOT NULL AND (ativo = @ativo) AND campus = 0">
                  <SelectParameters>
                      <asp:Parameter DefaultValue="S" Name="ativo" Type="String" />
                  </SelectParameters>
                </asp:SqlDataSource>
        </div>
            </div>
       <div class="row">
        <div class="col-md-3 col-md-3">
         <label>Ano:</label>
                <asp:DropDownList ID="ddlAno"  runat="server" CssClass="form-control" AppendDataBoundItems="True"
                    Font-Size="9pt"  Enabled="True">
                    <asp:ListItem Value="" Text=""></asp:ListItem>
                </asp:DropDownList>
     </div>
           </div>


                <br /><br />
                <asp:Button ID="btnEnviar" Text="Exibir Relatório" CssClass="btn btn-primary" runat="server" />
    

</asp:Content>

