<%--<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"--%>

<%@ Page Title="Usuario . SISTEC Web" Language="VB" MasterPageFile="~/Sistec.master" AutoEventWireup="false"
    CodeFile="Usuario.aspx.vb" Inherits="GerenciamentoSistema_Usuario" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="Server">
    <h3>Cadastro de Usuários</h3>
    <hr />
    <asp:Label ID="LabelMsg" CssClass="alert" runat="server"></asp:Label>


    <div class="row">
        <div class="col-xs-12">
            <asp:Button ID="btnCadastro" runat="server" Text="Cadastro" CssClass="btn btn-warning btn-div-content" CausesValidation="False" />
            <asp:Button ID="btnConsulta" runat="server" Text="Consulta" CssClass="btn btn-warning btn-div-content" CausesValidation="False" />
             <asp:Button ID="btnRelatorio" runat="server" Text="Relatórios" CssClass="btn btn-warning btn-div-content " CausesValidation="False" />

            <div id="divCadastro" class="div-content" runat="server">
                <h4>Dados do usuário</h4>
                <hr />

                <asp:FormView ID="FormView1" runat="server" DataKeyNames="id_usu" DataSourceID="SqlUsuarios" ViewStateMode="Disabled" Width="100%">
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
                            ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/cancel.png" ToolTip="Cancelar" OnClick="CancelButton1_Click" CausesValidation="false" />
                        <asp:ImageButton ID="HelpButton1" runat="server" BorderWidth="0px" Enabled="false"
                            ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/help.png" OnClientClick="return false;"
                            ToolTip="Ajuda" />

                        <div class="row">
                            <div class=" col-xs-12 col-md-6">
                                <label>Nome de exibição :</label>
                                <asp:TextBox ID="LoginTextBox1" CssClass="form-control required" runat="server" Text='<%# Bind("nome") %>' />
                                 <asp:RequiredFieldValidator ID="rfvNome" runat="server" ErrorMessage="Campo obrigatório."
                                    ControlToValidate="LoginTextBox1" Text="Campo obrigatório." CssClass="balao"></asp:RequiredFieldValidator>
                            </div>
                            <div class=" col-xs-12 col-md-6">
                                <label>CPF:</label>
                                <asp:TextBox ID="tbxCPF" CssClass="form-control mask-cpf" runat="server" Text='<%# Bind("cpf")%>' />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <label>Login:</label>
                                <asp:TextBox ID="LoginTextBox0" CssClass="form-control required" runat="server" BackColor="#FFFFCC" Text='<%# Bind("Login") %>' />
                                <asp:RequiredFieldValidator ID="rfvLogin" runat="server" ErrorMessage="Campo obrigatório."
                                    ControlToValidate="LoginTextBox0" Text="Campo obrigatório." CssClass="balao"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <label>Telefone:</label>
                                <asp:TextBox ID="txbTel" CssClass="form-control" runat="server" Text='<%# Bind("telefone")%>' />
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <label>Ramal:</label>
                                <asp:TextBox ID="txbTelefone" CssClass="form-control" runat="server" Text='<%# Bind("ramal")%>' />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <label>Email:</label>
                                <asp:TextBox ID="TextBox2" CssClass="form-control" runat="server" Text='<%# Bind("email")%>' />
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <label>Perfil usuário:</label>
                                <asp:DropDownList ID="ddlPerfil" CssClass="form-control" runat="server" BackColor="#FFFFCC" DataSourceID="SqlPerfil"
                                    DataTextField="nomePerfil" DataValueField="idPerfil" Font-Size="9pt" AppendDataBoundItems="True" SelectedValue='<%# Bind("idPerfil")%>'>
                                   
                                    <asp:ListItem Value=" "></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvGrupo" runat="server" ErrorMessage="Campo obrigatório."
                                    ControlToValidate="ddlPerfil" Text="Campo obrigatório." CssClass="balao"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <label>Master:</label>
                                <div class="checkbox">
                                    <label>
                                        <asp:CheckBox ID="ckbMaster" runat="server" Text="Se marcado o usuário conseguira acessar qualquer unidade" Checked='<%# Bind("master")%>'  />
                                    </label>
                                </div>
                            </div>
                        </div>

                    </EditItemTemplate>

                    <InsertItemTemplate>
                        <asp:ImageButton ID="NewButton1" runat="server" AlternateText="Novo" BorderWidth="0px"
                            CausesValidation="False" Enabled="False" ImageUrl="../App_Themes/SISTEC_WEB_THEME/imagens/new_over.png"
                            OnClientClick="return false;" ToolTip="Inserir" />
                        <asp:ImageButton ID="SaveButton1" runat="server" BorderWidth="0px" CommandName="Insert"
                            ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save.png" ToolTip="Salvar" OnClick="SaveButton1_Click" />
                        <asp:ImageButton ID="EditButton1" runat="server" BorderWidth="0px" CommandName="Edit"
                            Enabled="False" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/edit_over.png"
                            OnClientClick="return false;" ToolTip="Editar" />
                        <asp:ImageButton ID="PrintButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/printer.png"
                            ToolTip="Imprimir" Visible="False" />
                        <asp:ImageButton ID="DeleteButton1" runat="server" BorderWidth="0px" Enabled="False"
                            ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/exclude_over.png" OnClientClick="return false;"
                            ToolTip="Deletar" />
                        <asp:ImageButton ID="CancelButton1" runat="server" CausesValidation="false" BorderWidth="0px" CommandName="Cancel"
                            ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/cancel.png" ToolTip="Cancelar" />
                        <asp:ImageButton ID="HelpButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/help.png"
                            ToolTip="Ajuda" />
                        <br />

                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <label>Nome:</label>
                                <asp:TextBox ID="LoginTextBox1" CssClass="form-control required" runat="server" Text='<%# Bind("nome") %>' />
                                <asp:RequiredFieldValidator ID="rfvNome" runat="server" ErrorMessage="Campo obrigatório."
                                    ControlToValidate="LoginTextBox1" Text="Campo obrigatório." CssClass="balao"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-xs-12 col-md-6">
                                <label>CPF:</label>
                                <asp:TextBox ID="tbxCPF" CssClass="form-control mask-cpf" runat="server" Text='<%# Bind("cpf") %>' />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <label>Login:</label>
                                <asp:TextBox ID="LoginTextBox0" CssClass="form-control required" runat="server" Text='<%# Bind("Login") %>' />
                                <asp:RequiredFieldValidator ID="rfvLogin" runat="server" ErrorMessage="Campo obrigatório."
                                    ControlToValidate="LoginTextBox0" Text="Campo obrigatório." CssClass="balao"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-xs-12 col-md-6">
                                <label>Metodo de login :</label>
                                <div class="checkbox">
                                    <label>
                                        <asp:CheckBox ID="cbMetodoLogin" runat="server" Text="Utilizar login de Rede (Active Directory)" Checked='<%# Bind("logarActiveDirectory")%>' AutoPostBack="True" OnCheckedChanged="cbMetodoLogin_CheckedChanged"  />
                                    </label>
                                </div>
                            </div>

                        </div>

                        <asp:Panel ID="pnlPass" runat="server" Visible="true">

                            <div class="row">
                                <div class="col-xs-12 col-md-6">
                                    <label>Senha:</label>
                                    <asp:TextBox ID="txbPass1" CssClass="form-control required" runat="server" Text="" TextMode="Password" />
                                    <asp:RequiredFieldValidator ID="rfvPASS"  runat="server" ErrorMessage="Campo obrigatório."
                                        ControlToValidate="txbPass1" Text="Campo obrigatório." CssClass="balao"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-xs-12 col-md-6">
                                    <label>Confirma senha:</label>
                                    <asp:TextBox ID="txbPass2" CssClass="form-control required" runat="server" Text="" TextMode="Password" />
                                    <asp:RequiredFieldValidator ID="rfvPassConfirm" runat="server" ErrorMessage="Campo obrigatório."
                                        ControlToValidate="txbPass2" Text="Campo obrigatório." CssClass="balao"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                        </asp:Panel>

                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <label>Telefone:</label>
                                <asp:TextBox ID="txbTel" CssClass="form-control" runat="server" Text='<%# Bind("telefone")%>' />
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <label>Ramal:</label>
                                <asp:TextBox ID="txbTelefone" CssClass="form-control" runat="server" Text='<%# Bind("ramal")%>'  />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <label>email:</label>
                                <asp:TextBox ID="TextBox4" CssClass="form-control required" runat="server" Text='<%# Bind("email")%>' />
                                <asp:RequiredFieldValidator ID="rfvEamil" runat="server" ErrorMessage="Campo obrigatório."
                                    ControlToValidate="TextBox4" Text="Campo obrigatório." CssClass="balao"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <label>Perfil usuário:</label>
                                <asp:DropDownList ID="ddlPerfil" CssClass="form-control required" runat="server" DataSourceID="SqlPerfil"
                                    DataTextField="nomePerfil" DataValueField="idPerfil" Font-Size="9pt" AppendDataBoundItems="True" SelectedValue='<%# Bind("idPerfil")%>'>
                                  
                                    <asp:ListItem Value=" "></asp:ListItem>
                                </asp:DropDownList>
                                 <asp:RequiredFieldValidator ID="rfvGrupo" runat="server" ErrorMessage="Campo obrigatório."
                                    ControlToValidate="ddlPerfil" Text="Campo obrigatório." CssClass="balao"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <label>Master:</label>
                                <div class="checkbox">
                                    <label>
                                        <asp:CheckBox ID="ckbMaster" runat="server" Text="Se marcado o usuário conseguira acessar qualquer unidade" Checked='<%# Bind("master")%>'  />
                                    </label>
                                </div>
                            </div>
                        </div>
                    </InsertItemTemplate>

                    <ItemTemplate>
                        <asp:ImageButton ID="NewButton1" runat="server" AlternateText="Novo" BorderWidth="0px"
                            CausesValidation="False" CommandName="New" ImageUrl="../App_Themes/SISTEC_WEB_THEME/imagens/new.png"
                            ToolTip="Inserir" OnClick="Click" />
                        <asp:ImageButton ID="SaveButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save_over.png"
                            ToolTip="Salvar" />
                        <asp:ImageButton ID="EditButton1" runat="server" BorderWidth="0px" CommandName="Edit"
                            ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/edit.png" ToolTip="Editar" />
                        <asp:ImageButton ID="PrintButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/printer.png"
                            ToolTip="Imprimir" Visible="False" />
                        <asp:ImageButton ID="DeleteButton1" runat="server" BorderWidth="0px" CommandName="Delete"
                            ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/exclude.png" ToolTip="Deletar" OnClientClick="return confirm('Excluir Usuário?');" />
                        <asp:ImageButton ID="CancelButton1" runat="server" CausesValidation="false" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/cancel_over.png"
                            ToolTip="Cancelar" />
                        <asp:ImageButton ID="HelpButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/help.png"
                            ToolTip="Ajuda" />
                        <br />

                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <label>Nome:</label>
                                <asp:TextBox ID="txbNome" CssClass="form-control" runat="server" Text='<%# Bind("nome") %>' Enabled="False" />
		                            <ControlToValidate="txbNome" Text="Campo obrigatório." CssClass="balao" Enabled="false"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-xs-12 col-md-6">
                                <label>CPF:</label>
                                <asp:TextBox ID="tbxCPF" CssClass="form-control" runat="server" Text='<%# Bind("cpf")%>' Enabled="False" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <label>Login:</label>
                                <asp:TextBox ID="LoginTextBox0" CssClass="form-control" runat="server" Text='<%# Bind("Login") %>' Enabled="False" />
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <label>Metodo de login :</label>
                                <div class="checkbox">
                                    <label>
                                        <asp:CheckBox ID="cbMetodoLogin" runat="server" Text="Utilizar login de Rede (Active Directory)" Enabled="false" 
                                            Checked='<%# Bind("logarActiveDirectory")%>' />
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <label>Telefone:</label>
                                <asp:TextBox ID="txbTel" CssClass="form-control " runat="server" Text='<%# Bind("telefone")%>' Enabled="false" />
                            </div>

                            <div class="col-xs-12 col-md-6">
                                <label>Ramal:</label>
                                <asp:TextBox ID="txbTelefone" CssClass="form-control" runat="server" Text='<%# Bind("ramal")%>' Enabled="False" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <label>E-mail:</label>
                                <asp:TextBox ID="txbEmail" CssClass="form-control" runat="server" Text='<%# Bind("email")%>' Enabled="False" />
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <label>Perfil usuário:</label>
                                <asp:DropDownList ID="ddlPerfil" CssClass="form-control" runat="server" DataSourceID="SqlPerfil"
                                    DataTextField="nomePerfil" DataValueField="idPerfil" Font-Size="9pt" AppendDataBoundItems="True" SelectedValue='<%# Bind("idPerfil")%>'
                                    Enabled="False">
                                    <asp:ListItem>------</asp:ListItem>
                                    <asp:ListItem Value=" "></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        
                        <div class="row">
                            
                            
                            <div class="col-xs-12 col-md-6">
                                <label>Master:</label>
                                <div class="checkbox">
                                    <label>
                                        <asp:CheckBox ID="ckbMaster" runat="server" Text="Se marcado o usuário conseguira acessar qualquer unidade." Checked='<%# Bind("master")%>' Enabled="false" />
                                    </label>
                                </div>
                            </div>
                        </div>

                    </ItemTemplate>

                    <EmptyDataTemplate>
                        <asp:ImageButton ID="NewButton1" runat="server" AlternateText="Novo" BorderWidth="0px"
                            CausesValidation="False" CommandName="New" ImageUrl="../App_Themes/SISTEC_WEB_THEME/imagens/new.png"
                            ToolTip="Inserir" />
                        <asp:ImageButton ID="SaveButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save_over.png"
                            ToolTip="Salvar" />
                        <asp:ImageButton ID="CancelButton1" runat="server" CausesValidation="false" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/cancel_over.png"
                            ToolTip="Cancelar" />
                        <asp:ImageButton ID="HelpButton1" runat="server" BorderWidth="0px" ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/help.png"
                            OnClick="Click" ToolTip="Ajuda" />
                        <br />
                        <br />
                        <asp:Label ID="Label" runat="server" Text="Sem dado selecionado. Verifique a aba 'Consulta'"></asp:Label>
                    </EmptyDataTemplate>
                </asp:FormView>  
               
                <asp:Label ID="LabelMsg2" runat="server" Text=""></asp:Label>

                <div runat="server" id="divContentAdd" class="row" visible="false">
                    <div class="col-xs-12">
                        <asp:Button ID="btnMetodoLogin" runat="server" Text="Método de login" CssClass="btn btn-warning btn-div-content" CausesValidation="False" />
                        <asp:Button ID="btnAssociarUnidade" runat="server" Text="Associar Unidades" CssClass="btn btn-warning btn-div-content" CausesValidation="False" />

                        <div id="divAssociarUnidade" class="div-content-add" runat="server" visible="false">
                            <h4>Associar Unidades</h4>
                            <hr />

                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="alert alert-warning" role="alert">
                                        <strong>Registro(s):</strong>
                                        <asp:Label ID="lblTotalUnidades" runat="server" Text="0"></asp:Label>
                                    </div>
                                </div>
                            </div>

                            <asp:ImageButton ID="ImageButtonApply" runat="server" BorderWidth="0px"
                                ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save.png" ToolTip="Salvar" />

                            <div class="row">
                                <div class="col-xs-12 col-md-8">
                                    <label>Unidade:</label>
                                    <div class="input-group">
                                        <asp:DropDownList ID="ddlUnidade" CssClass="form-control required" runat="server" AppendDataBoundItems="True"
                                            DataSourceID="SqlSetores" DataTextField="nomeSetorSenai" DataValueField="id">
                                            <asp:ListItem Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-xs-12 col-md-4">
                                    <label>Default:</label>
                                    <div class="checkbox">
                                        <label>
                                            <asp:CheckBox ID="cbUnidadeDefault" runat="server" Text="(Marcar para unidade principal.)" />
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <br />

                            <div class="row">
                                <div class="col-xs-12">
                                    <asp:GridView ID="gridUsuariosUnidades" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellPadding="4" DataSourceID="SqlUsuariosUnidades" ForeColor="#333333" AllowSorting="True" DataKeyNames="idUsuario, idUnidade"
                                        GridLines="None" PageSize="15" Width="100%" CssClass="gridViewSistec">
                                        <AlternatingRowStyle BackColor="White" ForeColor="#333333" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px">
                                                <ItemTemplate>
                                                    <span class="input-group-btn">
                                                        <asp:LinkButton ID="lnkExcluirServico" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-danger remover-servico" class="btn btn-danger excluir-arquivo">
                                                            <i class="glyphicon glyphicon-remove" title="excluir"></i>
                                                        </asp:LinkButton>
                                                    </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="siglaSetorSenai" HeaderText="Cod. Unidade" SortExpression="siglaSetorSenai">
                                                <ItemStyle Width="150px" HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="nomeSetorSenai" HeaderText="Unidade" SortExpression="nomeSetorSenai" />
                                            <asp:BoundField DataField="UnidadePadrao" HeaderText="Principal" SortExpression="UnidadePadrao">
                                                <ItemStyle Width="50px" HorizontalAlign="Center" />
                                            </asp:BoundField>
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
                                </div>
                            </div>
                        </div>

                        <div id="divMetodoLogin" class="div-content-add" runat="server" visible="true">
                            <h4>Método de login</h4>
                            <hr />

                            <asp:ImageButton ID="btnSave" runat="server" BorderWidth="0px" OnClientClick="return confirm('Confirmar a atualização do MÉTODO DE LOGIN?');"
                                ImageUrl="~/App_Themes/SISTEC_WEB_THEME/imagens/save.png" ToolTip="Salvar" />

                            <asp:HiddenField ID="hfIdUsuario" runat="server" />

                            <div class="row">
                                <div class="col-xs-12 col-md-12">
                                    <label>Metodo de login :</label>
                                    <div class="checkbox">
                                        <label>
                                            <asp:CheckBox ID="cbMetodoLogin" runat="server" Text="Utilizar login de Rede (Active Directory)" 
                                                AutoPostBack="True" />
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <asp:Panel ID="pnlPass" runat="server" Visible="false">
                                <div class="row">
                                    <div class="col-xs-12 col-md-6">
                                        <label>Senha:</label>
                                        <asp:TextBox ID="txbPass1" CssClass="form-control required" runat="server" Text="" TextMode="Password" />
                                        <asp:RequiredFieldValidator ID="rfvPASS"  runat="server" ErrorMessage="Campo obrigatório."
                                            ControlToValidate="txbPass1" Text="Campo obrigatório." CssClass="balao"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-xs-12 col-md-6">
                                        <label>Confirma senha:</label>
                                        <asp:TextBox ID="txbPass2" CssClass="form-control required" runat="server" Text="" TextMode="Password" />
                                        <asp:RequiredFieldValidator ID="rfvPassConfirm" runat="server" ErrorMessage="Campo obrigatório."
                                            ControlToValidate="txbPass2" Text="Campo obrigatório." CssClass="balao"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </asp:Panel>

                        </div>
                    </div>
                </div>

            </div>

            <div id="divConsulta" runat="server" class="div-content">
                <label>Pesquisa:</label>
                <asp:TextBox ID="SearchBox" CssClass="form-control" runat="server" AutoPostBack="True"></asp:TextBox>

                <asp:Button ID="SearchButton" CssClass="btn btn-info" runat="server" Text="Pesquisar" />
                <asp:Button ID="CleanButton" CssClass="btn btn-default" runat="server" Text="Limpar" />
                
                <br />
                <br />
                <asp:Label ID="LabelMsgPesquisa" runat="server"></asp:Label>
                <asp:Panel ID="Panel1" runat="server" ScrollBars="Horizontal">
                    <asp:GridView ID="GridView1" CssClass="gridViewSistec" Width="100%" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id_usu" DataSourceID="SqlUsuariosGrid"
                        ForeColor="#333333" GridLines="None">
                       <AlternatingRowStyle BackColor="White" ForeColor="#333333" />
                        <Columns>
                            <asp:HyperLinkField SortExpression="ID " DataNavigateUrlFields="id_usu" DataNavigateUrlFormatString="~/GerenciamentoSistema/Usuario.aspx?idUsuario={0}" DataTextField="id_usu" HeaderText="ID">
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="50px" HorizontalAlign="Right" />
                            </asp:HyperLinkField>
                            <asp:HyperLinkField SortExpression="Login " DataNavigateUrlFields="id_usu" DataNavigateUrlFormatString="~/GerenciamentoSistema/Usuario.aspx?idUsuario={0}" DataTextField="Login" HeaderText="Login">
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="100px" />
                            </asp:HyperLinkField>
                            <asp:CheckBoxField DataField="master" HeaderText="master" SortExpression="master" ItemStyle-HorizontalAlign="Center">
                                <ItemStyle Width="50px" />
                            </asp:CheckBoxField>
                            <asp:BoundField DataField="nomeSetorSenai" HeaderText="Área" SortExpression="siglaSetorSenai">
                                <ItemStyle Width="250px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="nome" HeaderText="Nome" SortExpression="nome">
                                <ItemStyle Width="250px" />
                            </asp:BoundField>
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#EEEEEE" Font-Bold="True" ForeColor="#333333" />
                        <HeaderStyle BackColor="#EEEEEE" Font-Bold="True" ForeColor="#333333" />
                        <PagerStyle BackColor="#EEEEEE" ForeColor="#333333" HorizontalAlign="Left" Font-Size="Medium" CssClass="gridViewPager" />
                        <RowStyle BackColor="#EEEEEE" ForeColor="#333333" />
                        <SelectedRowStyle Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#DDDDDD" />
                        <SortedAscendingHeaderStyle BackColor="#CCCCCC" />
                        <SortedDescendingCellStyle BackColor="#DDDDDD" />
                        <SortedDescendingHeaderStyle BackColor="#CCCCCC" />
                    </asp:GridView>
                </asp:Panel>
                <br />
                <br />
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlUsuarios" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
        OldValuesParameterFormatString="original_{0}"
        SelectCommand="SELECT u.id_usu, u.Login, u.master, u.ramal, u.nome, u.cargo, u.email, iif(u.cpf is not null, CONCAT(SUBSTRING(u.cpf, 1, 4), '***.***', SUBSTRING(u.cpf, 12, 3)), u.cpf) as cpf,
                logarActiveDirectory, telefone, idPerfil, P.nome as nomePerfil
            FROM Usuarios AS u 
                INNER JOIN PERFIL AS P ON U.idPerfil = P.id
            WHERE U.status = 1 AND u.id_usu = @id_usu"
        DeleteCommand="UPDATE Usuarios SET status = 0, login = login + ' (inativo)' WHERE id_usu = @original_id_usu"
        InsertCommand="INSERT INTO Usuarios (Login, nome, cpf, email, pass, logarActiveDirectory, telefone, idPerfil, master, cargo) 
            VALUES (@Login, @nome, @cpf, @email,  @pass, @logarActiveDirectory, @telefone, @idPerfil, @master, @cargo)"
        UpdateCommand="UPDATE Usuarios SET Login = @Login, master = @master, nome = @nome, cpf = @cpf,
         email = @email, ramal = @ramal, telefone = @telefone, idPerfil = @idPerfil
         WHERE id_usu = @original_id_usu"
        ProviderName="<%$ ConnectionStrings:intranetdadosConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:Parameter Name="original_id_usu" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Login" Type="String" />
            <asp:Parameter Name="nome" Type="String" />
            <asp:Parameter Name="cpf" Type="String" />
            <asp:Parameter Name="cargo" Type="String" DefaultValue="" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="pass" Type="String" />
            <asp:Parameter Name="logarActiveDirectory" Type="Boolean" />
            <asp:Parameter Name="telefone" Type="String" />
            <asp:Parameter Name="idPerfil" />
            <asp:Parameter Name="master" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="id_usu" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Login" Type="String" />
            <asp:Parameter Name="master" Type="Boolean" />
            <asp:Parameter Name="nome" Type="String" />
            <asp:Parameter Name="cpf" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="ramal" Type="String" />
            <asp:Parameter Name="original_id_usu" Type="Int32" />
            <asp:Parameter Name="telefone" Type="String" />
           <asp:Parameter Name="idPerfil" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlUsuariosGrid" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
        OldValuesParameterFormatString="original_{0}"
        SelectCommand="SELECT u.id_usu, u.Login, u.master, uu.idUnidade, u.nome, u.email, s.nomeSetorSenai, s.siglaSetorSenai
            FROM Usuarios AS u
                left JOIN UsuariosUnidades AS uu ON uu.idusuario = u.id_usu AND uu.principal = 1
                left JOIN Unidades AS s ON uu.idUnidade = s.id 
            WHERE status = 1 AND (u.nome LIKE @search OR u.login like @search)
            ORDER BY u.login"
        ProviderName="<%$ ConnectionStrings:intranetdadosConnectionString.ProviderName %>">
        <SelectParameters>
            <asp:Parameter DefaultValue="%" Name="search" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlPerfil" runat="server" SelectCommand="SELECT P.ID AS idPerfil, p.nome as nomePerfil FROM Perfil P WHERE Status = 1 ORDER BY nome" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>" ProviderName="<%$ ConnectionStrings:intranetdadosConnectionString.ProviderName %>"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlServidor" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
        DeleteCommand="DELETE FROM [Servidor] WHERE [Id_Func] = @original_Id_Func" InsertCommand="INSERT INTO [Servidor] ([nome_Func], [sexo], [funcao]) VALUES (@nome_Func, @sexo, @funcao)"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [Id_Func], [nome_Func], [sexo], [funcao] FROM [Servidor] ORDER BY [nome_Func]"
        UpdateCommand="UPDATE [Servidor] SET [nome_Func] = @nome_Func, [sexo] = @sexo, [funcao] = @funcao WHERE [Id_Func] = @original_Id_Func" ProviderName="<%$ ConnectionStrings:intranetdadosConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:Parameter Name="original_Id_Func" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="nome_Func" Type="String" />
            <asp:Parameter Name="sexo" Type="String" />
            <asp:Parameter Name="funcao" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="nome_Func" Type="String" />
            <asp:Parameter Name="sexo" Type="String" />
            <asp:Parameter Name="funcao" Type="String" />
            <asp:Parameter Name="original_Id_Func" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlBolsista" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [Id_bolsista], [nome], [sexo], [curso] FROM [Bolsista] ORDER BY [nome]" ProviderName="<%$ ConnectionStrings:intranetdadosConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlEstagiario" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [Id_estag], [nome], [sexo], [instituicaoensinoestagio] FROM [Estagiario] ORDER BY [nome]" ProviderName="<%$ ConnectionStrings:intranetdadosConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlContratado" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [Id_contratado], [nome], [sexo], [tipo_contrato], [cargofuncao], [grau_instrucao] FROM [Contratado] ORDER BY [nome]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlSetores" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT id, nomeSetorSenai, nome_set FROM Unidades WHERE ativo = 'S' ORDER BY nomeSetorSenai"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlProgramas" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT id_programa, id_grupo, Descricao, Funcao, cod_programa FROM Programas WHERE status = 1 ORDER BY Descricao"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlControleAcesso" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT controleacesso.Cod_programa, controleacesso.id_usu, controleacesso.log_incluir, controleacesso.log_excluir, controleacesso.log_relatorio, controleacesso.log_alterar, controleacesso.log_consultar, p.Descricao FROM controleacesso INNER JOIN Programas AS p ON p.id_programa = controleacesso.Cod_programa WHERE (controleacesso.id_usu = @id_usu) ORDER BY controleacesso.id_usu"
        DeleteCommand="DELETE FROM [controleacesso] WHERE [Cod_programa] = @original_Cod_programa AND [id_usu] = @original_id_usu"
        InsertCommand="INSERT INTO [controleacesso] ([Cod_programa], [id_usu], [log_incluir], [log_excluir], [log_relatorio], [log_alterar], [log_consultar]) VALUES (@Cod_programa, @id_usu, @log_incluir, @log_excluir, @log_relatorio, @log_alterar, @log_consultar)"
        UpdateCommand="UPDATE [controleacesso] SET [log_incluir] = @log_incluir, [log_excluir] = @log_excluir, [log_relatorio] = @log_relatorio, [log_alterar] = @log_alterar WHERE [Cod_programa] = @original_Cod_programa AND [id_usu] = @original_id_usu">
        <DeleteParameters>
            <asp:Parameter Name="original_Cod_programa" Type="Int32" />
            <asp:Parameter Name="original_id_usu" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Cod_programa" Type="Int32" />
            <asp:SessionParameter Name="id_usu" SessionField="id_usu_temp" Type="Int32" />
            <asp:Parameter Name="log_incluir" Type="Boolean" />
            <asp:Parameter Name="log_excluir" Type="Boolean" />
            <asp:Parameter Name="log_relatorio" Type="Boolean" />
            <asp:Parameter Name="log_alterar" Type="Boolean" />
            <asp:Parameter Name="log_consultar" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="id_usu" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="log_incluir" Type="Boolean" />
            <asp:Parameter Name="log_excluir" Type="Boolean" />
            <asp:Parameter Name="log_relatorio" Type="Boolean" />
            <asp:Parameter Name="log_alterar" Type="Boolean" />
            <asp:Parameter Name="original_Cod_programa" Type="Int32" />
            <asp:Parameter Name="original_id_usu" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlUsuariosUnidades" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"
        DeleteCommand="delete from UsuariosUnidades
	        where idUsuario = @idUsuario AND idUnidade = @idUnidade" 
        InsertCommand="insert into UsuariosUnidades (idUsuario, idUnidade, principal)
	        values (@idColaborador, @idUnidadeAssociada, @principal)"
        UpdateCommand="update UsuariosUnidades set principal = @principal where idUsuario = @idColaborador and idUnidade = @idUnidadeAssociada"
        SelectCommand="select uu.idUsuario, uu.idUnidade, u.nomeSetorSenai, u.siglaSetorSenai, uu.principal, iif(uu.principal = 1, 'Sim', 'Não') as UnidadePadrao
	        from UsuariosUnidades as uu
		        inner join Unidades as u on uu.idUnidade = u.id
	        where uu.idUsuario = @idColaborador
	        order by u.nomeSetorSenai asc">
        <SelectParameters>
            <asp:Parameter Name="idColaborador" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="idUsuario" Type="Int32" />
            <asp:Parameter Name="idUnidade" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="idColaborador" Type="Int32" />
            <asp:Parameter Name="idUnidadeAssociada" Type="Int32" />
            <asp:Parameter Name="principal" Type="Boolean" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="idColaborador" Type="Int32" />
            <asp:Parameter Name="idUnidadeAssociada" Type="Int32" />
            <asp:Parameter Name="principal" Type="Boolean" />
        </InsertParameters>
    </asp:SqlDataSource>

                     <%--TELA RELATORIO INICIO--%>

           <div id="divRelatorio" class="div-content" runat="server">

                <div class="container-sm" >

                <h3>Relatórios de Usuario</h3>
                <hr />
                    <br/>
					<br/>
                    </div>
                    

                 <div class="row">
                   <label for="ddlPerfils" class="col-12 col-sm-2  col-form-label">Perfil de usuário:</label>
                    <div class="col-6 col-sm-5">
                    <asp:DropDownList ID="ddlPerfils" runat="server" AppendDataBoundItems="True"  DataSourceID="SqlPerfils" 
                        Enabled="True" class="form-control required" OnSelectedIndexChanged="ddlPerfils_SelectedIndexChanged"
                     DataTextField="nomePerfil" DataValueField="idPerfil" AutoPostBack="True" >
                     </asp:DropDownList>
                     <asp:SqlDataSource ID="SqlPerfils" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>" OldValuesParameterFormatString="original_{0}"
                SelectCommand="SELECT p.id AS idPerfil, p.nome as nomePerfil FROM perfil p WHERE Status = 1  ORDER BY nome">
                <SelectParameters>
                    <asp:Parameter DefaultValue="P" Name="ativo" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>                             
                    </div>
                  </div>

                <div class="row">
           <label for="ddlUnidade" class="col-12 col-sm-2  col-form-label">Unidade:</label>
              <div class="col-6 col-sm-5">
           <asp:DropDownList ID="ddlSetor" runat="server" AppendDataBoundItems="True"  DataSourceID="SqlSetor" 
               Enabled="True" class="form-control required"  OnSelectedIndexChanged="ddlSetor_SelectedIndexChanged"
               DataTextField="gerencia" DataValueField="id"  AutoPostBack="True">             
            </asp:DropDownList>
                <asp:SqlDataSource ID="SqlSetor" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>" OldValuesParameterFormatString="original_{0}"
                SelectCommand="SELECT id, id_set, siglaSetorSenai AS codAreaFiemg, nomeSetorSenai AS gerencia FROM Unidades WHERE ativo = @ativo AND idTipo = 1">
                <SelectParameters>
                    <asp:Parameter DefaultValue="S" Name="ativo" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>                
                  </div>
             </div>

         


                <div class="row">
        <label for="ddlStatus" class="col-12 col-sm-2 col-form-label">Status:</label>
        <div class="col-12 col-sm-3">
            <asp:DropDownList ID="ddlStatus" runat="server" AppendDataBoundItems="True" Enabled="True" class="form-control required" AutoPostBack="True"  OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged" >
                <asp:ListItem Value="1" Text="Ativo"></asp:ListItem>
                <asp:ListItem Value="0" Text="Inativo"></asp:ListItem>             
            </asp:DropDownList>
        </div>
    </div>
              
              <div class="row">
        <label class="col-12 col-sm-2 col-form-label">Pesquisar:</label>
        <div class="col-6 col-sm-5">
             <asp:TextBox ID="caixaPesquisa" CssClass="form-control" placeholder="Buscar por Nome" runat="server" Width="200px" ></asp:TextBox>
            <asp:Button ID="btnPesquisar" CssClass="btn btn-default" runat="server" Text="Consultar" OnClick="btnPesquisar_Click" ></asp:Button>
             <asp:Button ID="btnLimpar" CssClass="btn btn-default" runat="server" Text="Limpar" OnClick="btnLimpar_Click" ></asp:Button>
        <asp:LinkButton ID="btnExportarExcel" Text=" Exportar Relatório" runat="server" class="btn  btn-warning btn-div-content"
                OnClick="btnExportarExcel_Click" >
                <i class="glyphicon glyphicon-print" title="Detalhar"></i> Exportar Relatório  
            </asp:LinkButton>
             <br />
             <br />
        </div>
    </div>
    
       <%--  <div class="form-group row">
            <div class="col-12 col-sm-8 offset-sm-2">
            <br />
            <asp:LinkButton ID="btnExportarExcel" Text=" Exportar Relatório" runat="server" class="btn  btn-warning btn-div-content"
                OnClick="btnExportarExcel_Click" >
                <i class="glyphicon glyphicon-print" title="Detalhar"></i> Exportar Relatório  
            </asp:LinkButton>
            </div>
        </div>--%>
                 <div class="row">
                    <div class="col-12 col-md-12">
                        <div class="alert alert-warning" role="alert">
                            <strong> Total de Usuarios: </strong>
                           <asp:Label ID="lbl_qtdUsuarios" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>



          <asp:Panel ID="Panel3" runat="server" ScrollBars="Horizontal">
                    <asp:GridView ID="GridView3" CssClass="gridViewSistec" Width="100%" runat="server" AllowPaging="True" AllowSorting="True" 
                        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id_usu" DataSourceID="SqlRelatorioUsuarioGrid" 
                        ForeColor="#333333" GridLines="None">
                       <AlternatingRowStyle BackColor="White" ForeColor="#333333" />
                        <Columns>

                            <asp:BoundField DataField="id_usu"  SortExpression="id_usu" HeaderText="ID">
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="50px" HorizontalAlign="Right" />
                            </asp:BoundField>

                            <asp:BoundField SortExpression="Login "  DataField="Login" HeaderText="Login">
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="100px" />
                            </asp:BoundField>

                            <asp:BoundField DataField="nome" HeaderText="Nome" SortExpression="nome" >
                                <ItemStyle Width="100px" />
                                </asp:BoundField>

                            <asp:CheckBoxField DataField="master" HeaderText="Master" SortExpression="master" ItemStyle-HorizontalAlign="Center">
                                <ItemStyle Width="30px" />
                            </asp:CheckBoxField>
                            
                            <asp:BoundField DataField="nomePerfil" HeaderText="Perfil" SortExpression="nomePerfil">
                                <ItemStyle Width="100px" />
                            </asp:BoundField>

                            <asp:BoundField DataField="tipoLogin" HeaderText="Tipo de Login" SortExpression="tipoLogin">
                                <ItemStyle Width="100px" />
                            </asp:BoundField>

                            <asp:BoundField DataField="nomeSetorSenai" HeaderText="Unidade" SortExpression="UnidadePrincipal">
                                <ItemStyle Width="300px" />
                            </asp:BoundField>

                           
                            <asp:BoundField DataField="email" HeaderText="Email " SortExpression="email">
                                <ItemStyle Width="100px" />
                            </asp:BoundField>

                            <asp:BoundField DataField="siglaSetorSenai" HeaderText="Cod/Sigla do Setor " SortExpression="siglaSetorSenai"> 
                                <ItemStyle Width="10px" />
                            </asp:BoundField>

                            <asp:BoundField DataField="idPerfil" HeaderText="ID do Perfil" SortExpression="idPerfil" ItemStyle-HorizontalAlign="Center">
                               <ItemStyle Width="10px" />
                            </asp:BoundField>

                            <asp:BoundField DataField="idUnidade" HeaderText="ID da Unidade" SortExpression="idUnidade" ItemStyle-HorizontalAlign="Center">
                               <ItemStyle Width="10px" />
                            </asp:BoundField>

                           

                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#EEEEEE" Font-Bold="True" ForeColor="#333333" />
                        <HeaderStyle BackColor="#EEEEEE" Font-Bold="True" ForeColor="#333333" />
                        <PagerStyle BackColor="#EEEEEE" ForeColor="#333333" HorizontalAlign="Left" Font-Size="Medium" CssClass="gridViewPager" />
                        <RowStyle BackColor="#EEEEEE" ForeColor="#333333" />
                        <SelectedRowStyle Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#DDDDDD" />
                        <SortedAscendingHeaderStyle BackColor="#CCCCCC" />
                        <SortedDescendingCellStyle BackColor="#DDDDDD" />
                        <SortedDescendingHeaderStyle BackColor="#CCCCCC" />
                    </asp:GridView>
                </asp:Panel>
                <br />
                <br />
                </div>

        <asp:SqlDataSource ID="SqlRelatorioUsuarioGrid" runat="server" ConnectionString="<%$ ConnectionStrings:intranetdadosConnectionString %>"      
        SelectCommand="select u.id_usu , u.Login, u.master , uu.idUnidade , u.nome , u.email , s.siglaSetorSenai,u.idPerfil, p.nome ,s.nomeSetorSenai,
                         iif(u.logarActiveDirectory = 1, 'Rede', 'Local') as tipoLogin , p.nome as nomePerfil , s.nomeSetorSenai as UnidadePrincipal,
                         (STUFF((SELECT CAST(', ' + s.nomeSetorSenai AS VARCHAR(MAX))
                         FROM UsuariosUnidades uu
                         inner join Unidades s on uu.idUnidade = s.id
                         WHERE (uu.idUsuario = u.id_usu)
                         FOR XML PATH ('')), 1, 2, '')) AS UnidadesAcessadas
                         from Usuarios AS u
                               Left JOIN UsuariosUnidades AS uu ON uu.idusuario = u.id_usu AND uu.principal = 1
                               Left JOIN Unidades AS s ON uu.idUnidade = s.id   
                               inner join perfil as p on u.idPerfil = p.id
                           where u.status like @status and u.nome like @search and u.idPerfil like @perfil and uu.idUnidade like @setor  
                        order by u.login"
        ProviderName="<%$ ConnectionStrings:intranetdadosConnectionString.ProviderName %>">
        <SelectParameters>      
            <asp:Parameter DefaultValue="%" Name="search" Type="String" />
           <asp:Parameter DefaultValue="%" Name="perfil" Type="String" />
           <asp:Parameter DefaultValue="%" Name="setor" Type="String" /> 
           <asp:Parameter DefaultValue="1" Name="status" Type="Int16" />  
            <asp:Parameter DefaultValue="45" Name="CIT" Type="String" />  
        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>
