Public Class LandingPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Validate if sessions (Login and Setor) are active when loading page
        ValidaAcesso.CheckLogin()
    End Sub

    Protected Sub FiltroETQ_AbrirRelatorio(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim qryString As String = String.Empty

        If Len(TextBoxInicio.Text) > 0 And Len(TextBoxFim.Text) > 0 Then
            qryString += String.Format("NumIni={0}&NumFim={1}", TextBoxInicio.Text, TextBoxFim.Text)
        End If

        Response.Redirect(String.Format("{0}?{1}", "Coletor_2.aspx", qryString), True)
    End Sub

    Protected Sub btnCancelar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelar.Click

    End Sub
    Protected Sub btnOK_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOk.Click
        FiltroETQ_AbrirRelatorio(Nothing, Nothing)
    End Sub
End Class