
Partial Class Relatorios_GAS_Default
    Inherits System.Web.UI.Page

    Private master As Boolean

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        'Validate if sessions (Login and Setor) are active when loading page
        Dim mp As MasterPage = CType(Page.Master, MasterPage) 'Call masterpage public function
        Call mp.checkLoginSessions()

        SqlSetor.ConnectionString = ConfigurationManager.ConnectionStrings(Session("database")).ConnectionString

        'Check permissions for this page (Check table programas)
        Call mp.ApplyPageSecurity("168")

        'Check permissão para validar acesso em StatusGAS
        master = mp.ApplyPartSecurity("189")


        Dim anoAtual As Integer = System.DateTime.Now.Year

        If Not IsPostBack Then
            ddlAno.Items.Clear()
            ddlAno.DataBind()

            For value As Integer = anoAtual To 2012 Step -1
                Dim item As New ListItem(value, value)
                ddlAno.Items.Add(item)
            Next
        End If

        If (master) Then
            If Not IsPostBack Then
                ddlSetor.DataBind()
                'ddlSetor.Items.Insert(0, "Geral")
                'ddlSetor.SelectedIndex = 1
                ddlSetor.SelectedValue = Session("idUnidade")
            End If
        Else
            If Not IsPostBack Then
                ddlSetor.SelectedValue = Session("idUnidade")
                ddlSetor.Enabled = False
            End If
        End If

    End Sub

    Protected Sub btnEnviar_Click(sender As Object, e As EventArgs) Handles btnEnviar.Click

        Dim qryString As String = String.Empty
        Dim idInstituicao As String = ddlInstituicao.SelectedValue
        Dim idSetor As String = ddlSetor.SelectedValue
        Dim area As String = ddlSetor.SelectedItem.Text
        Dim relatorio As Integer = ddlRel.SelectedValue
        Dim ano As Integer = ddlAno.SelectedValue

        Select Case relatorio
            Case 1
                qryString += String.Format("idInstituicao={0}&", idInstituicao)
                qryString += String.Format("&idSetor={0}&", idSetor)
                qryString += String.Format("&area={0}&", area)
                qryString += String.Format("&ano={0}", ano)

                Response.Redirect(String.Format("{0}?{1}", "RelatorioGASMesAno.aspx", qryString), True)

            Case Else


        End Select

    End Sub
End Class
