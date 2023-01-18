Imports Microsoft.Reporting.WebForms
Imports System.Data.SqlClient
Imports System.Data

Partial Class Bloco2_Precos
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
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
            Dim dataInicioGas = Request.QueryString("DataInicioGas")
            Dim dataFimGas = Request.QueryString("DataFimGas")
            Dim dataInicioAmostra = Request.QueryString("DataInicioAmostra")
            Dim dataFimAmostra = Request.QueryString("DataFimAmostra")
            Dim gas = Request.QueryString("GAS")
            Dim certificado = Request.QueryString("Certificado")

            'carregar o relatório
            ReportViewer1.LocalReport.ReportPath = "Relatorios\Bloco2_Precos\Relatorio_Bloco2.rdlc"

            'passar os dados para o relatório abrindo conexão com o banco de dados
            oConn.ConnectionString = strConexao
            oConn.Open()

            'definindo o SQL do relatório
            strSQL.Append(" SELECT ")
            strSQL.Append(" certificados.id_certif, GAS.id_GAS, GAS.preco_bruto_ups, GAS.desconto_UPS, GAS.preco_UPS, GAS.bonus_metrologia, GAS.ID_Orcamento,  rateio_gas.valor_ups as rateio_ups, rateio_gas.id_centroCusto")
            strSQL.Append(" FROM certificados INNER JOIN GAS ON certificados.id_GAS = gas.id_GAS LEFT OUTER JOIN rateio_gas on rateio_gas.id_gas=gas.id_gas LEFT OUTER JOIN objetos ON objetos.id_GAS = GAS.id_GAS")
            strSQL.Append(" WHERE GAS.id_set='" + Session("id_set") + "'")

            If Not String.IsNullOrEmpty(dataInicioGas) And Not String.IsNullOrEmpty(dataFimGas) Then
                strSQL.Append(String.Format(" and GAS.DATA_EMISSAO between '{0}' and '{1}' ", dataInicioGas, dataFimGas))
            End If

            If Not String.IsNullOrEmpty(dataInicioAmostra) And Not String.IsNullOrEmpty(dataFimAmostra) Then
                strSQL.Append(String.Format(" and OBJETOS.DATACHEG_OBJ between '{0}' and '{1}' ", dataInicioAmostra, dataFimAmostra))
            End If

            If Not String.IsNullOrEmpty(gas) Then
                strSQL.Append(String.Format(" and GAS.ID_GAS = {0} ", gas))
            End If

            If Not String.IsNullOrEmpty(certificado) Then
                strSQL.Append(String.Format(" and CERTIFICADOS.ID_CERTIF = {0} ", certificado))
            End If

            'strSQL.Append(" ORDER BY certificados.id_certif,certificados.id_GAS")
            'Murillo -> it was repeating the same is results so I've made a GROUP BY clause
            strSQL.Append("  GROUP BY certificados.id_certif,GAS.id_GAS,GAS.preco_bruto_ups, GAS.desconto_UPS, GAS.preco_UPS, GAS.bonus_metrologia, GAS.ID_Orcamento, rateio_gas.valor_ups, rateio_gas.id_centroCusto ")

            'Label1.Text = strSQL.ToString

            oCmd = New SqlCommand(strSQL.ToString, oConn)
            oCmd.CommandText = strSQL.ToString
            oCmd.CommandType = CommandType.Text

            'executando o SQLCommand
            Dim oDataReader As SqlDataReader = oCmd.ExecuteReader(CommandBehavior.CloseConnection)

            'converter o DataReader para DataTable
            oTable.Load(oDataReader)

            'definindo o DataSource do relat¢rio
            Dim myReportDataSource As ReportDataSource = New ReportDataSource("Bloco2_Precos", oTable)
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