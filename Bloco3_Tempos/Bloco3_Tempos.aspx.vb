Imports Microsoft.Reporting.WebForms
Imports System.Data.SqlClient
Imports System.Data
Imports System.Reflection

Partial Class Bloco3_Tempos
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
            Dim dataInicioGas = Request.QueryString("DataInicioGas")
            Dim dataFimGas = Request.QueryString("DataFimGas")
            Dim dataInicioAmostra = Request.QueryString("DataInicioAmostra")
            Dim dataFimAmostra = Request.QueryString("DataFimAmostra")
            Dim gas = Request.QueryString("GAS")
            Dim certificado = Request.QueryString("Certificado")

            'carregar o relatório
            ReportViewer1.LocalReport.ReportPath = "Relatorios\Bloco3_Tempos\Relatorio_Bloco3.rdlc"

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
            strSQL.Append(" certificados.id_certif, GAS.id_GAS, GAS.data_rec_amostra, certificados.Data_Conclusao, certificados.Emissao_certif, certificados.data_envio_correio, certificados.data_recebimento_cliente, certificados.pesquisa_data_envio, certificados.pesquisa_data_resposta, DATEDIFF(day, GAS.data_rec_amostra, certificados.Data_Conclusao) AS tempo_execucao, DATEDIFF(day, certificados.Emissao_certif, certificados.Data_Conclusao) AS tempo_processamento, DATEDIFF(day,certificados.Emissao_certif,certificados.data_recebimento_cliente) AS periodo_disponibilidade_certificado, DATEDIFF(day,certificados.obj_data_saida,certificados.data_conclusao) AS periodo_disponibilidade_Objeto, DATEDIFF(day,GAS.data_rec_amostra,certificados.data_recebimento_cliente) AS Tempo_total")
            strSQL.Append(" FROM certificados INNER JOIN GAS ON certificados.id_GAS = GAS.id_GAS LEFT OUTER JOIN objetos ON objetos.id_GAS = GAS.id_GAS")
            strSQL.Append(" WHERE GAS.idUnidade='" & Session("idUnidade") & "'")

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

            strSQL.Append(" ORDER BY certificados.id_certif,certificados.id_GAS")
            'Label1.Text = strSQL.ToString

            oCmd = New SqlCommand(strSQL.ToString, oConn)
            oCmd.CommandText = strSQL.ToString
            oCmd.CommandType = CommandType.Text

            'executando o SQLCommand
            Dim oDataReader As SqlDataReader = oCmd.ExecuteReader(CommandBehavior.CloseConnection)

            'converter o DataReader para DataTable
            oTable.Load(oDataReader)

            'definindo o DataSource do relat¢rio
            Dim myReportDataSource As ReportDataSource = New ReportDataSource("Bloco3_Tempos", oTable)
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