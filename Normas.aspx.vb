Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.Common

Partial Class CadastroBasico_Normas
    Inherits System.Web.UI.Page
    Protected Sub Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
       
    End Sub

    Protected Sub SetPageDatabase() 'Configure all datasource to use database session (multi-database)
        SqlNorma.ConnectionString = ConfigurationManager.ConnectionStrings(Session("database")).ConnectionString
        SqlSetores.ConnectionString = ConfigurationManager.ConnectionStrings(Session("database")).ConnectionString
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        'Validate if sessions (Login and Setor) are active when loading page
        ValidaAcesso.CheckLogin()
        ValidaAcesso.ApplyPageSecurity(14)

        SetPageDatabase() 'Set page database (multi-database)
        LabelMsg.Text = "" 'Reset label content



        'Hide tools panel when loading the page
        If Not (IsPostBack) Then
            PanelTools.Visible = False
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

        ' Create a session to pass the value of the selected id 
        Session("id_norma_temp") = value
        'Bind the element (refresh) to show the records of the informed id
        FormView1.DataBind()

        'Put the Form in ReadOnly mode in case of the user forget editMode active
        FormView1.ChangeMode(FormViewMode.ReadOnly)
        divCadastro.Visible = True
        divConsulta.Visible = False
    End Sub

    Protected Sub SqlNorma_Inserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles SqlNorma.Inserting
        'Insert a Parameter to the SQLInsertCommand to obtain the last inserted ID
        Dim insertedKey As SqlParameter
        insertedKey = New SqlParameter("@PK_New", SqlDbType.Int)
        'Set parameter direction to Output
        insertedKey.Direction = ParameterDirection.Output
        'Add the parammeter
        e.Command.Parameters.Add(insertedKey)
    End Sub

    Protected Sub SqlNorma_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlNorma.Inserted
        'Get Last Inserted ID using the parameter inserted (X_Inserting)'
        ' Dim NewID As Integer = 0
        'Create a DbCommand variable
        Dim command As DbCommand
        command = e.Command

        'Update the grids and form views
        GridView1.DataBind()
        FormView1.DataBind()
        'FormView1.PageIndex = FormView1.PageCount + 1
    End Sub

    Protected Sub FormView1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles FormView1.DataBound
        Dim help As ImageButton
        help = CType(FormView1.FindControl("HelpButton1"), ImageButton)
        help.OnClientClick = "window.open('../Manual/index.htm')"
        'Call masterpage public function
        ValidaAcesso.ButtonPermissionOLD(FormView1)
    End Sub

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
        ElseIf TypeOf e.Exception Is SqlException Then
            'Verify Exception Constraint
            If TryCast(e.Exception, SqlException).Number.Equals(515) Then

                ' Insert the code to handle the exception.
                LabelMsg.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao inserir o registro. Campos obrigatórios de cor diferenciada devem estar preenchidos. Local: Aplicação.</div>"
                ' Use the ExceptionHandled property to indica   te that the exception is already handled.
                e.ExceptionHandled = True
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
                LabelMsg.Text = "<div class='alert alert-success' role='alert'> Registro excluído com sucesso.</div>"
                SqlNorma.DataBind()
                GridView1.DataBind()
                GridView1.SelectedIndex = -1
                FormView1.DataBind()

                FormView1.ChangeMode(FormViewMode.ReadOnly)
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
    Protected Sub btnCadastro_Click(sender As Object, e As EventArgs) Handles btnCadastro.Click
        divCadastro.Visible = True
        divConsulta.Visible = False
    End Sub

    Protected Sub btnConsulta_Click(sender As Object, e As EventArgs) Handles btnConsulta.Click
        divCadastro.Visible = False
        divConsulta.Visible = True
    End Sub
    Protected Sub SqlNorma_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlNorma.Updated
        'Set the InsetParameter ID for sub_itens the same as the new inserted ID
        ' Use the Exception property to determine whether an exception occurred during the insert operation.
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

    Protected Sub SearchButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SearchButton.Click
        'Set the search parameter of the query with the text in textbox
        SqlNorma.SelectParameters("search").DefaultValue = "%" + SearchBox.Text + "%"
    End Sub

    Protected Sub CleanButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CleanButton.Click
        'Reset search
        SearchBox.Text = ""
        SqlNorma.SelectParameters("search").DefaultValue = "%"
    End Sub

    Protected Sub CloseButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CloseButton.Click
        PanelTools.Visible = False
    End Sub

    Protected Sub ToolsButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        PanelTools.Visible = True
    End Sub
    
    Protected Sub SqlNorma_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlNorma.Selected
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

    Protected Sub FormView1_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles FormView1.ItemUpdated
        If e.Exception Is Nothing Then
            Dim idNorma As Integer = FormView1.SelectedValue

            Dim connStr As String = ConfigurationManager.ConnectionStrings(Session("database")).ConnectionString
            'Create object for connection string
            Dim sqlConn As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Try
                'Abri conexão
                sqlConn.Open()

                Dim sqlCmd As New System.Data.SqlClient.SqlCommand()
                Dim result As System.Data.SqlClient.SqlDataReader

                sqlCmd.Connection = sqlConn

                'Inserindo o registro do ARQUIVO na base de dados
                sqlCmd.CommandText = "EXECUTE SP_AtMetodosServicos @value = " & idNorma & ", @type = 1"
                result = sqlCmd.ExecuteReader
                result.Close()

                'Fechando conexão
                sqlConn.Close()
            Catch ex As Exception
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "dialog", "apprise('Não foi possível atualizar serviços associados...')", True)
            End Try

            If e.AffectedRows = 1 Then
                LabelMsg.Text = "<div class='alert alert-success' role='alert'>Registro alterado com sucesso.</div>"
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "dialog", "apprise('Registro atualizado com sucesso')", True)
            Else
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "dialog", "apprise('Não foi possível atualizar o registro')", True)
                LabelMsg.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao alterar o registro. Local: Banco de dados.</div>"
                ' Use the KeepInInsertMode property to remain in insert mode
                ' when an error occurs during the insert operation.
                e.KeepInEditMode = True
            End If
        ElseIf TypeOf e.Exception Is SqlException Then
            'Verify Exception Constraint
            If TryCast(e.Exception, SqlException).Number.Equals(515) Then

                ' Insert the code to handle the exception.
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "dialog", "apprise('Ocorreu um erro ao alterar o registro. Campos obrigatórios de cor diferenciada devem estar preenchidos..')", True)
                LabelMsg.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao alterar o registro. Campos obrigatórios de cor diferenciada devem estar preenchidos. Local: Aplicação.</div>"
                ' Use the ExceptionHandled property to indica   te that the exception is already handled.
                e.ExceptionHandled = True
                e.KeepInEditMode = True
            End If
        Else
            ' Insert the code to handle the exception.
            ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "dialog", "apprise('Ocorreu um erro ao alterar o registro. Campos obrigatórios de cor diferenciada devem estar preenchidos')", True)
            LabelMsg.Text = "<div class='alert alert-danger' role='alert'>Ocorreu um erro ao alterar o registro. Campos obrigatórios de cor diferenciada devem estar preenchidos. Local: Aplicação</div>"
            ' Use the KeepInInsertMode property to remain in insert mode when an error occurs during the insert operation.
            e.ExceptionHandled = True
            e.KeepInEditMode = True
        End If
    End Sub
End Class