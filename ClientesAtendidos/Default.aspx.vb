Imports ValidaAcesso

Partial Class Relatorios_ClientesAtendidos_Default
    Inherits System.Web.UI.Page

    Private master As Boolean

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        ValidaAcesso.CheckLogin()

        SqlSetor.ConnectionString = ConfigurationManager.ConnectionStrings(Session("database")).ConnectionString

        'Check permissions for this page (Check table programas)
        ValidaAcesso.ApplyPageSecurity(168)

        'Check permissão para validar acesso em StatusGAS
        master = ValidaAcesso.ApplyPartSecurity(189)

        Dim anoAtual As Integer = System.DateTime.Now.Year

        If Not IsPostBack Then
            ddlAno.Items.Clear()
            ddlAno.DataBind()

            For value As Integer = anoAtual To 2012 Step -1
                Dim item As New ListItem(value, value)
                ddlAno.Items.Add(item)
            Next

            ddlSetor.SelectedValue = Session("codGerencia")
        End If

        If Not master Then
            ddlSetor.Enabled = False
        End If


    End Sub


    Protected Sub btnEnviar_Click(sender As Object, e As EventArgs) Handles btnEnviar.Click

        Dim qryString As String = String.Empty
        Dim idInstituicao As String = ddlInstituicao.SelectedValue
        Dim idSetor As String = ddlSetor.SelectedValue
        Dim area As String = ddlSetor.SelectedItem.Text
        Dim ano As Integer = ddlAno.SelectedValue

        qryString += String.Format("idInstituicao={0}&", idInstituicao)
        qryString += String.Format("&idSetor={0}&", idSetor)
        qryString += String.Format("&area={0}&", area)
        qryString += String.Format("&ano={0}", ano)

        Response.Redirect(String.Format("{0}?{1}", "Relatorio.aspx", qryString), True)

    End Sub
End Class
