Imports System.Data.SqlClient
Imports System.Data
Imports Microsoft.Reporting.WebForms
Imports System.Reflection
Imports ValidaAcesso

Partial Class Relatorios_ClientesAtendidos_Relatorio
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        ValidaAcesso.CheckLogin()

        If Not IsPostBack() Then
            CarregaRelatorio()
        End If

    End Sub

    Private Sub CarregaRelatorio()

        'Dim strConexao As String = ConfigurationManager.ConnectionStrings("intranetdadosTestes").ToString()
        Dim strConexao As String = ConfigurationManager.ConnectionStrings(Session("database")).ConnectionString.ToString()
        Dim oConn As New SqlConnection
        Dim strSQL As New StringBuilder
        Dim oTable As New DataTable()
        Dim oCmd As SqlCommand = Nothing

        Try
            'Busca parametros da QueryString
            Dim idInstituicao As String = String.Empty
            Dim idSetor As String = String.Empty
            Dim area As String = String.Empty
            Dim ano As Integer = Convert.ToInt32(Request.QueryString("ano"))

            idInstituicao = IIf(Not String.IsNullOrEmpty(Request.QueryString("idInstituicao")), Request.QueryString("idInstituicao"), idInstituicao)
            idSetor = IIf(Not String.IsNullOrEmpty(Request.QueryString("idSetor")), Request.QueryString("idSetor"), idSetor)
            area = IIf(Not String.IsNullOrEmpty(Request.QueryString("area")), Request.QueryString("area"), area)

            ReportViewer1.LocalReport.ReportPath = "Relatorios\ClientesAtendidos\Relatorio.rdlc"

            'setando o parametro IDINSTITUICAO
            'Dim myReportDataSource2 As ReportDataSource = New ReportDataSource("GASClientesDetalhe", oTable2)
            Dim p(3) As ReportParameter
            p(0) = New ReportParameter("idInstituicao", idInstituicao)
            p(1) = New ReportParameter("idSetor", idSetor)
            p(2) = New ReportParameter("area", area)
            p(3) = New ReportParameter("ano", ano)

            ReportViewer1.LocalReport.SetParameters(p)

            'passar os dados para o relatório abrindo conexão com o banco de dados
            oConn.ConnectionString = strConexao
            oConn.Open()

            strSQL.Append("SELECT RIGHT(CONVERT(VARCHAR(10), g.data_emissao, 103), 4) AS ano, COUNT(g.id_GAS) AS atendimento, c.razao_cli, c.fantasia_cli, c.cnpjcpf_cli, c.email_cli, ")
            strSQL.Append("        CONCAT(c.ddd_tel1_cli, '-', c.tel1_cli) AS telCliente, cont.nome_cont, cont.Setor_Departamento, cont.cargo_cont, ")
            strSQL.Append("        cont.email, CONCAT(cont.ddd_tel1, '-', cont.Tel1) AS telContato ")
            strSQL.Append("    FROM gas AS g ")
            strSQL.Append("        INNER JOIN clientes AS c ON g.id_cliente = c.id_cliente ")
            strSQL.Append("        LEFT JOIN Contatos AS cont ON c.id_cliente = cont.id_cliente ")
            strSQL.Append("    WHERE g.idInstituicao = 2 ")

            If idSetor <> "0" Then
                strSQL.Append(" AND g.idUnidade = '" & idSetor & "' ")
            End If

            strSQL.Append(String.Format("      AND (g.data_emissao BETWEEN '{0}-01-01' AND '{0}-12-31') ", ano))

            strSQL.Append("    GROUP BY RIGHT(CONVERT(VARCHAR(10), g.data_emissao, 103), 4), c.razao_cli, c.fantasia_cli, c.cnpjcpf_cli, c.email_cli, CONCAT(c.ddd_tel1_cli, '-', c.tel1_cli), cont.nome_cont, cont.Setor_Departamento, cont.cargo_cont, cont.email, CONCAT(cont.ddd_tel1, '-', cont.Tel1) ")
            strSQL.Append("    ORDER BY c.razao_cli ")

            oCmd = New SqlCommand(strSQL.ToString, oConn)
            oCmd.CommandText = strSQL.ToString
            oCmd.CommandType = CommandType.Text

            'executando o SQLCommand
            Dim oDataReader As SqlDataReader = oCmd.ExecuteReader()

            'converter o DataReader para DataTable
            oTable.Load(oDataReader)

            'definindo o DataSource do relat¢rio
            Dim myReportDataSource As ReportDataSource = New ReportDataSource("RelatorioClientesAtendidos", oTable)
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
