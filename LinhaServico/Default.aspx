<%@ Page Title="" Language="C#" MasterPageFile="~/Sistec-V.2.0.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Cadastros_LinhaServicos_Default" %>

<%@ Register Src="~/Cadastros/LinhaServico/Componentes/Cabecalho.ascx" TagPrefix="uc1" TagName="Cabecalho" %>
<%@ Register Src="~/Cadastros/LinhaServico/Componentes/Menu.ascx" TagPrefix="uc1" TagName="Menu" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <uc1:Cabecalho runat="server" ID="Cabecalho" />
    <uc1:Menu runat="server" ID="Menu" />

    


    <div class="row">
        <div class="col-12 col-md-6">
            <div class="form-group">
                <label for="txbPesquisar">Texto para pesquisar</label>
                <asp:TextBox ID="txbPesquisar" runat="server" CssClass="form-control" placeholder="Pesquisar" AutoCompleteType="Search" 
                    AutoPostBack="True" OnTextChanged="txbPesquisar_TextChanged"></asp:TextBox>
                <small id="pesquisarHelp" class="form-text text-muted">Pode ser utilizado o nome da linha.</small>
            </div>

            <asp:Button ID="btnPesquisar" runat="server" Text="Pesquisar" CssClass="btn btn-light" OnClick="btnPesquisar_Click" />&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnLimpar" runat="server" Text="Limpar" CssClass="btn btn-light" OnClick="btnLimpar_Click" />
        </div>
    </div>

    
        <div class="row">
        <div class="col-12 mt-3">


            <asp:GridView ID="gridLinhaServicos" runat="server" AllowPaging="False" AllowSorting="True"
                AutoGenerateColumns="False" DataKeyNames="id" Visible="true"
                DataSourceID="sqlGridLinhaServicos" GridLines="None" PageSize="15" Width="100%"
                CssClass="gridViewSistec">
                <AlternatingRowStyle BackColor="White" ForeColor="#333333" />
                <Columns>
                    <asp:HyperLinkField SortExpression="linha" DataNavigateUrlFields="id" DataNavigateUrlFormatString="~/Cadastros/LinhaServico/Formulario.aspx?id={0}" 
                        DataTextField="linha" HeaderText="Linha de Serviços">
                        <HeaderStyle HorizontalAlign="Center" />
                    </asp:HyperLinkField>
                    <asp:BoundField DataField="codDN" HeaderText="Codigo DN" SortExpression="codDN">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="220px" />
                    </asp:BoundField>

                    <asp:BoundField DataField="contaContabil" HeaderText="Conta Contabil" SortExpression="contaContabil">
                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="220px" />
                    </asp:BoundField>                  

                    <asp:BoundField DataField="codSgt" HeaderText="Codigo SGT" SortExpression="codSgt">
                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="220px" />
                    </asp:BoundField>

                    
                    <asp:BoundField DataField="codProdERP" HeaderText="Código Produto ERP" SortExpression="codProdERP">
                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="220px" />
                    </asp:BoundField>

                     <asp:BoundField DataField="ordemValor" HeaderText="Ordem valor" SortExpression="ordemValor">
                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="220px" />
                    </asp:BoundField>
                    
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="top" ItemStyle-Width="60px">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnCarregarLinhaServicos" runat="server" CssClass="btn btn-primary btn-sm"
                                CommandArgument='<%# Eval("id") %>' OnClick="CarregarLinhaServicos">
                                <icon class="glyphicon glyphicon-pencil" title="Visualizar Linha Serviços"></icon>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#EEEEEE" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#EEEEEE" Font-Bold="True" ForeColor="#333333" HorizontalAlign="Center" />
                <PagerStyle BackColor="#EEEEEE" ForeColor="#333333" HorizontalAlign="Left" Font-Size="Medium" CssClass="gridViewPager" />
                <RowStyle BackColor="#EEEEEE" ForeColor="#333333" />
                <SelectedRowStyle Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#DDDDDD" />
                <SortedAscendingHeaderStyle BackColor="#CCCCCC" />
                <SortedDescendingCellStyle BackColor="#DDDDDD" />
                <SortedDescendingHeaderStyle BackColor="#CCCCCC" />
            </asp:GridView>

            <asp:SqlDataSource ID="sqlGridLinhaServicos" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
                SelectCommand="select * from LinhaServicos where linha like @search and status = @status">
                <SelectParameters>
                    <asp:Parameter Name="search" DefaultValue="%" />
                    <asp:Parameter Name="status" DefaultValue="1" Type="Int16" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>

    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scripts" Runat="Server">
</asp:Content>

