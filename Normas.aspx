<%@ Page Title="" Language="VB" MasterPageFile="~/Sistec-V.2.0.master" AutoEventWireup="false"
    CodeFile="Normas.aspx.vb" Inherits="CadastroBasico_Normas" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 68px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="Server">
       <h3>Documentos de Fontes Externas</h3>
    <hr />
    <br />
    
    <div class="row">
        <div class="col-12">
            <asp:LinkButton ID="btnCadastro" runat="server" Text="Cadastro" CssClass="btn btn-primary btn-menu" />
            <asp:LinkButton ID="btnConsulta" runat="server" Text="Consulta" CssClass="btn btn-primary btn-menu" />

            <div id="divCadastro" class="div-content-3" runat="server" visible="false">
                <br />
                <h4>Cadastro</h4>
                <hr />
                    <ContentTemplate>
                        <div id="conteudo">
                            <br/>
                            <asp:FormView ID="FormView1" runat="server" DataKeyNames="id_norma" DataSourceID="SqlNorma"
                                Style="margin-top: 0px; margin-right: 1px;" Width="100%">
                                
                                <EditItemTemplate>
                                    
                                    <asp:ImageButton ID="NewButton1" runat="server" AlternateText="Novo" BorderWidth="0px"
                                        CausesValidation="False" Enabled="false" ImageUrl="../App_Themes/SISTEC_WEB_THEME/imagens/new_over.png"
                                        OnClientClick="return false;" ToolTip="Inserir" />
                                    <asp:ImageButton ID="SaveButton1" runat="server" BorderWidth="0px" CommandName="Update"
                                        ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save.png" ToolTip="Salvar" />
                                    <asp:ImageButton ID="EditButton1" runat="server" BorderWidth="0px" CommandName="Edit"
                                        Enabled="false" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/edit_over.png"
                                        OnClientClick="return false;" ToolTip="Editar" />
                                    <asp:ImageButton ID="PrintButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/printer.png"
                                        ToolTip="Imprimir" Visible="False" />
                                    <asp:ImageButton ID="DeleteButton1" runat="server" BorderWidth="0px" Enabled="false"
                                        ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/exclude_over.png" OnClientClick="return false;"
                                        ToolTip="Deletar" />
                                    <asp:ImageButton ID="CancelButton1" runat="server" BorderWidth="0px" CommandName="Cancel"
                                        ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/cancel.png" ToolTip="Cancelar" />
                                    <asp:ImageButton ID="HelpButton1" runat="server" BorderWidth="0px" Enabled="false"
                                        ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/help.png" OnClientClick="return false;"
                                        ToolTip="Ajuda" OnClick="Click" />
                                    <br />
                                    <img height="1" src="../App_Themes/SISTEC_WEB_THEME/imagens/line_01.gif" width="100%" />
                                    <br />
                                    &nbsp;<br />
                              
                                    <div class="row">

                                     <div class="col-xs-12 col-md-6">

                                        <h6>Número:</h6>
                                      <asp:TextBox ID="cod_normaTextBox0" CssClass="form-control required" runat="server" Enabled="True" BackColor="#FFFFCC"  Text='<%# Bind("cod_norma") %>' />                                    
                                    </div>
                                     <div class="col-xs-12 col-md-12">
                                       <h6>Título:</h6>
                                      <asp:TextBox ID="titulo_norTextBox0" CssClass="form-control " runat="server" Enabled="True"   Text='<%# Bind("titulo_nor") %>' />                                    
                                    </div>                      
                                        <div class="col-xs-12 col-md-6">
                                            <h6>Data da publicação:</h6>
                                            <asp:TextBox ID="data_norTextBox0" CssClass="form-control" runat="server" Enabled="True"  Text='<%# Bind("data_nor") %>' />
              
                                            </div>
                                        
                                        <div class="col-xs-12 col-md-6">
                                            <h6>
                                                Edição/Versão:
                                            </h6>
                                           <asp:TextBox ID="edicao_norTextBox0" CssClass="form-control required" runat="server" Enabled="True" BackColor="#FFFFCC" Text='<%# Bind("edicao_nor") %>'  />
                                          </div>
                                     </div>

                                    <asp:Panel ID="pnlExcluir" runat="server" Visible="false">
                                    <table>
                                        <tr>
                                            <td class="style4">
                                                Método:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="metodoTextBox0" runat="server" Text='<%# Bind("metodo") %>' Width="650px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style4">
                                                Autor:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="autor_norTextBox0" runat="server" Text='<%# Bind("autor_nor") %>'
                                                    Width="650px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style4">
                                                Cidade:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="cidadeTextBox0" runat="server" Text='<%# Bind("cidade") %>' Width="200px" />
                                                Fascículo:
                                                <asp:TextBox ID="fasciculo_norTextBox0" runat="server" Text='<%# Bind("fasciculo_nor") %>'
                                                    Width="45px" MaxLength="5" />
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                ISBN:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="isbn_norTextBox0" runat="server" Text='<%# Bind("isbn_nor") %>'
                                                    Width="100px" />
                                                Editora:
                                                <asp:TextBox ID="editora_norTextBox0" runat="server" Text='<%# Bind("editora_nor") %>'
                                                    Width="240px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style4">
                                                Capítulo do livro:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="capitulo_norTextBox0" runat="server" Text='<%# Bind("capitulo_nor") %>'
                                                    Width="100px" />
                                                Páginas:
                                                <asp:TextBox ID="paginas_norTextBox0" runat="server" Text='<%# Bind("paginas_nor") %>'
                                                    Width="40px" />
                                                <asp:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="paginas_norTextBox0"
                                                    Mask="9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                                                    MaskType="Number" InputDirection="RightToLeft" ErrorTooltipEnabled="True" />
                                                Setor:
                                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlSetores" DataTextField="nome_set"
                                                    DataValueField="id" Width="340px" AppendDataBoundItems="True" SelectedValue='<%# Bind("idUnidade")%>'>
                                                    <asp:ListItem></asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;Nº de páginas:
                                                <asp:TextBox ID="numpaginas_norTextBox0" runat="server" Text='<%# Bind("numpaginas_nor") %>'
                                                    Width="40px" />
                                                <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="numpaginas_norTextBox0"
                                                    Mask="9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                                                    MaskType="Number" InputDirection="RightToLeft" ErrorTooltipEnabled="True" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Número do periódico:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="numeroper_norTextBox0" runat="server" Text='<%# Bind("numeroper_nor") %>'
                                                    Width="60px" />
                                                <asp:MaskedEditExtender ID="MaskedEditExtender6" runat="server" TargetControlID="numeroper_norTextBox0"
                                                    Mask="999999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                                                    MaskType="Number" InputDirection="RightToLeft" ErrorTooltipEnabled="True" />
                                                Título do Periódico:
                                                <asp:TextBox ID="periodico_norTextBox0" runat="server" Text='<%# Bind("periodico_nor") %>'
                                                    Width="360px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Tipo:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tipoTextBox0" runat="server" Text='<%# Bind("tipo") %>' />
                                                Palavras-chave:
                                                <asp:TextBox ID="palavras_norTextBox0" runat="server" Text='<%# Bind("palavras_nor") %>'
                                                    Width="450px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Acesso à norma:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="path_normaTextBox0" runat="server" Text='<%# Bind("path_norma") %>'
                                                    Width="570px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Objeto:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="obs_norTextBox0" runat="server" Text='<%# Bind("obs_nor") %>' Height="70px"
                                                    TextMode="MultiLine" Width="650px" />
                                            </td>
                                        </tr>
                                    </table>
                                    </asp:Panel>
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
                                    <asp:Label ID="Label2" runat="server" Text="Sem dados para este setor. Verifique a aba 'Consulta'"></asp:Label>
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
                                    <img height="1" src="../App_Themes/SISTEC_WEB_THEME/imagens/line_01.gif" width="100%" />
                                    <br />
                                    <br />
                                 <div class="row">

                                     <div class="col-xs-12 col-md-6">

                                        <h6>Número:</h6>
                                      <asp:TextBox ID="cod_normaTextBox0" CssClass="form-control required" runat="server" Enabled="True" BackColor="#FFFFCC"  Text='<%# Bind("cod_norma") %>' />                                    
                                    </div>
                                     <div class="col-xs-12 col-md-12">
                                       <h6>Título:</h6>
                                      <asp:TextBox ID="titulo_norTextBox0" CssClass="form-control " runat="server" Enabled="True"   Text='<%# Bind("titulo_nor") %>' />                                    
                                    </div>                      
                                        <div class="col-xs-12 col-md-6">
                                            <h6>Data da publicação:</h6>
                                            <asp:TextBox ID="data_norTextBox0" CssClass="form-control" runat="server" Enabled="True"   Text='<%# Bind("data_nor") %>' />
              
                                            </div>
                                        
                                        <div class="col-xs-12 col-md-6">
                                            <h6>
                                                Edição/Versão:
                                            </h6>
                                           <asp:TextBox ID="edicao_norTextBox0" CssClass="form-control required" runat="server" Enabled="True" BackColor="#FFFFCC"  Text='<%# Bind("edicao_nor") %>'  />
                                          </div>
                                     </div>



                                    <asp:Panel ID="pnlExcluir" runat="server" Visible="false">
                                    <table>
                                        <tr>
                                            <td>
                                                Método:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="metodoTextBox0" runat="server" Text='<%# Bind("metodo") %>' Width="650px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Autor:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="autor_norTextBox0" runat="server" Text='<%# Bind("autor_nor") %>'
                                                    Width="650px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style4">
                                                Cidade:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="cidadeTextBox0" runat="server" Text='<%# Bind("cidade") %>' Width="200px" />
                                                Fascículo:
                                                <asp:TextBox ID="fasciculo_norTextBox0" runat="server" Text='<%# Bind("fasciculo_nor") %>'
                                                    Width="45px" MaxLength="5" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>ISBN:</td>
                                            <td>
                                                <asp:TextBox ID="isbn_norTextBox0" runat="server" Text='<%# Bind("isbn_nor") %>'
                                                    Width="100px" />
                                                Editora:
                                                <asp:TextBox ID="editora_norTextBox0" runat="server" Text='<%# Bind("editora_nor") %>'
                                                    Width="240px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style4">
                                                Capítulo do livro:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="capitulo_norTextBox0" runat="server" Text='<%# Bind("capitulo_nor") %>'
                                                    Width="100px" />
                                                Páginas:
                                                <asp:TextBox ID="paginas_norTextBox0" runat="server" Text='<%# Bind("paginas_nor") %>'
                                                    Width="40px" /><asp:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="paginas_norTextBox0"
                                                        Mask="9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                                                        MaskType="Number" InputDirection="RightToLeft" ErrorTooltipEnabled="True" />
                                                Setor:
                                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlSetores" DataTextField="nome_set"
                                                    DataValueField="id" AppendDataBoundItems="True" SelectedValue='<%# Bind("idUnidade")%>'
                                                    Width="340px">
                                                    <asp:ListItem></asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;Nº de páginas:
                                                <asp:TextBox ID="numpaginas_norTextBox0" runat="server" Text='<%# Bind("numpaginas_nor") %>'
                                                    Width="40px" />
                                                <asp:MaskedEditExtender ID="MaskedEditExtender4" runat="server" TargetControlID="numpaginas_norTextBox0"
                                                    Mask="9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                                                    MaskType="Number" InputDirection="RightToLeft" ErrorTooltipEnabled="True" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Número do periódico:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="numeroper_norTextBox0" runat="server" Text='<%# Bind("numeroper_nor") %>'
                                                    Width="60px" />
                                                <asp:MaskedEditExtender ID="MaskedEditExtender7" runat="server" TargetControlID="numeroper_norTextBox0"
                                                    Mask="999999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                                                    MaskType="Number" InputDirection="RightToLeft" ErrorTooltipEnabled="True" />
                                                Título do Periódico:
                                                <asp:TextBox ID="periodico_norTextBox0" runat="server" Text='<%# Bind("periodico_nor") %>'
                                                    Width="360px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Tipo:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tipoTextBox0" runat="server" Text='<%# Bind("tipo") %>' />
                                                Palavras-chave:
                                                <asp:TextBox ID="palavras_norTextBox0" runat="server" Text='<%# Bind("palavras_nor") %>'
                                                    Width="450px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Acesso à norma:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="path_normaTextBox0" runat="server" Text='<%# Bind("path_norma") %>'
                                                    Width="570px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Objeto:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="obs_norTextBox0" runat="server" Text='<%# Bind("obs_nor") %>' Height="70px"
                                                    TextMode="MultiLine" Width="650px" />
                                            </td>
                                        </tr>
                                    </table>
                                    </asp:Panel>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:ImageButton ID="NewButton1" runat="server" BorderWidth="0px" ImageUrl="../App_Themes/SISTEC_WEB_THEME/imagens/new.png"
                                        CausesValidation="False" CommandName="New" AlternateText="Novo" ToolTip="Inserir" /><asp:ImageButton
                                            ID="SaveButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save_over.png"
                                            ToolTip="Salvar" />
                                    <asp:ImageButton ID="EditButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/edit.png"
                                        CommandName="Edit" ToolTip="Editar" />
                                    <asp:ImageButton ID="PrintButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/printer.png"
                                        ToolTip="Imprimir" Visible="False" />
                                    <asp:ImageButton ID="DeleteButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/exclude.png"
                                        CommandName="Delete" ToolTip="Deletar" OnClientClick="return confirm('Excluir Registro?');" />
                                    <asp:ImageButton ID="CancelButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/cancel_over.png"
                                        ToolTip="Cancelar" />
                                    <asp:ImageButton ID="HelpButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/help.png"
                                        ToolTip="Ajuda" OnClick="Click" /><br />
                                    <img height="1" src="../App_Themes/SISTEC_WEB_THEME/imagens/line_01.gif" width="100%" /><br />
                                    <br />
                                      <div class="row">

                                     <div class="col-xs-12 col-md-6">

                                        <h6>Número:</h6>
                                      <asp:TextBox ID="cod_normaTextBox0" CssClass="form-control required" runat="server" Enabled="false"  Text='<%# Bind("cod_norma") %>' />                                    
                                    </div>
                                     <div class="col-xs-12 col-md-12">
                                       <h6>Título:</h6>
                                      <asp:TextBox ID="titulo_norTextBox0" CssClass="form-control " runat="server" Enabled="false"   Text='<%# Bind("titulo_nor") %>' />                                    
                                    </div>                      
                                        <div class="col-xs-12 col-md-6">
                                            <h6>Data da publicação:</h6>
                                            <asp:TextBox ID="data_norTextBox0" CssClass="form-control" runat="server" Enabled="false"  Text='<%# Bind("data_nor") %>' />
              
                                            </div>
                                        
                                        <div class="col-xs-12 col-md-6">
                                            <h6>
                                                Edição/Versão:
                                            </h6>
                                           <asp:TextBox ID="edicao_norTextBox0" CssClass="form-control " runat="server" Enabled="false"  Text='<%# Bind("edicao_nor") %>'  />
                                          </div>
                                     </div>

                                    <asp:Panel ID="pnlExcluir" runat="server" Visible="false">
                                    <table>
                                        <tr>
                                            <td class="style4">
                                                Método:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="metodoTextBox0" runat="server" Text='<%# Bind("metodo") %>' Width="650px"
                                                    Enabled="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style4">
                                                Autor:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="autor_norTextBox0" runat="server" Text='<%# Bind("autor_nor") %>'
                                                    Width="650px" Enabled="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style4">
                                                Cidade:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="cidadeTextBox0" runat="server" Text='<%# Bind("cidade") %>' Width="200px"
                                                    Enabled="False" />
                                                Fascículo:
                                                <asp:TextBox ID="fasciculo_norTextBox0" runat="server" Text='<%# Bind("fasciculo_nor") %>'
                                                    Width="45px" Enabled="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                ISBN:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="isbn_norTextBox0" runat="server" Text='<%# Bind("isbn_nor") %>'
                                                    Width="100px" Enabled="False" />
                                                Editora:
                                                <asp:TextBox ID="editora_norTextBox0" runat="server" Text='<%# Bind("editora_nor") %>'
                                                    Width="240px" Enabled="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style4">
                                                Capítulo do livro:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="capitulo_norTextBox0" runat="server" Text='<%# Bind("capitulo_nor") %>'
                                                    Width="100px" Enabled="False" />
                                                Páginas:
                                                <asp:TextBox ID="paginas_norTextBox0" runat="server" Text='<%# Bind("paginas_nor") %>'
                                                    Width="40px" Enabled="False" />
                                                Setor:
                                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlSetores" DataTextField="nome_set"
                                                    DataValueField="id" Width="340px" Enabled="False" AppendDataBoundItems="True"
                                                    SelectedValue='<%# Bind("idUnidade")%>'>
                                                    <asp:ListItem></asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;Nº de páginas:
                                                <asp:TextBox ID="numpaginas_norTextBox0" runat="server" Text='<%# Bind("numpaginas_nor") %>'
                                                    Width="40px" Enabled="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Número do periódico:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="numeroper_norTextBox0" runat="server" Text='<%# Bind("numeroper_nor") %>'
                                                    Width="60px" Enabled="False" />
                                                Título do Periódico:
                                                <asp:TextBox ID="periodico_norTextBox0" runat="server" Text='<%# Bind("periodico_nor") %>'
                                                    Width="360px" Enabled="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Tipo:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tipoTextBox0" runat="server" Text='<%# Bind("tipo") %>' Enabled="False" />
                                                Palavras-chave:
                                                <asp:TextBox ID="palavras_norTextBox0" runat="server" Text='<%# Bind("palavras_nor") %>'
                                                    Width="450px" Enabled="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Acesso à norma:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="path_normaTextBox0" runat="server" Text='<%# Bind("path_norma") %>'
                                                    Width="570px" Enabled="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Objeto:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="obs_norTextBox0" runat="server" Text='<%# Bind("obs_nor") %>' Height="70px"
                                                    TextMode="MultiLine" Width="650px" Enabled="False" />
                                            </td>
                                        </tr>
                                    </table>
                                    </asp:Panel>
                                </ItemTemplate>
                            </asp:FormView>
                            <br />
                            &nbsp;<asp:Label ID="LabelMsg" runat="server" Text="Label"></asp:Label><br />
                        </div>
                        <div id="tools">
                            <asp:Panel ID="PanelTools" runat="server">
                                <img height="1" src="../App_Themes/SISTEC_WEB_THEME/imagens/line_01.gif" width="100%" /><br />
                                <br />
                                <a href="javascript:void(0)" onclick="" id="btn_calc">
                                    <img alt="Calculadora" src="../App_Themes/SISTEC_WEB_THEME/imagens/calculadora.png" border="0" /></a><asp:ImageButton
                                        ID="CloseButton" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/x.png"
                                        ToolTip="Fechar" /></asp:Panel>
                        </div>
                    </ContentTemplate>
                </div>
           
                <div id="divConsulta" runat="server" class="div-content-3" visible="true">
                <br />
                    <h5>Consulta</h5>
                <hr />

                        
                        <asp:Label ID="Label1" runat="server" Text="Pesquisa:"></asp:Label>
                        <asp:TextBox ID="SearchBox" CssClass="form-control" placeholder="Buscar por Documento"
                            runat="server" Width="100%"></asp:TextBox>
                        <asp:Button ID="SearchButton" runat="server" CssClass="btn btn-primary"
                                Text="Pesquisar" />
                        <asp:Button ID="CleanButton" runat="server" Text="Limpar"  CssClass="btn btn-light" /><br />
                        <br />
                        <asp:Label ID="LabelMsgPesquisa" runat="server" Text="Label2"></asp:Label>

                        <br />
                        <asp:Panel ID="Panel12" runat="server" Direction="LeftToRight" ScrollBars="Horizontal" Width="100%">
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="false"
                            CellPadding="4" DataKeyNames="id_norma" DataSourceID="SqlNorma" ForeColor="#333333"
                            GridLines="None" Width="140%" PageSize="15" AllowSorting="True" CssClass="gridViewSistec">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" SelectText="Selecionar" />
                                <asp:BoundField DataField="cod_norma" HeaderText="Código" SortExpression="cod_norma" />
                                <asp:BoundField DataField="titulo_nor"  HeaderText="Título" SortExpression="titulo_nor" />
                                <asp:BoundField DataField="data_nor" HeaderText="Data" SortExpression="data_nor" />
                                <asp:BoundField DataField="edicao_nor" HeaderText="Edição" SortExpression="edicao_nor" />
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                                 <FooterStyle BackColor="#EEEEEE" Font-Bold="True" ForeColor="#333333" />
                                 <HeaderStyle BackColor="#EEEEEE" Font-Bold="True" ForeColor="#333333" />
                                 <PagerStyle BackColor="white" ForeColor="#333333" HorizontalAlign="Left" Font-Size="Medium" CssClass="gridViewPager" />
                                 <RowStyle BackColor="#EEEEEE" ForeColor="#333333" />
                                 <SelectedRowStyle Font-Bold="True" ForeColor="#333333" />
                                 <SortedAscendingCellStyle BackColor="#DDDDDD" />
                                 <SortedAscendingHeaderStyle BackColor="#CCCCCC" />
                                 <SortedDescendingCellStyle BackColor="#DDDDDD" />
                                  <SortedDescendingHeaderStyle BackColor="#CCCCCC" />
                        </asp:GridView>
                            </asp:Panel>
                        <br />
         </div>
            </div>
        </div>
    
    
    <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
        DeleteCommand="UPDATE normas SET status = 0 WHERE [id_norma] = @id_norma"
        InsertCommand="INSERT INTO [normas] ([cod_norma], [titulo_nor], [metodo], [autor_nor], [cidade], [fasciculo_nor], [data_nor], [edicao_nor], [isbn_nor], [editora_nor], [capitulo_nor], [numpaginas_nor], [paginas_nor], [numeroper_nor], [periodico_nor], [tipo], [palavras_nor], [obs_nor], [path_norma], [idUnidade]) VALUES (@cod_norma, @titulo_nor, @metodo, @autor_nor, @cidade, @fasciculo_nor, @data_nor, @edicao_nor, @isbn_nor, @editora_nor, @capitulo_nor, @numpaginas_nor, @paginas_nor, @numeroper_nor, @periodico_nor, @tipo, @palavras_nor, @obs_nor, @path_norma, @idUnidade)"
        SelectCommand="SELECT id_norma, cod_norma, titulo_nor, metodo, autor_nor, cidade, fasciculo_nor, data_nor, edicao_nor, isbn_nor, editora_nor,
            capitulo_nor, numpaginas_nor, paginas_nor, numeroper_nor, periodico_nor, tipo, palavras_nor, obs_nor, path_norma, idUnidade
            FROM normas
            WHERE status = 1 AND idUnidade = @idUnidade AND (cod_norma LIKE @search OR titulo_nor LIKE @search)
            ORDER BY id_norma desc"
        UpdateCommand="UPDATE [normas] SET [cod_norma] = @cod_norma, [titulo_nor] = @titulo_nor, [metodo] = @metodo, [autor_nor] = @autor_nor, [cidade] = @cidade, [fasciculo_nor] = @fasciculo_nor, [data_nor] = @data_nor, [edicao_nor] = @edicao_nor, [isbn_nor] = @isbn_nor, [editora_nor] = @editora_nor, [capitulo_nor] = @capitulo_nor, [numpaginas_nor] = @numpaginas_nor, [paginas_nor] = @paginas_nor, [numeroper_nor] = @numeroper_nor, [periodico_nor] = @periodico_nor, [tipo] = @tipo, [palavras_nor] = @palavras_nor, [obs_nor] = @obs_nor, [path_norma] = @path_norma, [idUnidade] = @idUnidade WHERE [id_norma] = @id_norma"
        ID="SqlNorma">
        <DeleteParameters>
            <asp:Parameter Name="id_norma" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="cod_norma" Type="String"></asp:Parameter>
            <asp:Parameter Name="titulo_nor" Type="String" />
            <asp:Parameter Name="metodo" Type="String" />
            <asp:Parameter Name="autor_nor" Type="String" />
            <asp:Parameter Name="cidade" Type="String" />
            <asp:Parameter Name="fasciculo_nor" Type="String" />
            <asp:Parameter Name="data_nor" Type="String" />
            <asp:Parameter Name="edicao_nor" Type="String" />
            <asp:Parameter Name="isbn_nor" Type="String" />
            <asp:Parameter Name="editora_nor" Type="String" />
            <asp:Parameter Name="capitulo_nor" Type="String" />
            <asp:Parameter Name="numpaginas_nor" Type="Int32" />
            <asp:Parameter Name="paginas_nor" Type="String" />
            <asp:Parameter Name="numeroper_nor" Type="Int32" />
            <asp:Parameter Name="periodico_nor" Type="String" />
            <asp:Parameter Name="tipo" Type="String" />
            <asp:Parameter Name="palavras_nor" Type="String" />
            <asp:Parameter Name="obs_nor" Type="String" />
            <asp:Parameter Name="path_norma" Type="String" />
            <asp:SessionParameter Name="idUnidade" SessionField="idUnidade" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="search" DefaultValue="%" Type="String" />
            <asp:SessionParameter Name="idUnidade"  SessionField="idUnidade" />
            <asp:Parameter Name="status" DefaultValue="1" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="cod_norma" Type="String"></asp:Parameter>
            <asp:Parameter Name="titulo_nor" Type="String"></asp:Parameter>
            <asp:Parameter Name="metodo" Type="String" />
            <asp:Parameter Name="autor_nor" Type="String" />
            <asp:Parameter Name="cidade" Type="String" />
            <asp:Parameter Name="fasciculo_nor" Type="String" />
            <asp:Parameter Name="data_nor" Type="String" />
            <asp:Parameter Name="edicao_nor" Type="String" />
            <asp:Parameter Name="isbn_nor" Type="String" />
            <asp:Parameter Name="editora_nor" Type="String" />
            <asp:Parameter Name="capitulo_nor" Type="String" />
            <asp:Parameter Name="numpaginas_nor" Type="Int32" />
            <asp:Parameter Name="paginas_nor" Type="String" />
            <asp:Parameter Name="numeroper_nor" Type="Int32" />
            <asp:Parameter Name="periodico_nor" Type="String" />
            <asp:Parameter Name="tipo" Type="String" />
            <asp:Parameter Name="palavras_nor" Type="String" />
            <asp:Parameter Name="obs_nor" Type="String" />
            <asp:Parameter Name="path_norma" Type="String" />
            <asp:Parameter Name="idUnidade" Type="Int32" />
            <asp:Parameter Name="id_norma" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
        SelectCommand="SELECT [id], [nome_set] FROM [Unidades] ORDER BY [nome_set]"
        ID="SqlSetores"></asp:SqlDataSource>
</asp:Content>
