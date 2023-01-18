using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Cadastros_CategoriaServicos_Componentes_Menu : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btn_cadastrarCategoria_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Cadastros/CategoriaServicos/Formulario.aspx");
    } 
}