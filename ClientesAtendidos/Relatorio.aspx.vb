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

        Dim strConexao As String = ConfigurationManager.ConnectionStrings("intranetdadosConnectionString").ToString()
        'Dim strConexao As String = ConfigurationManager.ConnectionStrings(Session("database")).ConnectionString.ToString()
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

            strSQL.Append("SELECT ano, COUNT(id_GAS) AS atendimento, razao_cli, fantasia_cli, cnpjcpf_cli, email_cli, ")
            strSQL.Append("        telCliente, nome_cont, Setor_Departamento, cargo_cont, telContato ")
            strSQL.Append("    FROM View_RelatoriosClientesAtendidos ")
            strSQL.Append("    WHERE")
            strSQL.Append(String.Format(" (data_emissao BETWEEN '{0}-01-01' AND '{0}-12-31') ", ano))

            If idSetor <> "0" Then
                strSQL.Append(" AND codUnidade = '" & idSetor & "' ")
            ElseIf idSetor = "0" Then
                strSQL.Append(" AND idCampus = 45 ")
            End If

            strSQL.Append("    GROUP BY ano, razao_cli, fantasia_cli, cnpjcpf_cli, email_cli, telCliente, nome_cont, Setor_Departamento, cargo_cont, email, telContato ")
            strSQL.Append("    ORDER BY razao_cli ")

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
