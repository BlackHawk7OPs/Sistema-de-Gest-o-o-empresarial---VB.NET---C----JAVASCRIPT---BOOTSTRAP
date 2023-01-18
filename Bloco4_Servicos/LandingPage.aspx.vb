Partial Class LandingPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Validate if sessions (Login and Setor) are active when loading page
        ValidaAcesso.CheckLogin()
    End Sub

    Protected Sub FiltroBloco_AbrirRelatorio(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim qryString As String = String.Empty

        Select Case FiltroBloco.TipoFiltro
            Case Enumeradores.EnumTipoFiltro.PeriodoGAS
                qryString += String.Format("DataInicioGas={0}&DataFimGas={1}&", FiltroBloco.DataInicioGAS, FiltroBloco.DataFimGAS)
                Exit Select
            Case Enumeradores.EnumTipoFiltro.PeriodoAmostra
                qryString += String.Format("DataInicioAmostra={0}&DataFimAmostra={1}&", FiltroBloco.DataInicioAmostra, FiltroBloco.DataFimAmostra)
                Exit Select
            Case Enumeradores.EnumTipoFiltro.GAS
                qryString += String.Format("GAS={0}&", FiltroBloco.GAS)
                Exit Select
            Case Enumeradores.EnumTipoFiltro.Certificado
                qryString += String.Format("Certificado={0}&", FiltroBloco.Certificado)
                Exit Select
        End Select

        Response.Redirect(String.Format("{0}?{1}", "Bloco4_Servicos.aspx", qryString), True)

    End Sub
End Class