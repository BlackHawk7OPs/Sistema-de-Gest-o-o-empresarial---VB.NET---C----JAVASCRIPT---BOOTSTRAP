Imports System.Data.SqlClient
Imports System.Data
Imports Microsoft.Reporting.WebForms

Partial Class Relatorios_MovimentacaoProdutos_ExibeRelatorio
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        checkLoginSessions() 'Validate if sessions (Login and Setor) are active when loading page

        If Not IsPostBack() Then
            CarregaRelatorio()
        End If

    End Sub

    Public Sub checkLoginSessions()
        'Validate session when loading page
        If Session("Login") Is Nothing Then
            Response.Redirect("~/Default.aspx")
        End If

        'Check if SETOR is selected
        If Session("id_set") = "-" Or Session("id_set") Is Nothing Then
            Response.Redirect("~/Logout.aspx?l=1")
        End If
    End Sub

    Private Sub CarregaRelatorio()

        'Dim strConexao As String = System.Configuration.ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ToString()
        Dim strConexao As String = ConfigurationManager.ConnectionStrings(Session("database")).ConnectionString.ToString()
        Dim oConn As New SqlConnection
        Dim strSQL As New StringBuilder
        Dim oTable As New DataTable()
        Dim oCmd As SqlCommand = Nothing

        Try
            'Busca parametros da QueryString
            Dim dataInicial = Request.QueryString("DataInicial")
            Dim dataFinal = Request.QueryString("DataFinal")
            Dim tipoRelatorio = Request.QueryString("TipoRelatorio")
            Dim restricao = Request.QueryString("Restricao")

            'carregar o relatório
            ReportViewer1.LocalReport.ReportPath = "Relatorios\Estoque\MovimentacaoProdutos\MovimentacaoProdutosAnalitico.rdlc"

            'passar os dados para o relatório abrindo conexão com o banco de dados
            oConn.ConnectionString = strConexao
            oConn.Open()

            'definindo o SQL do relatório
            strSQL.Append(" SELECT ")
            strSQL.Append(" prod_estoque.codigo, Produto_laboratorio.codigo as codigo_cetec, Produto_laboratorio.Nome, Produto_laboratorio.Unidade,  prod_estoque.Qtd_Estoque,  prod_estoque.id_set,  movimenta_estoque.id_prod_lab, movimenta_estoque.Quantidade, movimenta_estoque.Entrada_Saida, movimenta_estoque.data_entradaSaida, movimenta_estoque.id_prod_estoque, Produto_laboratorio.concentracao,  ")
            strSQL.Append(" ( select SUM(case when me.Entrada_Saida = 'E' then me.Quantidade else me.Quantidade * (-1) end)	from movimenta_estoque me where me.id_prod_lab = prod_estoque.id_prod_lab and me.setor = prod_estoque.id_set and me.id_prod_estoque = prod_estoque.id_prod_estoque) as EstoqueAtual ")
            strSQL.Append(" FROM movimenta_estoque INNER JOIN prod_estoque on movimenta_estoque.id_prod_lab = prod_estoque.id_prod_lab and movimenta_estoque.id_prod_estoque = prod_estoque.id_prod_estoque INNER JOIN Produto_laboratorio ON movimenta_estoque.id_prod_lab = Produto_laboratorio.id_prod_lab ")
            strSQL.Append(" WHERE 1=1 ")

            If Not String.IsNullOrEmpty(dataInicial) And Not String.IsNullOrEmpty(dataFinal) Then
                strSQL.Append(String.Format(" and movimenta_estoque.data_entradaSaida between '{0}' and '{1}' ", dataInicial, dataFinal))
            End If

            If restricao.Equals("TodosPF") Then
                strSQL.Append(" and Produto_laboratorio.ProdContrRecFed = 1 ")
            End If

            strSQL.Append(" ORDER BY Produto_laboratorio.Nome, prod_estoque.id_set, movimenta_estoque.data_entradaSaida DESC ")

            oCmd = New SqlCommand(strSQL.ToString, oConn)
            oCmd.CommandText = strSQL.ToString
            oCmd.CommandType = CommandType.Text

            'executando o SQLCommand
            Dim oDataReader As SqlDataReader = oCmd.ExecuteReader(CommandBehavior.CloseConnection)

            'converter o DataReader para DataTable
            oTable.Load(oDataReader)

            'definindo os parametros do relatorio
            If (tipoRelatorio.Equals("Analitico")) Then
                ReportViewer1.LocalReport.SetParameters(New ReportParameter("TipoRelatorio", "Analitico"))
            ElseIf (tipoRelatorio.Equals("Sintetico")) Then
                ReportViewer1.LocalReport.SetParameters(New ReportParameter("TipoRelatorio", "Sintetico"))
            End If

            'definindo o DataSource do relat¢rio
            Dim myReportDataSource As ReportDataSource = New ReportDataSource("MovimentacaoProdutos", oTable)
            ReportViewer1.LocalReport.DataSources.Add(myReportDataSource)

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
End Class
