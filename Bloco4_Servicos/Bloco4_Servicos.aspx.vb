Imports Microsoft.Reporting.WebForms
Imports System.Data.SqlClient
Imports System.Data
Imports System.Reflection

Partial Class Bloco4_Servicos
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
            ReportViewer1.LocalReport.ReportPath = "Relatorios\Bloco4_Servicos\Relatorio_Bloco4.rdlc"

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
            strSQL.Append(" certificados.id_certif, certificados.id_GAS, certificados.flg_bilingue, certificados.enviado_por_fax, etiquetacetec.numero_etiqueta, parametros.nome_par, grupo.descricao AS Grupo, subgrupo.descricao AS sub_grupo, credenciamentos.ENTIDADE_CRE, credenciamentos.numero_cre, credenciamentos.tipo_cre, objetos.material_obj, objetos.id_obj")
            strSQL.Append(" FROM certificados LEFT OUTER JOIN objetos ON certificados.id_GAS = objetos.id_GAS LEFT OUTER JOIN Servicos ON objetos.id_obj = Servicos.id_obj AND objetos.id_GAS = Servicos.id_GAS LEFT OUTER JOIN parametros ON Servicos.id_param = parametros.id_param LEFT OUTER JOIN grupo ON parametros.id_grupo = grupo.id_grupo LEFT OUTER JOIN subgrupo ON parametros.id_subgrupo = subgrupo.id_subgrupo AND parametros.id_grupo = subgrupo.id_grupo LEFT OUTER JOIN etiquetacetec ON etiquetacetec.id_obj=objetos.id_obj and etiquetacetec.id_gas=objetos.id_gas LEFT OUTER JOIN credencparametro ON credencparametro.id_param=parametros.id_param LEFT OUTER JOIN credenciamentos ON credencparametro.id_credenc=credenciamentos.id_credenc LEFT OUTER JOIN GAS ON GAS.id_GAS = certificados.id_GAS")
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

            strSQL.Append(" ORDER BY certificados.ID_certif,objetos.id_obj,parametros.nome_par")

            'Label1.Text = strSQL.ToString

            oCmd = New SqlCommand(strSQL.ToString, oConn)
            oCmd.CommandText = strSQL.ToString
            oCmd.CommandType = CommandType.Text

            'executando o SQLCommand
            Dim oDataReader As SqlDataReader = oCmd.ExecuteReader(CommandBehavior.CloseConnection)

            'converter o DataReader para DataTable
            oTable.Load(oDataReader)

            'definindo o DataSource do relat¢rio
            Dim myReportDataSource As ReportDataSource = New ReportDataSource("Bloco4_Servicos", oTable)
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