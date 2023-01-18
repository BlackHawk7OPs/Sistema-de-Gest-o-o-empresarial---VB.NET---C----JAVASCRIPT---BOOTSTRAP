'By Murillo Bortot (murillobortot@gmail.com)'

Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.Common


'Imports System.Diagnostics

Partial Class Cadastros_Grupos_SubGrupos_Servicos
    Inherits System.Web.UI.Page

    Private sincronizeLoad_ As Boolean = False
    Private sincronizeBind_ As Boolean = False

    Protected Sub Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        'divConsulta.Visible = False
        'divCadastro.Visible = True


        'btnCadastro_Click(Nothing, Nothing)

    End Sub

    Protected Sub SetPageDatabase() 'Configure all datasource to use database session (multi-database)
        SqlGrupo.ConnectionString = ConfigurationManager.ConnectionStrings(Session("database")).ConnectionString
        SqlSubGrupo.ConnectionString = ConfigurationManager.ConnectionStrings(Session("database")).ConnectionString
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        'Validate if sessions (Login and Setor) are active when loading page
        ValidaAcesso.CheckLogin()
        ValidaAcesso.ApplyPageSecurity(12)

        SetPageDatabase() 'Set page database (multi-database)
        Label1.Text = vbNullString 'Reset label content
        LabelMsgPesquisa.Text = vbNullString

        'Check permissions for this page (Check table programas)
        'Call mp.ApplyPageSecurity("12") 'The number is the id_programa for this page

        'Hide tools panel when loading the page
        If Not (IsPostBack) Then
            PanelTools.Visible = False

            'CType(FormView1.FindControl("TextBox1"), TextBox) _
            '.Attributes.Add("onblur", "IsEmptyTextBox_onblur(this)")

            Me.sincronizeLoad_ = True
        End If

       
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged

        ' Get the currently selected row using the SelectedRow property.
        ' Dim row As GridViewRow = GridView1.SelectedRow
        ' Get value of the selected item in the GridView
        Dim value As Integer = GridView1.SelectedDataKey.Value

        Dim i As Integer = 0
        Dim count As String = FormView1.DataItemCount.ToString

        'Go throught the itens of the FormView and stop when find the one selected in the search
        For i = 0 To count
            FormView1.PageIndex = i
            FormView1.DataBind()
            If FormView1.DataKey.Value = value Then
                Exit For
            End If
        Next

        'SqlGrupo.SelectParameters("id_grupo").DefaultValue = value
        'SqlGrupo.DataBind()



        ' Set the sql select parameter
        SqlSubGrupo.SelectParameters("id_grupo").DefaultValue = value
        ' Create a session to pass the value of the selected id 
        Session("id_grupo_temp") = value
        'Bind the element (refresh) to show the records of the informed id
        FormView1.DataBind()

        'Put the Form in ReadOnly mode in case of the user forget editMode active
        FormView1.ChangeMode(FormViewMode.ReadOnly)

        ' Activate Tab Containet Tab
        'TabContainer1.ActiveTab = TabContainer1.Tabs(0)


        FormView1.ChangeMode(FormViewMode.ReadOnly)
        divCadastro.Visible = True
        divConsulta.Visible = False


    End Sub
    Protected Sub btnCadastro_Click(sender As Object, e As EventArgs) Handles btnCadastro.Click
        divCadastro.Visible = True
        divConsulta.Visible = False
    End Sub

    Protected Sub btnConsulta_Click(sender As Object, e As EventArgs) Handles btnConsulta.Click
        divCadastro.Visible = False
        divConsulta.Visible = True
    End Sub




    Protected Sub FormView1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles FormView1.DataBound
        ' Set the sql select parameter with the first value that comes from default
        Session("id_grupo_temp") = FormView1.DataKey.Value
        'verifica se o grid não esta vazio se sim oculta o formView2
        If (FormView1.DataItemCount = 0) Then
            FormView2.Visible = False
        Else
            FormView2.Visible = True
        End If


        Dim help As ImageButton
        help = CType(FormView1.FindControl("HelpButton1"), ImageButton)
        help.OnClientClick = "window.open('../Manual/index.htm')"

        SqlSubGrupo.SelectParameters("id_grupo").DefaultValue = Session("id_grupo_temp")
        FormView2.DataBind()

        'Sincroniza o Form e Grid principais
        If (Not IsNothing(FormView1.DataKey.Value) And Me.sincronizeLoad_) _
            Or Me.sincronizeBind_ Then

            sistecCommon.updateValueIndexGrid(GridView1, FormView1.DataKey.Value)
            GridView1.DataBind()
            GridView3.DataBind()

            Me.sincronizeLoad_ = False
            Me.sincronizeBind_ = False
        End If
        'Call masterpage public function
        ValidaAcesso.ButtonPermissionOLD(FormView1)
    End Sub



    Protected Sub FormView2_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles FormView2.DataBound
        SqlSubGrupo.InsertParameters("id_grupo").DefaultValue = Session("id_grupo_temp")
    End Sub

    Protected Sub FormView1_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles FormView1.ItemCommand
        'Hide the second controler for the user when he is inserting a new key registry 
        If (e.CommandName = "New") Then
            FormView2.ChangeMode(FormViewMode.ReadOnly)
        Else
            FormView2.ChangeMode(FormViewMode.Insert)
        End If
    End Sub


    Protected Sub SqlGrupo_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlGrupo.Selected
        Dim objFormView As FormView = FormView1
        Dim objGridview As GridView = GridView1

        'Verifica se algum objeto foi retornado, se não, força o modo de inserção.
        If e.AffectedRows < 1 Then
            'objFormView.ChangeMode(FormViewMode.Insert)
            LabelMsgPesquisa.Text = "<div class='alert alert-danger' role='alert'>Não foram encontrados registros.</div>"
            'Verifica se algum objeto foi encontrado e não adicionado e e está no modo de inserção, forçando a seleção.
        ElseIf (IsNothing(objGridview.SelectedDataKey) And objGridview.SelectedIndex >= 0) _
           And objFormView.CurrentMode = FormViewMode.Insert Then

            objGridview.SelectedIndex = -1
        Else
            LabelMsgPesquisa.Text = ""
        End If

    End Sub

    Protected Sub SqlGrupo_Inserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles SqlGrupo.Inserting
        'Insert a Parameter to the SQLInsertCommand to obtain the last inserted ID
        Dim insertedKey As SqlParameter
        insertedKey = New SqlParameter("@PK_New", SqlDbType.Int)
        'Set parameter direction to Output
        insertedKey.Direction = ParameterDirection.Output
        'Add the parammeter
        e.Command.Parameters.Add(insertedKey)
    End Sub

    Protected Sub SqlGrupo_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlGrupo.Inserted
        'Get Last Inserted ID using the parameter inserted (X_Inserting)'
        Dim NewID As Integer = 0
        'Create a DbCommand variable
        Dim command As DbCommand
        command = e.Command
        ' The label(or variable) displays the primary key of the recently inserted row.
        NewID = command.Parameters("@PK_New").Value
        'Set Session temp id
        Session("id_grupo_temp") = NewID

    End Sub

    Protected Sub FormView1_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles FormView1.ItemInserted
        'Set the InsetParameter ID for sub_itens the same as the new inserted ID
        ' Use the Exception property to determine whether an exception occurred during the insert operation.
        If e.Exception Is Nothing Then

            If e.AffectedRows = 1 Then
                Label1.Text = "<div class='alert alert-success' role='alert'>Registro inserido com sucesso.</div>"

                'Atualiza o Grid e mantém a referência ao objeto inserido
                Me.sincronizeBind_ = True

            Else
                Label1.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao salvar o registro. Local: Banco de dados.</div>"
                ' Use the KeepInInsertMode property to remain in insert mode
                ' when an error occurs during the insert operation.
                e.KeepInInsertMode = True
            End If
        Else
            ' Insert the code to handle the exception.
            Label1.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao salvar o registro. Local: Aplicação</div>"
            ' Use the KeepInInsertMode property to remain in insert mode when an error occurs during the insert operation.
            e.ExceptionHandled = True
            e.KeepInInsertMode = True
        End If
    End Sub

    Protected Sub SqlGrupo_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlGrupo.Deleted
        'Desabilitado por Alax William em 20/09/11 pois foi acrescentado 
        'Dim valueKey As Integer

        'Atualiza e sincroniza formulario e grid
        'sistecCommon.updateFormGrid(FormView1, GridView1, True)

        'valueKey = GridView1.SelectedDataKey.Value


        ' Set the sql select parameter to refresh sub table
        'SqlSubGrupo.SelectParameters("id_grupo").DefaultValue = valueKey
        ' Create a session to pass the value of the selected id 
        'Session("id_grupo_temp") = valueKey

    End Sub

    Protected Sub FormView1_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewDeletedEventArgs) Handles FormView1.ItemDeleted
        ' Use the Exception property to determine whether an exception occurred during the delete operatin
        If e.Exception Is Nothing Then

            If e.AffectedRows = 1 Then
                Label1.Text = "<div class='alert alert-success' role='alert'>Registro excluido com sucesso.</div>"
            Else 'Obs: Não é erro, verificar mensagem correta
                Label1.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao remover o registro. Local: Banco de dados.</div>"
                ' Use the KeepInInsertMode property to remain in insert mode when an error occurs during the insert operation.
            End If

        Else 'ThrowsException 

            'Verify SqlException
            If TypeOf e.Exception Is SqlException Then
                'Verify Exception Constraint
                If TryCast(e.Exception, SqlException).Number.Equals(547) Then

                    ' Insert the code to handle the exception.
                    Label1.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao remover o registro. Existem sub-itens associados a este registro.</div>"
                    ' Use the ExceptionHandled property to indica   te that the exception is already handled.
                Else
                    Label1.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao remover o registro. Local: Banco de dados</div>"
                End If
            ElseIf TypeOf e.Exception Is NullReferenceException Then
                Label1.Text = "<div class='alert alert-success' role='alert'>Registro excluído com sucesso.</div>"
            Else
                Label1.Text = "<div class='alert alert-danger' role='alert'> System Error : " + e.Exception.ToString() + "</div>"
            End If

            e.ExceptionHandled = True

        End If

    End Sub

    Protected Sub SqlGrupo_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlGrupo.Updated
        'Set the InsetParameter ID for sub_itens the same as the new inserted ID
        ' Use the Exception property to determine whether an exception occurred during the insert operation.
        If e.Exception Is Nothing Then
            If e.AffectedRows = 1 Then
                Label1.Text = "<div class='alert alert-success' role='alert'>Alterações salvas.</div>"
            Else
                Label1.Text = "<div class='alert alert-danger' role='alert'> Ocorreu um erro ao salvar o registro. Local: Banco de dados.</div>"
            End If
        Else
            ' Insert the code to handle the exception.
            Label1.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao salvar o registro. Local: Aplicação</div>"
            ' Use the KeepInInsertMode property to remain in insert mode when an error occurs during the insert operation.
            e.ExceptionHandled = True
        End If
    End Sub

    Protected Sub FormView2_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles FormView2.ItemInserted
        'Set the InsetParameter ID for sub_itens the same as the new inserted ID
        ' Use the Exception property to determine whether an exception occurred during the insert operation.
        If e.Exception Is Nothing Then

            If e.AffectedRows = 1 Then
                Label1.Text = "<div class='alert alert-success' role='alert'>Registro inserido com sucesso.</div>"
            Else
                Label1.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao inserir o registro. Local: Banco de dados.</div>"
                ' Use the KeepInInsertMode property to remain in insert mode
                ' when an error occurs during the insert operation.
                e.KeepInInsertMode = True
            End If
        Else
            ' Insert the code to handle the exception.
            Label1.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao inserir o registro. Local: Aplicação</div>"
            ' Use the KeepInInsertMode property to remain in insert mode when an error occurs during the insert operation.
            e.ExceptionHandled = True
            e.KeepInInsertMode = True
        End If
    End Sub

    Protected Sub FormView2_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertEventArgs) Handles FormView2.ItemInserting
        'Insert id_grupo in the insert parameter 
        SqlSubGrupo.InsertParameters("id_grupo").DefaultValue = Session("id_grupo_temp")
    End Sub

    Protected Sub SearchButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SearchButton.Click
        'Set the search parameter of the query with the text in textbox
        SqlGrupo.SelectParameters("search").DefaultValue = "%" + SearchBox.Text + "%"

    End Sub

    Protected Sub CleanButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CleanButton.Click
        'Reset search
        SearchBox.Text = ""
        SqlGrupo.SelectParameters("search").DefaultValue = "%"
    End Sub

    Protected Sub ToolsButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        PanelTools.Visible = True
    End Sub

    Protected Sub CloseButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CloseButton.Click
        PanelTools.Visible = False
    End Sub

    Protected Sub GridView3_RowUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdatedEventArgs) Handles GridView3.RowUpdated
        If e.Exception Is Nothing Then

            If e.AffectedRows = 1 Then
                Label1.Text = "<div class='alert alert-success' role='alert'>Registro alterado com sucesso.</div>"

                Me.sincronizeBind_ = True
            Else
                Label1.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao alterar o registro. Local: Banco de dados.</div>"
                ' Use the KeepInInsertMode property to remain in insert mode
                ' when an error occurs during the insert operation.
                e.KeepInEditMode = True
            End If
        ElseIf TypeOf e.Exception Is SqlException Then
            'Verify Exception Constraint
            If TryCast(e.Exception, SqlException).Number.Equals(515) Then

                ' Insert the code to handle the exception.
                Label1.Text = "<font color='red'>Ocorreu um erro ao alterar o registro. Existem campos em branco que devem estar preenchidos. Local: Aplicação.</font>"
                ' Use the ExceptionHandled property to indica   te that the exception is already handled.
                e.ExceptionHandled = True
                e.KeepInEditMode = True
            End If
        Else
            ' Insert the code to handle the exception.
            Label1.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao alterar o registro.  Verifique se os campos estão preenchidos corretamente. Local: Aplicação</div>"
            ' Use the KeepInInsertMode property to remain in insert mode when an error occurs during the insert operation.
            e.ExceptionHandled = True
            e.KeepInEditMode = True
        End If
    End Sub


    'Protected Sub btnCadastro_Click(sender As Object, e As EventArgs) Handles btnCadastro.Click
    '    divConsulta.Visible = False
    '    divCadastro.Visible = True


    'End Sub
    'Protected Sub btnConsulta_Click(sender As Object, e As EventArgs) Handles btnConsulta.Click
    '    divConsulta.Visible = True
    '    divCadastro.Visible = False


    'End Sub

    'Protected Sub TabContainer1_ActiveTabChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TabContainer1.ActiveTabChanged

    'End Sub
End Class
