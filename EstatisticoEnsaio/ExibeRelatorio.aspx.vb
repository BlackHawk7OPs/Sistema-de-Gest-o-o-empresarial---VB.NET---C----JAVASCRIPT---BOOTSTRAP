Imports System.Data.SqlClient
Imports System.Data
Imports Microsoft.Reporting.WebForms
Imports System.Reflection

Partial Class Relatorios_EstatisticoEnsaio_ExibeRelatorio
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
            Dim tipoFiltro = Request.QueryString("TipoFiltro")
            Dim Ordem = Request.QueryString("Ordem")

            'carregar o relatório
            ReportViewer1.LocalReport.ReportPath = "Relatorios\EstatisticoEnsaio\EstatisticoEnsaio.rdlc"

            ' Lista de extensões disponiveis

            For Each extension As RenderingExtension In ReportViewer1.LocalReport.ListRenderingExtensions()


                If (extension.Name = "WORD") Then

                    ' a propriedade extension.Visible é somente leitura, então precisamos da propriedade "m_isVisible"

                    Dim fi As FieldInfo = extension.[GetType]().GetField("m_isVisible", BindingFlags.Instance Or BindingFlags.NonPublic)

                    ' setar para falso para não exibir

                    fi.SetValue(extension, False)

                End If
            Next

            'passar os dados para o relatório abrindo conexão com o banco de dados
            oConn.ConnectionString = strConexao
            oConn.Open()

            'definindo o SQL do relatório
            strSQL.Append(" SELECT ")
            strSQL.Append(" parametros.nome_par, parametros.cod_param, preco_serv.idUnidade, sum(preco_serv.qtd_param) as qtd_param, preco_serv.id_param ")
            strSQL.Append(" FROM preco_serv INNER JOIN GAS ON preco_serv.id_GAS = GAS.id_GAS INNER JOIN   parametros ON preco_serv.id_param = parametros.id_param ")
            strSQL.Append(" WHERE preco_serv.idUnidade = '" & Session("idUnidade") & "' ")

            If Not String.IsNullOrEmpty(dataInicial) And Not String.IsNullOrEmpty(dataFinal) Then
                strSQL.Append(String.Format(" and data_emissao between '{0}' and '{1}' ", dataInicial, dataFinal))
            End If

            If (tipoFiltro.Equals("Lista")) Then
                strSQL.Append(" and 1=1 ")
            End If

            strSQL.Append(" group by parametros.nome_par, parametros.cod_param, preco_serv.idUnidade, preco_serv.id_param ")

            If (Ordem.Equals("codigoEnsaio")) Then
                strSQL.Append(" order by parametros.cod_param ")
            ElseIf (Ordem.Equals("nomeEnsaio")) Then
                strSQL.Append(" order by parametros.nome_par ")
            ElseIf (Ordem.Equals("quantidade")) Then
                strSQL.Append(" order by sum(preco_serv.qtd_param) ")
            End If

            oCmd = New SqlCommand(strSQL.ToString, oConn)
            oCmd.CommandText = strSQL.ToString
            oCmd.CommandType = CommandType.Text

            'executando o SQLCommand
            Dim oDataReader As SqlDataReader = oCmd.ExecuteReader(CommandBehavior.CloseConnection)

            'converter o DataReader para DataTable
            oTable.Load(oDataReader)

            'definindo o DataSource do relat¢rio
            Dim myReportDataSource As ReportDataSource = New ReportDataSource("EstatisticoEnsaio", oTable)
            ReportViewer1.LocalReport.DataSources.Add(myReportDataSource)
            'Label1.Text = strSQL.ToString

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
