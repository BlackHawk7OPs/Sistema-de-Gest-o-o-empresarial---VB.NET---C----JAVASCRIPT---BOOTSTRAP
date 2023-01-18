Imports System.Data.SqlClient
Imports System.Data

Partial Class Relatorios_EstatisticoEnsaio_LandingPage
    Inherits System.Web.UI.Page

    Dim oTable As New DataTable()

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        'Validate if sessions (Login and Setor) are active when loading page
        Dim mp As MasterPage = CType(Page.Master, MasterPage) 'Call masterpage public function
        Call mp.checkLoginSessions()

        If Not IsPostBack Then

            
            cldDataInicial.SelectedDate = Date.Now.Date.AddYears(-1)
            cldDataInicial.VisibleDate = cldDataInicial.SelectedDate
            cldDataFinal.SelectedDate = Date.Now.Date

            'Calendar Sync
            txtInicio.Text = cldDataInicial.SelectedDate
            txtFim.Text = cldDataFinal.SelectedDate
            CarregarGrid()
        Else
            'Calendar / textbox Sync (solution> Murillo 16/09/2011)
            cldDataInicial.SelectedDate = txtInicio.Text
            cldDataInicial.VisibleDate = cldDataInicial.SelectedDate

            cldDataFinal.SelectedDate = txtFim.Text
            cldDataFinal.VisibleDate = cldDataFinal.SelectedDate
            CarregarGrid()

        End If

    End Sub

    Protected Sub btnEnviar_Click(sender As Object, e As System.EventArgs) Handles btnEnviar.Click

        Dim qryString As String = String.Empty

        Dim erro = Utils.ValidarPeriodo(cldDataInicial.SelectedDate.ToString(), cldDataFinal.SelectedDate.ToString(), Me)

        If Not String.IsNullOrEmpty(erro) Then
            Utils.Alert(Me, erro, "")
            Return
        End If

        qryString += String.Format("DataInicial={0}&", cldDataInicial.SelectedDate.ToString("yyyyMMdd"))
        qryString += String.Format("DataFinal={0}&", cldDataFinal.SelectedDate.ToString("yyyyMMdd"))

        If (rdbTodos.Checked) Then
            qryString += String.Format("TipoFiltro={0}&", "Todos")
        Else
            qryString += String.Format("TipoFiltro={0}&", "Lista")
        End If

        If (rdbCodigoEnsaio.Checked) Then
            qryString += String.Format("Ordem={0}&", "codigoEnsaio")
        ElseIf (rdbNomeEnsaio.Checked) Then
            qryString += String.Format("Ordem={0}&", "nomeEnsaio")
        ElseIf (rdbQuantidade.Checked) Then
            qryString += String.Format("Ordem={0}&", "quantidade")
        End If

        Response.Redirect(String.Format("{0}?{1}", "ExibeRelatorio.aspx", qryString), True)

    End Sub

    Protected Sub CarregarGrid()

        Dim strConexao As String = System.Configuration.ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ToString()
        Dim oConn As New SqlConnection
        Dim strSQL As New StringBuilder
        Dim oCmd As SqlCommand = Nothing

        Try
            'passar os dados para o relatório abrindo conexão com o banco de dados
            oConn.ConnectionString = strConexao
            oConn.Open()

            'definindo o SQL do relatório
            strSQL.Append(" SELECT ")
            strSQL.Append(" Parametros.cod_param as Código, Parametros.nome_par as Parâmetro, Parametros.desc_par as Descrição, normas.metodo as Método ")
            strSQL.Append(" FROM parametros LEFT OUTER JOIN normas ON parametros.id_norma =  normas.id_norma  ")
            strSQL.Append(" where /*parametros.id_set ='" + Session("id_set") + "' and*/ parametros.Inativo in ('N',null) ")
            strSQL.Append(" order by Parametros.Cod_param ")

            oCmd = New SqlCommand(strSQL.ToString, oConn)
            oCmd.CommandText = strSQL.ToString
            oCmd.CommandType = CommandType.Text

            'executando o SQLCommand
            Dim oDataReader As SqlDataReader = oCmd.ExecuteReader(CommandBehavior.CloseConnection)

            'converter o DataReader para DataTable
            oTable.Load(oDataReader)

            grvLista.AutoGenerateColumns = True
            grvLista.DataSource = oTable
            grvLista.DataBind()

        Catch ex As Exception
            System.Diagnostics.Debug.WriteLine(ex.Message)
        Finally
            'liberando os objetos
            oConn.Dispose()
            oTable.Dispose()
            oConn = Nothing
            oTable = Nothing
        End Try

    End Sub

    Protected Sub cldDataInicial_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cldDataInicial.SelectionChanged
        txtInicio.Text = cldDataInicial.SelectedDate
    End Sub

    Protected Sub cldDataFinal_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cldDataFinal.SelectionChanged
        txtFim.Text = cldDataFinal.SelectedDate
    End Sub
End Class
