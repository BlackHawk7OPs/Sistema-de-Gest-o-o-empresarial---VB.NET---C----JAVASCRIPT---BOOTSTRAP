Imports System.Data.SqlClient
Imports System.Data
Imports Microsoft.Reporting.WebForms
Imports System.Reflection

Partial Class Relatorios_GAS_RelatorioGASMesAno
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
        If Session("idUnidade") Is Nothing Then
            Response.Redirect("~/Logout.aspx?l=1")
        End If
    End Sub

    Private Sub CarregaRelatorio()

        'Dim strConexao As String = ConfigurationManager.ConnectionStrings("sistecProducao").ToString()
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

            ReportViewer1.LocalReport.ReportPath = "Relatorios\GAS\RelatorioGASMesAno.rdlc"


            ' Lista de extensões disponiveis

            For Each extension As RenderingExtension In ReportViewer1.LocalReport.ListRenderingExtensions()


                If (extension.Name = "WORD") Then

                    ' a propriedade extension.Visible é somente leitura, então precisamos da propriedade "m_isVisible"

                    Dim fi As FieldInfo = extension.[GetType]().GetField("m_isVisible", BindingFlags.Instance Or BindingFlags.NonPublic)

                    ' setar para falso para não exibir

                    fi.SetValue(extension, False)

                End If
            Next

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

            strSQL.Append(" SELECT RIGHT(CONVERT(VARCHAR(10), g.data_fim_serv, 103), 7) AS mesAno, SUM(g.preco_bruto) AS Bruto, SUM(g.desconto) AS Desconto, SUM(g.preco) AS Liquido ")
            strSQL.Append("     FROM gas AS g ")
            strSQL.Append("     WHERE  g.idInstituicao = 2 ")

            If idSetor <> "0" Then
                strSQL.Append(" AND g.idUnidade = '" & idSetor & "' ")
            End If

            strSQL.Append(String.Format("      AND (g.data_fim_serv between '{0}-01-01' AND '{0}-12-31') ", ano))

            strSQL.Append("     GROUP BY RIGHT(CONVERT(VARCHAR(10), g.data_fim_serv, 103), 7) ")
            strSQL.Append("     ORDER BY RIGHT(CONVERT(VARCHAR(10), g.data_fim_serv, 103), 7) ")

            oCmd = New SqlCommand(strSQL.ToString, oConn)
            oCmd.CommandText = strSQL.ToString
            oCmd.CommandType = CommandType.Text

            'executando o SQLCommand
            Dim oDataReader As SqlDataReader = oCmd.ExecuteReader()

            'converter o DataReader para DataTable
            oTable.Load(oDataReader)

            'definindo o DataSource do relat¢rio
            Dim myReportDataSource As ReportDataSource = New ReportDataSource("RelatorioGASMesAno", oTable)
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
