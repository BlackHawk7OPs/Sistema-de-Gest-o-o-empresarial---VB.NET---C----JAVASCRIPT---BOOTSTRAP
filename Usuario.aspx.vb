Imports System.Data
Imports System.DirectoryServices.AccountManagement
Imports SistecWeb
Imports System.Data.SqlClient
Imports Microsoft.Reporting.WebForms
Imports ClosedXML.Excel
Imports SistecWeb.Database
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class GerenciamentoSistema_Usuario
    Inherits System.Web.UI.Page

    Private master As Boolean

    Protected Sub Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        divCadastro.Visible = True
        divConsulta.Visible = False
        divRelatorio.Visible = False
        btnCadastro_Click(Nothing, Nothing)
    End Sub

    Protected Sub SetPageDatabase() 'Configure all datasource to use database session (multi-database)
        SqlUsuarios.ConnectionString = ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ConnectionString
        SqlUsuariosGrid.ConnectionString = ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ConnectionString
        SqlServidor.ConnectionString = ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ConnectionString
        SqlBolsista.ConnectionString = ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ConnectionString
        SqlEstagiario.ConnectionString = ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ConnectionString
        SqlContratado.ConnectionString = ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ConnectionString
        SqlSetor.ConnectionString = ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ConnectionString
        SqlSetores.ConnectionString = ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ConnectionString
        SqlRelatorioUsuarioGrid.ConnectionString = ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ConnectionString
        SqlProgramas.ConnectionString = ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ConnectionString
        SqlControleAcesso.ConnectionString = ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ConnectionString
        SqlPerfil.ConnectionString = ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ConnectionString
        SqlPerfils.ConnectionString = ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ConnectionString
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            divCadastro.Visible = False
            divRelatorio.Visible = False
            divContentAdd.Visible = False
        End If

        'Validate if sessions (Login and Setor) are active when loading page
        ValidaAcesso.CheckLogin()
        ValidaAcesso.ApplyPageSecurity("38") 'The number is the id_programa for this page

        If Not (IsPostBack) Then

            GridView3.DataBind()
            ddlPerfils.DataBind()
            ddlSetor.DataBind()
            caixaPesquisa.Text.Trim()
            ddlPerfils.Items.Insert(0, New ListItem("Todos os Perfis de Usuarios", "%"))
            ddlSetor.Items.Insert(0, New ListItem("Todas as Unidades", "%"))
            ddlSetor.Items.Insert(1, New ListItem("CIT", "CIT"))

            FiltrosRelatorio()

        End If

        SetPageDatabase() 'Set page database (multi-database)
        LabelMsg.Text = ""  'Reset label content
        LabelMsg2.Text = ""  'Reset label content

        If Not (IsPostBack) Then

            If Not String.IsNullOrEmpty(Request.QueryString("idUsuario")) Then
                Dim id As Integer = IIf(Not String.IsNullOrEmpty(Request.QueryString("idUsuario")), Request.QueryString("idUsuario"), 0)
                CarregarUsuario(id)
            End If
        End If

    End Sub
    Protected Sub btnRelatorio_Click(sender As Object, e As EventArgs) Handles btnRelatorio.Click
        divConsulta.Visible = False
        divCadastro.Visible = False
        divRelatorio.Visible = True

    End Sub


    Protected Sub SqlRelatorioUsuarioGrid_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlRelatorioUsuarioGrid.Selected
        lbl_qtdUsuarios.Text = e.AffectedRows.ToString()
    End Sub
    Private Sub FiltrosRelatorio()
        QueryCIT()
        SqlRelatorioUsuarioGrid.SelectParameters("search").DefaultValue = "%" + caixaPesquisa.Text.Trim + "%"
        Dim search As String = caixaPesquisa.Text.Trim()
        SqlRelatorioUsuarioGrid.SelectParameters("setor").DefaultValue = ddlSetor.SelectedValue
        Dim setor As String = ddlSetor.SelectedItem.Value()
        SqlRelatorioUsuarioGrid.SelectParameters("status").DefaultValue = ddlStatus.SelectedValue
        Dim status As Integer = Convert.ToInt32(ddlStatus.SelectedValue)
        SqlRelatorioUsuarioGrid.SelectParameters("perfil").DefaultValue = ddlPerfils.SelectedValue
        Dim perfil As String = ddlPerfils.SelectedItem.Value()
        Dim CIT As String = ddlSetor.SelectedItem.Value()

        SqlRelatorioUsuarioGrid.DataBind()

        GridView3.DataBind()


    End Sub
    'filtro CIT
    Private Sub QueryCIT()

        Dim CIT As String = ddlSetor.SelectedItem.Value()
        Dim setor As String = ddlSetor.SelectedItem.Value()
        Dim perfil As String = ddlPerfils.SelectedItem.Value()
        Dim search As String = caixaPesquisa.Text.Trim()
        Dim status As Integer = Convert.ToInt32(ddlStatus.SelectedValue)


        Dim sql As String = "select u.id_usu , u.Login, u.master , uu.idUnidade  ,u.nome as Nome, u.email , s.siglaSetorSenai,u.idPerfil, p.nome as nomePerfil ,s.nomeSetorSenai," &
        "     iif(u.logarActiveDirectory = 1, 'Rede', 'Local') as tipoLogin  , s.nomeSetorSenai as UnidadePrincipal," &
        "     (STUFF((SELECT CAST(', ' + s.nomeSetorSenai AS VARCHAR(MAX))" &
        "     FROM UsuariosUnidades uu" &
        "     inner join Unidades s On uu.idUnidade = s.id" &
        "     WHERE(uu.idUsuario = u.id_usu)" &
        "  For XML PATH ('')), 1, 2, '')) AS UnidadesAcessadas" &
        "  from Usuarios As u " &
        "     Left JOIN UsuariosUnidades AS uu ON uu.idusuario = u.id_usu AND uu.principal = 1   " &
        "     Left JOIN Unidades AS s ON uu.idUnidade = s.id                                   " &
        "     inner join perfil as p on u.idPerfil = p.id                                        " &
        "  where  u.status like @status "


        If CIT = "CIT" Then

            sql = sql & "   and s.idUnidade = 45 and u.nome like @search  and u.idPerfil like @perfil "

        ElseIf setor = "%" Then

            sql = sql & "  and u.nome like @search and u.idPerfil like @perfil and uu.idUnidade like @setor  "

        End If

        If CIT = "CIT" Then

            sql = sql & "  and s.idUnidade = 45 and u.nome like @search  and u.idPerfil like @perfil "

        ElseIf perfil = "%" Then
            sql = sql & "  and u.nome like @search and u.idPerfil like @perfil and uu.idUnidade like @setor  "

        End If


        If CIT = "CIT" Then

            sql = sql & "  and s.idUnidade = 45 and u.nome like @search  and u.idPerfil like @perfil "

        ElseIf search = "%" Then
            sql = sql & "  and u.nome like @search and u.idPerfil like @perfil and uu.idUnidade like @setor  "

        End If

        If CIT = "CIT" Then

            sql = sql & "  and s.idUnidade = 45 and u.nome like @search  and u.idPerfil like @perfil "

        ElseIf status = "1" Then
            sql = sql & "  and u.nome like @search and u.idPerfil like @perfil and uu.idUnidade like @setor  "

        End If

        sql = sql & " order by u.login"

        SqlRelatorioUsuarioGrid.SelectCommand = sql.ToString


    End Sub



    'função para filtrar o datagrid partir do filtro Perfils
    Protected Sub ddlPerfils_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlPerfils.SelectedIndexChanged
        FiltrosRelatorio()
        QueryCIT()
    End Sub
    'função para filtrar o datagrid partir do filtro setor
    Protected Sub ddlSetor_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSetor.SelectedIndexChanged

        SqlRelatorioUsuarioGrid.DataBind()
        FiltrosRelatorio()
        QueryCIT()
        GridView3.DataBind()
    End Sub
    'metodo para cunsultar um usuario no gridView
    Protected Sub caixaPesquisa_TextChanged(sender As Object, e As EventArgs) Handles caixaPesquisa.TextChanged
        FiltrosRelatorio()
        QueryCIT()
    End Sub
    Protected Sub btnPesquisar_Click(sender As Object, e As EventArgs) Handles btnPesquisar.Click
        FiltrosRelatorio()
        QueryCIT()
    End Sub
    Protected Sub ddlStatus_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlStatus.SelectedIndexChanged
        FiltrosRelatorio()
        QueryCIT()
    End Sub
    Protected Sub btnLimpar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLimpar.Click
        FiltrosRelatorio()
        QueryCIT()
        caixaPesquisa.Text = ""
    End Sub
    'função Declare  exportar relatorio
    Protected Sub btnExportarExcel_Click(sender As Object, ByVal e As EventArgs)

        Dim perfil As String = ddlPerfils.SelectedItem.Value()
        Dim setor As String = ddlSetor.SelectedItem.Value()
        Dim status As Integer = Convert.ToInt32(ddlStatus.SelectedValue)
        Dim search As String = caixaPesquisa.Text.Trim()
        Dim CIT As String = ddlSetor.SelectedItem.Value()

        Dim conexao = New SqlConnection(ConfigurationManager.ConnectionStrings(HttpContext.Current.Session("database").ToString()).ConnectionString)
        Dim strSQL = New System.Text.StringBuilder()


        strSQL.Append("Select u.id_usu As 'ID do Usuario', u.Login, u.master as Master, uu.idUnidade as 'ID da Unidade', u.nome as Nome, u.email as Email, s.siglaSetorSenai as 'cod/Sigla Setor',u.idPerfil as 'ID do Perfil', ")
        strSQL.Append("iif(u.logarActiveDirectory = 1, 'Rede', 'Local') as 'Tipo de Login', p.nome as 'Perfil de Acesso', s.nomeSetorSenai as 'Unidade Principal',")
        strSQL.Append("(STUFF((SELECT CAST(', ' + s.nomeSetorSenai AS VARCHAR(MAX))")
        strSQL.Append("    FROM UsuariosUnidades uu")
        strSQL.Append("        inner join Unidades s on uu.idUnidade = s.id")
        strSQL.Append("    WHERE (uu.idUsuario = u.id_usu)")
        strSQL.Append(" FOR XML PATH ('')), 1, 2, '')) AS 'Unidades Acessadas'")
        strSQL.Append("    from Usuarios AS u")
        strSQL.Append("        Left JOIN UsuariosUnidades AS uu ON uu.idusuario = u.id_usu AND uu.principal = 1")
        strSQL.Append("        Left JOIN Unidades AS s ON uu.idUnidade = s.id")
        strSQL.Append("        inner join perfil as p on u.idPerfil = p.id")
        strSQL.Append("    where u.status like @status  ")


        If CIT = "CIT" Then
            strSQL.Append(" and s.idUnidade = 45  and u.nome like @search  and u.idPerfil like @perfil  ")
        ElseIf setor <> "%" Then
            strSQL.Append("and u.nome like @search and u.idPerfil like @perfil and uu.idUnidade like @setor ")

        End If

        If CIT = "CIT" Then
            strSQL.Append(" and s.idUnidade = 45  and u.nome like @search  and u.idPerfil like @perfil  ")
        ElseIf perfil <> "%" Then
            strSQL.Append("and u.nome like @search and u.idPerfil like @perfil and uu.idUnidade like @setor ")

        End If

        If CIT = "CIT" Then
            strSQL.Append(" and s.idUnidade = 45  and u.nome like @search  and u.idPerfil like @perfil  ")
        ElseIf search <> "%" Then
            strSQL.Append("and u.nome like @search and u.idPerfil like @perfil and uu.idUnidade like @setor ")

        End If


        strSQL.Append("order by u.login")

        Try

            conexao.Open()

            Dim usuarioSelect = New SqlCommand(strSQL.ToString(), conexao)
            usuarioSelect.Parameters.Clear()
            usuarioSelect.Parameters.Add(New SqlParameter("search", "%" & search & "%"))
            usuarioSelect.Parameters.Add(New SqlParameter("perfil", perfil))
            usuarioSelect.Parameters.Add(New SqlParameter("setor", setor))
            usuarioSelect.Parameters.Add(New SqlParameter("status", "%" & status & "%"))
            usuarioSelect.Parameters.Add(New SqlParameter("CIT", CIT))


            Dim usuario As DataTable = New DataTable()
            Dim Adapter As SqlDataAdapter = New SqlDataAdapter(usuarioSelect)
            Adapter.Fill(usuario)


            Using excel As XLWorkbook = New XLWorkbook()
                excel.Worksheets.Add(usuario, "RelatorioUsuarioExcel")
                Response.Clear()
                Response.Buffer = True
                Response.Charset = ""
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                Response.AddHeader("content-disposition", "attachment;filename=" + "Relatorio de Usuario" + ".xlsx")


                Using MyMemoryStream As System.IO.MemoryStream = New System.IO.MemoryStream()
                    excel.SaveAs(MyMemoryStream)
                    MyMemoryStream.WriteTo(Response.OutputStream)
                    Response.Flush()
                    Response.End()
                End Using
            End Using

        Catch ex As SqlException

            System.Diagnostics.Debug.WriteLine(ex.Message)

        Finally
            conexao.Dispose()
        End Try

    End Sub






    Protected Sub CarregarUsuario(ByVal idUsuario As Integer)
        Session("id_usu_temp") = idUsuario

        SqlUsuarios.SelectParameters("id_usu").DefaultValue = idUsuario
        SqlUsuarios.DataBind()
        FormView1.DataBind()
        FormView1.ChangeMode(FormViewMode.ReadOnly)

        SqlControleAcesso.SelectParameters("id_usu").DefaultValue = idUsuario
        SqlControleAcesso.DataBind()
        divConsulta.Visible = False
        divCadastro.Visible = True
    End Sub

    Protected Sub FormView1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles FormView1.DataBound
        Session("id_usu_temp") = FormView1.DataKey.Value
        Dim rowView As DataRowView = CType(FormView1.DataItem, DataRowView)

        divContentAdd.Visible = False

        If FormView1.CurrentMode = FormViewMode.Edit Then
            divContentAdd.Visible = True
            SqlUsuariosUnidades.SelectParameters("idColaborador").DefaultValue = FormView1.DataKey.Value
            SqlUsuariosUnidades.DataBind()
            gridUsuariosUnidades.DataBind()
        End If

        If FormView1.CurrentMode = FormViewMode.Insert Then
            SqlControleAcesso.SelectParameters("id_usu").DefaultValue = ""
            SqlControleAcesso.DataBind()
        End If

        If Not IsNothing(rowView) Then

            If FormView1.CurrentMode = FormViewMode.ReadOnly Then
                divContentAdd.Visible = True
                SqlUsuariosUnidades.SelectParameters("idColaborador").DefaultValue = FormView1.DataKey.Value
                SqlUsuariosUnidades.DataBind()
                gridUsuariosUnidades.DataBind()
            End If

            Dim help As ImageButton
            help = CType(FormView1.FindControl("HelpButton1"), ImageButton)
            help.OnClientClick = "window.open('../Manual/index.htm')"

            Dim mp As Sistec = CType(Page.Master, Sistec) 'Call masterpage public function
            Call mp.verificaPermissaoBotoes(FormView1)

        End If
    End Sub

    Protected Sub FormView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles FormView1.PreRender

        Dim rowView As DataRowView = CType(FormView1.DataItem, DataRowView)

        If Not IsNothing(rowView) Then
            If FormView1.CurrentMode = FormViewMode.Edit Or FormView1.CurrentMode = FormViewMode.ReadOnly Then
                If hfIdUsuario.Value = "" Then
                    hfIdUsuario.Value = rowView("id_usu")
                    cbMetodoLogin.Checked = rowView("logarActiveDirectory")
                End If
            Else
                hfIdUsuario.Value = ""
                cbMetodoLogin.Checked = False
                pnlPass.Visible = False
            End If

        End If

        Try
            If FormView1.CurrentMode = FormViewMode.Edit Or FormView1.CurrentMode = FormViewMode.ReadOnly Then
                'SETOR
                If Not IsNothing(rowView) AndAlso Not IsNothing(CType(FormView1.FindControl("ddlSetor"), DropDownList).Items.FindByValue(rowView("idUnidade").ToString())) Then
                    CType(FormView1.FindControl("ddlSetor"), DropDownList).SelectedValue = rowView("idUnidade").ToString()
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    '--------------------- Handling Exceptions --------------------- 
    Protected Sub FormView1_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles FormView1.ItemInserted
        'Set the InsetParameter ID for sub_itens the same as the new inserted ID
        ' Use the Exception property to determine whether an exception occurred during the insert operation.
        If e.Exception Is Nothing Then
            If e.AffectedRows = 1 Then
                LabelMsg.Text = "<div class='alert alert-success' role='alert'>Registro inserido com sucesso.</div>"
            Else
                LabelMsg.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao inserir o registro. Local: Banco de dados.</div>"
                ' Use the KeepInInsertMode property to remain in insert mode
                ' when an error occurs during the insert operation.
                e.KeepInInsertMode = True
            End If
        Else
            ' Insert the code to handle the exception.
            LabelMsg.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao inserir o registro. Campos obrigatórios de cor diferenciada devem estar preenchidos. Local: Aplicação</div>"
            ' Use the KeepInInsertMode property to remain in insert mode when an error occurs during the insert operation.
            e.ExceptionHandled = True
            e.KeepInInsertMode = True
        End If
    End Sub

    Protected Sub FormView1_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles FormView1.ItemDeleted
        ' Use the Exception property to determine whether an exception occurred during the delete operatin
        If e.Exception Is Nothing Then
            If e.AffectedRows = 1 Then

                SqlUsuariosGrid.DataBind()
                GridView1.DataBind()
                GridView1.SelectedIndex = -1

                SqlUsuarios.SelectParameters("id_usu").DefaultValue = ""
                SqlUsuarios.DataBind()
                FormView1.DataBind()

                SqlControleAcesso.SelectParameters("id_usu").DefaultValue = ""
                SqlControleAcesso.DataBind()

                'TabContainer1.ActiveTab = TabContainer1.Tabs(1)

                LabelMsg.Text = "<div class='alert alert-success' role='alert'>Registro excluído com sucesso.</div>"
            Else
                LabelMsg.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao remover o registro. Local: Banco de dados.</div>"
                ' Use the KeepInInsertMode property to remain in insert mode when an error occurs during the insert operation.
            End If
        Else
            ' Insert the code to handle the exception.
            LabelMsg.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao remover o registro. Existem sub-itens associados a este registro.</div>"
            ' Use the ExceptionHandled property to indicate that the exception is already handled.
            e.ExceptionHandled = True
        End If
    End Sub

    '--------------------- Search Commands --------------------- 
    Protected Sub SearchButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SearchButton.Click
        'Set the search parameter of the query with the text in textbox
        SqlUsuariosGrid.SelectParameters("search").DefaultValue = "%" + SearchBox.Text + "%"
    End Sub

    Protected Sub CleanButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CleanButton.Click
        'Reset search
        SqlUsuariosGrid.SelectParameters("search").DefaultValue = "%"
        SearchBox.Text = ""
    End Sub

    Protected Sub SqlUsuarios_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlUsuarios.Selected
        Dim objFormView As FormView = FormView1
        Dim objGridview As GridView = GridView1

        'Verifica se algum objeto foi retornado, se não, força o modo de inserção.
        If e.AffectedRows < 1 Then
            objFormView.ChangeMode(FormViewMode.Insert)
            LabelMsgPesquisa.Text = "<div class='alert alert-danger' role='alert'>Não foram encontrados registros.</div>"
            'Verifica se algum objeto foi encontrado e não adicionado e e está no modo de inserção, forçando a seleção.
        ElseIf (IsNothing(objGridview.SelectedDataKey) And objGridview.SelectedIndex >= 0) _
           And objFormView.CurrentMode = FormViewMode.Insert Then

            objGridview.SelectedIndex = -1
        Else
            LabelMsgPesquisa.Text = ""
        End If
    End Sub

    Protected Sub FormView1_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertEventArgs) Handles FormView1.ItemInserting
        If Not PossuiUsuarioBancoDados(CType(FormView1.FindControl("LoginTextBox0"), TextBox).Text) Then
            If Not CType(FormView1.FindControl("cbMetodoLogin"), CheckBox).Checked Then
                e = CarregaPropiedadesCadastroUsuario(e)
            End If
        Else
            e.Cancel = True
            LabelMsg.Text = "<div class='alert alert-danger' role='alert'>Login já cadastrado na Base de Dados.</div>"
        End If
    End Sub

    Private Function CarregaPropiedadesCadastroUsuario(e As FormViewInsertEventArgs) As FormViewInsertEventArgs
        Dim pass1 As String = CType(FormView1.FindControl("txbPass1"), TextBox).Text
        Dim pass2 As String = CType(FormView1.FindControl("txbPass2"), TextBox).Text
        '  SqlUsuarios.InsertParameters("tipoLogin").DefaultValue = IIf(CType(FormView1.FindControl("rbTipoLogin"), RadioButtonList).SelectedValue = True, 1, 0)

        If pass1 <> pass2 Then
            e.Cancel = True
            LabelMsg.Text = "<div class='alert alert-danger' role='alert'>As senhas não conferem! Favor digitá-las novamentes.</div>"
        ElseIf String.IsNullOrEmpty(pass1) And String.IsNullOrEmpty(pass2) Then
            e.Cancel = True
            LabelMsg.Text = "<div class='alert alert-danger' role='alert'>Usuário não pode ser criado sem senha.</div>"
        Else
            e.Values("pass") = sistecCommon.getSHA1Hash(pass1)
        End If

        Dim id As Integer = e.Values("idUnidade")
        Return e
    End Function

    Private Function PossuiUsuarioBancoDados(pLogin As Object) As Boolean
        'Set connection string
        Dim connStr As String = ConfigurationManager.ConnectionStrings(Session("database")).ConnectionString
        'Create object for connection string
        Dim sqlConn As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim retorno As Boolean

        Try
            'Open connection
            sqlConn.Open()
            'Create object command for connection string
            Dim sqlCmd As New System.Data.SqlClient.SqlCommand()
            sqlCmd.Connection = sqlConn

            'Set query on command object
            sqlCmd.CommandText = "SELECT u.id_usu, u.Login, u.idUnidade, u.nome, u.master, u.dat_acesso, u.logarActiveDirectory " &
                                 " FROM Usuarios AS u " &
                                 " WHERE u.login = '" & pLogin & "'"

            'Create data reader object
            Dim result As System.Data.SqlClient.SqlDataReader

            'Execute query sending results to the data reader
            result = sqlCmd.ExecuteReader

            If result.Read() = True Then
                retorno = True
            Else
                retorno = False
            End If

        Catch e As Exception
            retorno = False
        End Try

        Return retorno

    End Function

    Protected Sub btnCadastro_Click(sender As Object, e As EventArgs) Handles btnCadastro.Click
        divConsulta.Visible = False
        divCadastro.Visible = True
        divRelatorio.Visible = False

    End Sub
    Protected Sub btnConsulta_Click(sender As Object, e As EventArgs) Handles btnConsulta.Click
        SqlUsuariosGrid.DataBind()
        GridView1.DataBind()
        divConsulta.Visible = True
        divCadastro.Visible = False
        divRelatorio.Visible = False
    End Sub
    Protected Sub CancelButton1_Click(sender As Object, e As ImageClickEventArgs)

    End Sub

    Protected Sub SaveButton1_Click(sender As Object, e As ImageClickEventArgs)
        If CType(FormView1.FindControl("cbMetodoLogin"), CheckBox).Checked Then
            If FormView1.CurrentMode = FormViewMode.Insert Or FormView1.CurrentMode = FormViewMode.Edit Then
                Using pc As New PrincipalContext(ContextType.Domain, "cetecmg.local")
                    'Using pc As New PrincipalContext(ContextType.Domain, "fiemg.com.br")
                    Dim IsValid As Boolean = pc.ValidateCredentials("sistecapp", "4NGGsY9'hLy+n6ZS")
                    Dim user As UserPrincipal

                    If IsValid Then
                        user = UserPrincipal.FindByIdentity(pc, CType(FormView1.FindControl("LoginTextBox0"), TextBox).Text)
                        If Not IsNothing(user) Then
                            If (user.Description IsNot Nothing) Then
                                SqlUsuarios.InsertParameters("cargo").DefaultValue = user.Description
                                'CType(FormView1.FindControl("TextBox3"), TextBox).Text = user.Description
                            End If
                        End If
                    End If

                End Using
            End If
        End If
    End Sub

    Protected Sub SaveButton1_Click1(sender As Object, e As ImageClickEventArgs)
        If CType(FormView1.FindControl("cbMetodoLogin"), CheckBox).Checked Then
            If FormView1.CurrentMode = FormViewMode.Insert Or FormView1.CurrentMode = FormViewMode.Edit Then
                Using pc As New PrincipalContext(ContextType.Domain, "cetecmg.local")
                    'Using pc As New PrincipalContext(ContextType.Domain, "fiemg.com.br")
                    Dim IsValid As Boolean = pc.ValidateCredentials("sistecapp", "4NGGsY9'hLy+n6ZS")
                    Dim user As UserPrincipal

                    If IsValid Then
                        user = UserPrincipal.FindByIdentity(pc, CType(FormView1.FindControl("LoginTextBox0"), TextBox).Text)
                        If Not IsNothing(user) Then
                            SqlUsuarios.UpdateCommand = "UPDATE Usuarios SET Login = @Login, master = @master, idUnidade = @idUnidade, nome = @nome, cargo = @cargo, email = @email, ramal = @ramal , logarActiveDirectory = @logarActiveDirectory, telefone = @telefone , idPerfil = @idPerfil WHERE id_usu = @original_id_usu"
                            If (user.Description IsNot Nothing) Then
                                SqlUsuarios.InsertParameters("cargo").DefaultValue = user.Description
                                CType(FormView1.FindControl("TextBox1"), TextBox).Text = user.Description
                            End If
                        End If
                    End If
                End Using
            End If
        End If
    End Sub

    Protected Sub SearchBox_TextChanged(sender As Object, e As EventArgs) Handles SearchBox.TextChanged
        SqlUsuariosGrid.SelectParameters("search").DefaultValue = "%" + SearchBox.Text + "%"
    End Sub

    Protected Sub cbMetodoLogin_CheckedChanged(sender As Object, e As EventArgs)
        Dim cbMetodoLogin = CType(sender, CheckBox)

        CType(FormView1.FindControl("pnlPass"), Panel).Visible = Not cbMetodoLogin.Checked
        CType(FormView1.FindControl("rfvPASS"), RequiredFieldValidator).Enabled = Not cbMetodoLogin.Checked
        CType(FormView1.FindControl("rfvPassConfirm"), RequiredFieldValidator).Enabled = Not cbMetodoLogin.Checked
    End Sub

    Protected Sub cbMetodoLogin_CheckedChanged1(sender As Object, e As EventArgs) Handles cbMetodoLogin.CheckedChanged
        Dim cbMetodoLogin = CType(sender, CheckBox)

        Dim ad As Boolean = cbMetodoLogin.Checked
        Dim action As Boolean = False

        If ad Then
            Using pc As New PrincipalContext(ContextType.Domain, "cetecmg.local")
                'Using pc As New PrincipalContext(ContextType.Domain, "fiemg.com.br")
                Dim IsValid As Boolean = pc.ValidateCredentials("sistecapp", "4NGGsY9'hLy+n6ZS")
                Dim user As UserPrincipal

                If IsValid Then
                    user = UserPrincipal.FindByIdentity(pc, CType(FormView1.FindControl("LoginTextBox0"), TextBox).Text)
                    If Not IsNothing(user) Then
                        action = False
                    Else
                        action = True
                        LabelMsg2.Text = "<div class='alert alert-danger' role='alert'>Login de rede (AD) não conferi.</div>"
                    End If
                End If
            End Using
        Else
            action = True
        End If

        cbMetodoLogin.Checked = Not action
        pnlPass.Visible = action
        rfvPASS.Enabled = action
        rfvPassConfirm.Enabled = action
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As ImageClickEventArgs) Handles btnSave.Click

        Dim pass As String = Trim(txbPass1.Text.ToString())
        Dim idUsuario As Integer = IIf(IsNumeric(hfIdUsuario.Value), hfIdUsuario.Value, 0)
        Dim metodoLoginAD As Boolean = cbMetodoLogin.Checked

        If ValidarDadosMetodoLogin() Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings(Session("database")).ConnectionString
            Dim sqlConn As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connStr)

            Try
                'Abri conexão
                sqlConn.Open()

                Dim sqlCmd As New System.Data.SqlClient.SqlCommand()
                Dim result As System.Data.SqlClient.SqlDataReader
                sqlCmd.Connection = sqlConn

                sqlCmd.CommandText = "UPDATE Usuarios " &
                    " SET  logarActiveDirectory = '" & metodoLoginAD & "', pass = '" & sistecCommon.getSHA1Hash(pass) & "' " &
                    " WHERE id_usu = " & idUsuario

                result = sqlCmd.ExecuteReader

                If result.RecordsAffected = 1 Then
                    LabelMsg2.Text = "<div class='alert alert-success' role='alert'>Método de login atualizado.</div>"
                    pnlPass.Visible = False
                Else
                    LabelMsg2.Text = Returns.ErroUpdate()
                End If

                result.Close()
            Catch ex As Exception
                LabelMsg2.Text = Returns.ErroUpdate()
            Finally
                sqlConn.Close()
            End Try
        End If

        SqlUsuarios.DataBind()
        FormView1.DataBind()

    End Sub

    Private Function ValidarDadosMetodoLogin() As Boolean
        Dim pass As String = Trim(txbPass1.Text.ToString())
        Dim passRepeat As String = Trim(txbPass2.Text.ToString())
        Dim idUsuario As Integer = IIf(IsNumeric(hfIdUsuario.Value), hfIdUsuario.Value, 0)
        Dim metodoLoginAD As Boolean = cbMetodoLogin.Checked

        If metodoLoginAD Then
            Return True
        Else
            If pass <> passRepeat Then
                LabelMsg2.Text = "<div class='alert alert-danger' role='alert'>As senhas não conferem! Favor digitá-las novamentes.</div>"
                Return False
            ElseIf String.IsNullOrEmpty(pass) And String.IsNullOrEmpty(passRepeat) Then
                LabelMsg2.Text = "<div class='alert alert-danger' role='alert'>Usuário não pode ser criado sem senha.</div>"
                Return False
            Else
                'pass = sistecCommon.getSHA1Hash(pass)
                Return True
            End If
        End If

        Return False
    End Function

    Protected Sub FormView1_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles FormView1.ItemUpdated
        If e.Exception Is Nothing Then
            If e.AffectedRows = 1 Then
                LabelMsg.Text = "<div class='alert alert-success' role='alert'>Alterações salvas.</div>"
            Else
                LabelMsg.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao salvar o registro. Local: Banco de dados.</div>"
            End If
        Else
            ' Insert the code to handle the exception.
            LabelMsg.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao salvar o registro. Local: Aplicação</div>"
            ' Use the KeepInInsertMode property to remain in insert mode when an error occurs during the insert operation.
            e.ExceptionHandled = True
        End If
    End Sub

    Protected Sub ImageButtonApply_Click(sender As Object, e As ImageClickEventArgs) Handles ImageButtonApply.Click
        Dim idUnidade As Integer = ddlUnidade.SelectedValue
        Dim id As Integer = IIf(Not String.IsNullOrEmpty(Request.QueryString("idUsuario")), Request.QueryString("idUsuario"), 0)
        Dim unidadeDefault As Boolean = cbUnidadeDefault.Checked

        Try
            If (ValidarAssociacaoUnidade(id, idUnidade)) Then

                SqlUsuariosUnidades.InsertParameters("idColaborador").DefaultValue = id
                SqlUsuariosUnidades.InsertParameters("idUnidadeAssociada").DefaultValue = idUnidade
                SqlUsuariosUnidades.InsertParameters("principal").DefaultValue = unidadeDefault

                SqlUsuariosUnidades.Insert()
            Else
                SqlUsuariosUnidades.UpdateParameters("idColaborador").DefaultValue = id
                SqlUsuariosUnidades.UpdateParameters("idUnidadeAssociada").DefaultValue = idUnidade
                SqlUsuariosUnidades.UpdateParameters("principal").DefaultValue = unidadeDefault

                SqlUsuariosUnidades.Update()
                'LabelMsg2.Text = "<div class='alert alert-danger' role='alert'>Não foi possível associar a unidade ao usuário. Talvez essa unidade já esteja associada.</div>"
            End If

            If (unidadeDefault) Then
                AtualizarUnidadePrincipal(id, idUnidade, unidadeDefault)
            End If

        Catch ex As Exception
            LabelMsg2.Text = "<div class='alert alert-danger' role='alert'>Não foi possível associar a unidade ao usuário.</div>"
        End Try

        SqlUsuariosUnidades.DataBind()
        gridUsuariosUnidades.DataBind()
    End Sub

    Private Sub AtualizarUnidadePrincipal(ByVal idColaborador As Integer, ByVal idUnidade As Integer, ByVal principal As Boolean)
        Dim connStr As String = ConfigurationManager.ConnectionStrings(Session("database")).ConnectionString
        'Create object for connection string
        Dim sqlConn As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connStr)

        Try
            sqlConn.Open()

            Dim sqlCmd As New System.Data.SqlClient.SqlCommand()
            Dim result As System.Data.SqlClient.SqlDataReader

            sqlCmd.Connection = sqlConn

            sqlCmd.CommandText = "update UsuariosUnidades set principal = 0 where idUsuario = '" & idColaborador & "'; " &
                " update UsuariosUnidades set principal = '" & principal & "' where idUsuario = '" & idColaborador & "' and idUnidade = '" & idUnidade & "'"
            result = sqlCmd.ExecuteReader
            result.Close()
            sqlConn.Close()
        Catch ex As Exception
            sqlConn.Close()
        End Try
    End Sub

    Private Function ValidarAssociacaoUnidade(ByVal idColaborador As Integer, ByVal idUnidade As Integer) As Boolean
        Dim connStr As String = ConfigurationManager.ConnectionStrings(Session("database")).ConnectionString
        'Create object for connection string
        Dim sqlConn As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim varReturn As Boolean = False
        Try
            'Abri conexão
            sqlConn.Open()

            Dim sqlCmd As New System.Data.SqlClient.SqlCommand()
            Dim result As System.Data.SqlClient.SqlDataReader

            sqlCmd.Connection = sqlConn

            sqlCmd.CommandText = "select * from UsuariosUnidades where idUsuario = " & idColaborador & " AND idUnidade = " & idUnidade
            result = sqlCmd.ExecuteReader

            If (result.Read()) Then
                varReturn = False
            Else
                varReturn = True
            End If

            result.Close()
            sqlConn.Close()

        Catch ex As Exception
            sqlConn.Close()
            LabelMsg2.Text = "<div class='alert alert-danger' role='alert'>Não foi possível associar a unidade ao usuário.</div>"
        End Try

        Return varReturn
    End Function

    Protected Sub SqlUsuariosUnidades_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlUsuariosUnidades.Selected
        lblTotalUnidades.Text = e.AffectedRows.ToString()
    End Sub

    Protected Sub btnMetodoLogin_Click(sender As Object, e As EventArgs) Handles btnMetodoLogin.Click
        divMetodoLogin.Visible = True
        divAssociarUnidade.Visible = False
    End Sub

    Protected Sub btnAssociarUnidade_Click(sender As Object, e As EventArgs) Handles btnAssociarUnidade.Click
        divMetodoLogin.Visible = False
        divAssociarUnidade.Visible = True
    End Sub
End Class
