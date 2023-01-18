Imports Microsoft.Reporting.WebForms
Imports System.Data.SqlClient
Imports System.Data

Public Class Coletor_2
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
        'Dim oTable As New DataTable()
        Dim oCmd As SqlCommand = Nothing
        Dim j As Integer = 0

        Try
            'Busca parametros da QueryString
            Dim NumUltimo = Request.QueryString("NumUltimo")
            Dim NumIni = Request.QueryString("NumIni")
            Dim NumFim = Request.QueryString("NumFim")


            'carregar o relatório
            ReportViewer1.LocalReport.ReportPath = "Relatorios\ETQAmostras\Coletor_2\Relatorio_Coletor_2.rdlc"

            Dim oTable As New dtsRelatoriosP3.Coletor_2DataTable()

            Dim castNumIni As Int32
            Dim castNumFim As Int32
            Dim castNumAux As Int32

            If (Int32.TryParse(NumIni, castNumIni)) And
               (Int32.TryParse(NumFim, castNumFim)) Then
                castNumAux = castNumIni
                For i As Int32 = castNumIni To castNumFim

                    Dim dr = oTable.NewRow()
                    dr("Num") = i
                    dr("NumUltimo") = NumFim

                    oTable.Rows.Add(dr)
                    oTable.AcceptChanges()

                    i = i + 79

                Next i

            End If

            'definindo o DataSource do relat¢rio
            Dim myReportDataSource As ReportDataSource = New ReportDataSource("Coletor_2", oTable.ToArray())
            ReportViewer1.LocalReport.DataSources.Add(myReportDataSource)

        Catch ex As Exception
            System.Diagnostics.Debug.WriteLine(ex.Message)
        Finally
            'liberando os objetos
            oConn.Dispose()
            'oTable.Dispose()
            oConn = Nothing
            'oTable = Nothing
        End Try
    End Sub
End Class