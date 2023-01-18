<%@ Page Title="" Language="VB" MasterPageFile="~/Sistec-V.2.0.master" AutoEventWireup="false"
    CodeFile="Grupos_SubGrupos_Servicos.aspx.vb" Inherits="Cadastros_Grupos_SubGrupos_Servicos" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            height: 29px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="Server">
    <h3>Grupos e sub-grupos de serviços/ensaios</h3>
    <hr />
    <br />
    <br />
    <div class="row">
        <div class="col-12">
            <asp:LinkButton ID="btnCadastro" runat="server" Text="Cadastro" CssClass="btn btn-primary btn-menu" />
            <asp:LinkButton ID="btnConsulta" runat="server" Text="Consulta" CssClass="btn btn-primary btn-menu" />

            <div id="divCadastro" class="div-content-3" runat="server" visible="false">
                <br/>
                <br />
                <h3>Cadastro</h3>
                            <ContentTemplate>
                                <div id="conteudo">
                                    <br />
                                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="id_grupo" DataSourceID="SqlGrupo"
                                        Width="100%">

                                        <EditItemTemplate>

                                            <asp:ImageButton ID="NewButton1" runat="server" BorderWidth="0px" ImageUrl="../App_Themes/SISTEC_WEB_THEME/imagens/new_over.png"
                                                CausesValidation="False" OnClientClick="return false;" Enabled="false" AlternateText="Novo"
                                                ToolTip="Inserir" /><asp:ImageButton ID="SaveButton1" runat="server" BorderWidth="0px"
                                                    ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save.png" CommandName="Update"
                                                    ToolTip="Salvar" /><asp:ImageButton ID="EditButton1" runat="server" BorderWidth="0px"
                                                        ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/edit_over.png" OnClientClick="return false;"
                                                        Enabled="false" CommandName="Edit" ToolTip="Editar" /><asp:ImageButton ID="PrintButton1"
                                                            runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/printer.png"
                                                            ToolTip="Imprimir" Visible="False" /><asp:ImageButton ID="DeleteButton1" runat="server"
                                                                BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/exclude_over.png"
                                                                OnClientClick="return false;" Enabled="false" ToolTip="Deletar" /><asp:ImageButton
                                                                    ID="CancelButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/cancel.png"
                                                                    CommandName="Cancel" ToolTip="Cancelar" /><asp:ImageButton ID="HelpButton1" runat="server"
                                                                        BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/help.png"
                                                                        OnClientClick="return false;" Enabled="false" ToolTip="Ajuda" OnClick="Click" /><br />
                                            <img height="1" src="../App_Themes/SISTEC_WEB_THEME/imagens/line_01.gif" width="100%" /><br />
                                            <br />
                                            <div class="row">
                                                <div class="col-xs-12 col-md-12">
                                                    <h6>Descrição:</h6>
                                                    <asp:TextBox ID="descricaoTextBox" CssClass="form-control required" runat="server" BackColor="#FFFFCC" Enabled="True" Text='<%# Bind("descricao") %>' />
                                                </div>
                                            </div>
                                        </EditItemTemplate>
                                        <EmptyDataTemplate>
                                            <asp:ImageButton ID="NewButton1" runat="server" AlternateText="Novo" BorderWidth="0px"
                                                CausesValidation="False" CommandName="New" ImageUrl="../App_Themes/SISTEC_WEB_THEME/imagens/new.png"
                                                ToolTip="Inserir" />
                                            <asp:ImageButton ID="SaveButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save_over.png"
                                                ToolTip="Salvar" />
                                            <asp:ImageButton ID="CancelButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/cancel_over.png"
                                                ToolTip="Cancelar" />
                                            <asp:ImageButton ID="HelpButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/help.png"
                                                OnClick="Click" ToolTip="Ajuda" />
                                            <br />
                                            <br />
                                            <asp:Label ID="Label1" runat="server" Text="Sem dados para este setor. Verifique a aba 'Consulta'"></asp:Label>
                                        </EmptyDataTemplate>
                                        <InsertItemTemplate>
                                            <asp:ImageButton ID="NewButton1" runat="server" BorderWidth="0px" ImageUrl="../App_Themes/SISTEC_WEB_THEME/imagens/new_over.png"
                                                CausesValidation="False" OnClientClick="return false;" AlternateText="Novo" ToolTip="Inserir"
                                                Enabled="False" /><asp:ImageButton ID="SaveButton1" runat="server" BorderWidth="0px"
                                                    ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save.png" CommandName="Insert"
                                                    ToolTip="Salvar" /><asp:ImageButton ID="EditButton1" runat="server" BorderWidth="0px"
                                                        ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/edit_over.png" CommandName="Edit"
                                                        ToolTip="Editar" Enabled="False" OnClientClick="return false;" /><asp:ImageButton
                                                            ID="PrintButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/printer.png"
                                                            ToolTip="Imprimir" Visible="False" /><asp:ImageButton ID="DeleteButton1" runat="server"
                                                                BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/exclude_over.png"
                                                                ToolTip="Deletar" Enabled="False" OnClientClick="return false;" /><asp:ImageButton
                                                                    ID="CancelButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/cancel.png"
                                                                    CommandName="Cancel" ToolTip="Cancelar" /><asp:ImageButton ID="HelpButton1" runat="server"
                                                                        BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/help.png"
                                                                        ToolTip="Ajuda" OnClick="Click" /><br />
                                            <img height="1" src="../App_Themes/SISTEC_WEB_THEME/imagens/line_01.gif" width="100%" /><br />
                                            <br />
                                            <div class="row">
                                                <div class="col-xs-12 col-md-12">
                                                    <h6>Descrição:</h6>
                                                    <asp:TextBox ID="descricaoTextBox" CssClass="form-control required" runat="server" BackColor="#FFFFCC" Enabled="True" Text='<%# Bind("descricao") %>' />
                                                </div>
                                            </div>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="NewButton1" runat="server" BorderWidth="0px" ImageUrl="../App_Themes/SISTEC_WEB_THEME/imagens/new.png"
                                                CausesValidation="False" CommandName="New" AlternateText="Novo" ToolTip="Inserir" /><asp:ImageButton
                                                    ID="SaveButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save_over.png"
                                                    ToolTip="Salvar" /><asp:ImageButton ID="EditButton1" runat="server" BorderWidth="0px"
                                                        ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/edit.png" CommandName="Edit"
                                                        ToolTip="Editar" /><asp:ImageButton ID="PrintButton1" runat="server" BorderWidth="0px"
                                                            ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/printer.png" ToolTip="Imprimir"
                                                            Visible="False" /><asp:ImageButton ID="DeleteButton1" runat="server" BorderWidth="0px"
                                                                ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/exclude.png" CommandName="Delete"
                                                                ToolTip="Deletar" /><asp:ImageButton ID="CancelButton1" runat="server" BorderWidth="0px"
                                                                    ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/cancel_over.png" ToolTip="Cancelar" /><asp:ImageButton
                                                                        ID="HelpButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/help.png"
                                                                        ToolTip="Ajuda" OnClick="Click" /><br />
                                            <img height="1" src="../App_Themes/SISTEC_WEB_THEME/imagens/line_01.gif" width="100%" /><br />
                                            <br />
                                            <div class="row">
                                                <div class="col-xs-12 col-md-12">
                                                    <h6>Descrição:</h6>
                                                    <asp:TextBox ID="descricaoTextBox" CssClass="form-control required" runat="server" Enabled="false" Text='<%# Bind("descricao") %>' />
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:FormView>
                                    &nbsp;<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label><br />
                                    <br />
                                    <h5>SUB-GRUPOS</h5>
                                    <hr />
                                    <br />
                                    <br />
                                    <asp:FormView ID="FormView2" runat="server" Width="100%" DataKeyNames="id_subgrupo,id_grupo" DataSourceID="SqlSubGrupo"
                                        DefaultMode="Insert">
                                        <EditItemTemplate>
                                            id_subgrupo:
                                    <asp:Label ID="id_subgrupoLabel1" runat="server" Text='<%# Eval("id_subgrupo") %>' /><br />
                                            Descrição:
                                    <asp:TextBox ID="descricaoTextBox" runat="server" Text='<%# Bind("descricao") %>' /><br />
                                            id_grupo:
                                    <asp:Label ID="id_grupoLabel1" runat="server" Text='<%# Eval("id_grupo") %>' /><br />
                                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                                Text="Update" />&#160;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False"
                                                    CommandName="Cancel" Text="Cancel" />
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:ImageButton ID="NewButton2" runat="server" BorderWidth="0px" ImageUrl="../App_Themes/SISTEC_WEB_THEME/imagens/new_over.png"
                                                CausesValidation="False" AlternateText="Novo" ToolTip="Inserir" /><asp:ImageButton
                                                    ID="SaveButton3" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save.png"
                                                    CommandName="Insert" ToolTip="Salvar" /><br />
                                            <img height="1" src="../App_Themes/SISTEC_WEB_THEME/imagens/line_01.gif" width="100%" /><br />
                                            <br />
                                            <div class="row">
                                                <div class="col-xs-12 col-md-9">
                                                    <h6>Descrição :</h6>
                                                    <asp:TextBox ID="descricaoTextBox" runat="server" Height="76px" Text='<%# Bind("descricao") %>'
                                                        TextMode="MultiLine" Width="135%" />
                                                </div>
                                            </div>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="NewButton2" runat="server" BorderWidth="0px" ImageUrl="../App_Themes/SISTEC_WEB_THEME/imagens/new.png"
                                                CausesValidation="False" CommandName="New" AlternateText="Novo" ToolTip="Inserir" /><asp:ImageButton
                                                    ID="SaveButton2" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save_over.png"
                                                    ToolTip="Salvar" /><br />
                                            <img height="1" src="../App_Themes/SISTEC_WEB_THEME/imagens/line_01.gif" width="100%" /><br />
                                        </ItemTemplate>
                                    </asp:FormView>
                                    <br />
                                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                        DataKeyNames="id_subgrupo,id_grupo" DataSourceID="SqlSubGrupo"
                                        GridLines="None" Width="100%">
                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                        <Columns>
                                            <asp:CommandField CancelText="Cancelar" DeleteText="Excluir" EditText="Editar" InsertText="Inserir"
                                                ShowDeleteButton="True" ShowEditButton="True" UpdateText="Salvar">
                                                <HeaderStyle Width="45px" />
                                            </asp:CommandField>
                                            <asp:BoundField DataField="id_subgrupo" HeaderText="id_subgrupo" InsertVisible="False"
                                                ReadOnly="True" SortExpression="id_subgrupo" Visible="False" />
                                            <asp:BoundField DataField="descricao" HeaderText="Descrição" SortExpression="descricao">
                                                <ControlStyle Width="600px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="id_grupo" HeaderText="id_grupo" ReadOnly="True" SortExpression="id_grupo"
                                                Visible="False" />
                                        </Columns>
                                        <EditRowStyle BackColor="#999999" />
                                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                    </asp:GridView>
                                </div>
                                <div id="tools">
                                    <asp:Panel ID="PanelTools" runat="server">
                                        <img height="1" src="../App_Themes/SISTEC_WEB_THEME/imagens/line_01.gif" width="100%" /><br />
                                        <br />
                                        <a href="javascript:void(0)" onclick="" id="btn_calc">
                                            <img alt="Calculadora" src="../App_Themes/SISTEC_WEB_THEME/imagens/calculadora.png" border="0" /></a><asp:ImageButton
                                                ID="CloseButton" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/x.png"
                                                ToolTip="Fechar" />
                                    </asp:Panel>
                                </div>
                           </div>
    <div id="divConsulta" runat="server" class="div-content-3" visible="true">
                           
        <br />
        <h3>Consulta</h3>


                            <ContentTemplate>
                                <br />
                                <asp:Label ID="Label2" runat="server" Text="Pesquisa:"></asp:Label>
                                <asp:TextBox ID="SearchBox" runat="server" CssClass="form-control" placeholder="Buscar por Grupos e sub-grupos de serviços/ensaios" Width="100%"></asp:TextBox>
                                <asp:Button ID="SearchButton" runat="server" Text="Pesquisar" CssClass="btn btn-primary" />
                                <asp:Button ID="CleanButton" runat="server" Text="Limpar" CssClass="btn btn-light" />

                                <asp:Label ID="LabelMsgPesquisa" runat="server" Text="Label2"></asp:Label>
                                <br />
                                <br />
                                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                                    CellPadding="4" DataKeyNames="id_grupo" DataSourceID="SqlGrupo" ForeColor="#333333"
                                    GridLines="None" Width="100%" PageSize="15" CssClass="gridViewSistec">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#333333" />
                                    <Columns>
                                        <asp:CommandField ShowSelectButton="True" CancelText="Cancelar" DeleteText="Excluir"
                                            EditText="Editar" InsertText="Inserir" SelectText="Selecionar" UpdateText="Salvar">
                                            <HeaderStyle Width="80px" />
                                        </asp:CommandField>
                                        <asp:BoundField DataField="descricao" HeaderText="Descrição" SortExpression="Descrição" />
                                    </Columns>
                                    <EditRowStyle BackColor="#999999" />
                                    <FooterStyle BackColor="#EEEEEE" Font-Bold="True" ForeColor="#333333" />
                                    <HeaderStyle BackColor="#EEEEEE" Font-Bold="True" ForeColor="#333333" />
                                    <PagerStyle BackColor="white" ForeColor="white" HorizontalAlign="Left" Font-Size="Medium" CssClass="gridViewPager" />
                                    <RowStyle BackColor="#EEEEEE" ForeColor="#333333" />
                                    <SelectedRowStyle Font-Bold="True" ForeColor="#333333" />
                                    <SortedAscendingCellStyle BackColor="#DDDDDD" />
                                    <SortedAscendingHeaderStyle BackColor="#CCCCCC" />
                                    <SortedDescendingCellStyle BackColor="#DDDDDD" />
                                    <SortedDescendingHeaderStyle BackColor="#CCCCCC" />
                                </asp:GridView>
                                <br />
                            </ContentTemplate>
              </div>
        </div>
    </div>
    &nbsp;<asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
        DeleteCommand="DELETE FROM [grupo] WHERE [id_grupo] = @id_grupo" InsertCommand="INSERT INTO [grupo] ([descricao],[ControlProcess]) VALUES (@descricao,&#39;PA&#39;); SELECT @PK_New = @@IDENTITY; "
        SelectCommand="SELECT [id_grupo], [descricao] FROM [grupo] 
WHERE [descricao] LIKE  @search 
ORDER BY id_grupo desc"
        UpdateCommand="UPDATE [grupo] SET [descricao] = @descricao WHERE [id_grupo] = @id_grupo"
        ID="SqlGrupo">
        <DeleteParameters>
            <asp:Parameter Name="id_grupo" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="descricao" Type="String"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="search" DefaultValue="%" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="descricao" Type="String"></asp:Parameter>
            <asp:Parameter Name="id_grupo" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
        DeleteCommand="DELETE FROM [subgrupo] WHERE [id_subgrupo] = @id_subgrupo AND [id_grupo] = @id_grupo"
        InsertCommand="INSERT INTO [subgrupo] ([descricao], [id_grupo]) VALUES (@descricao, @id_grupo)"
        SelectCommand="SELECT [id_subgrupo], [descricao], [id_grupo] FROM [subgrupo] WHERE ([id_grupo] = @id_grupo)"
        UpdateCommand="UPDATE [subgrupo] SET [descricao] = @descricao WHERE [id_subgrupo] = @id_subgrupo AND [id_grupo] = @id_grupo"
        ID="SqlSubGrupo">
        <DeleteParameters>
            <asp:Parameter Name="id_subgrupo" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="id_grupo" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="descricao" Type="String"></asp:Parameter>
            <asp:Parameter Name="id_grupo" Type="Int32"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="id_grupo" Type="Int32"></asp:Parameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="descricao" Type="String"></asp:Parameter>
            <asp:Parameter Name="id_subgrupo" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="id_grupo" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>


</asp:Content>
