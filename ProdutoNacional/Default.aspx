<%@ Page Title="" Language="C#" MasterPageFile="~/Sistec-V.2.0.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Cadastros_ProdutoNacional_Default" %>
<%@ Register Src="~/Cadastros/ProdutoNacional/Componentes/Cabecalho.ascx" TagPrefix="uc1" TagName="Cabecalho" %>
<%@ Register Src="~/Cadastros/ProdutoNacional/Componentes/Menu.ascx" TagPrefix="uc1" TagName="Menu" %>



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
                <small id="pesquisarHelp" class="form-text text-muted">Pode ser utilizado o nome do Produto.</small>
            </div>

            <asp:Button ID="btnPesquisar" runat="server" Text="Pesquisar" CssClass="btn btn-light" OnClick="btnPesquisar_Click" />&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnLimpar" runat="server" Text="Limpar" CssClass="btn btn-light" OnClick="btnLimpar_Click" />
        </div>
    </div>

    
        <div class="row">
        <div class="col-12 mt-3">


            <asp:GridView ID="gridProdutoNacional" runat="server" AllowPaging="False" AllowSorting="True"
                AutoGenerateColumns="False" DataKeyNames="id" Visible="true"
                DataSourceID="sqlGridProdutoNacional" GridLines="None" PageSize="15" Width="100%"
                CssClass="gridViewSistec">
                <AlternatingRowStyle BackColor="White" ForeColor="#333333" />
                <Columns>

                     <asp:BoundField DataField="categoria" HeaderText="Categoria" SortExpression="idCategoria">
                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="220px" />
                    </asp:BoundField>   


                    <asp:HyperLinkField SortExpression="produtoNacional" DataNavigateUrlFields="id" DataNavigateUrlFormatString="~/Cadastros/ProdutoNacional/Formulario.aspx?id={0}" 
                        DataTextField="produtoNacional" HeaderText="Produto Nacional">
                        <HeaderStyle HorizontalAlign="Center" />
                    </asp:HyperLinkField>
                         

                    <asp:BoundField DataField="codDN" HeaderText="Codigo DN" SortExpression="codDN">
                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="220px" />
                    </asp:BoundField>

                    
                    <asp:BoundField DataField="codSGT" HeaderText="Código SGT" SortExpression="codSGT">
                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="220px" />
                    </asp:BoundField>


                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="top" ItemStyle-Width="60px">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnCarregarProdutoNacional" runat="server" CssClass="btn btn-primary btn-sm"
                                CommandArgument='<%# Eval("id") %>' OnClick="CarregarProdutoNacional">
                                <icon class="glyphicon glyphicon-pencil" title="Visualizar Produto Nacional"></icon>
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

            <asp:SqlDataSource ID="sqlGridProdutoNacional" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
                SelectCommand="select cs.categoria, pn.* 
                    from ProdutoNacional pn 
                        inner join CategoriaServicos cs on pn.idCategoria = cs.id 
                    where pn.status = 1 and (pn.produtoNacional like @search or cs.categoria like @search)">
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
