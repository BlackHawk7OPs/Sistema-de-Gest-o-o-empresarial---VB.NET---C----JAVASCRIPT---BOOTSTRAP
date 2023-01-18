using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using SistecWeb.Database;
using SistecWeb.Entidade;
using SistecWeb.Resource;
using SistecWeb.ViewModel;
using SistecWeb;

public partial class Cadastros_ProdutoNacional_Default : System.Web.UI.Page
{

    private static string connectionString;
    private static SistecContext db;

    private static void Init()
    {
        ValidaAcesso.CheckLogin();
        connectionString = ConfigurationManager.ConnectionStrings[HttpContext.Current.Session["database"].ToString()].ConnectionString;
        db = new SistecContext(HttpContext.Current.Session["database"].ToString());
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Init();
    }

    protected void CarregarProdutoNacional(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(((LinkButton)sender).CommandArgument);
        Response.Redirect(String.Format("~/Cadastros/ProdutoNacional/Formulario.aspx?id={0}", id));
    }

    protected void btn_listaProdutos_Click(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(((LinkButton)sender).CommandArgument);
        Response.Redirect(String.Format("~/Cadastros/ProdutoNacional/Default.aspx?id={0}", id));
    }

    protected void btnPesquisar_Click(object sender, EventArgs e)
    {
        string pesquisar = string.IsNullOrWhiteSpace(txbPesquisar.Text.Trim()) ? "%" : string.Format("%{0}%", txbPesquisar.Text.Trim());

        sqlGridProdutoNacional.SelectParameters["search"].DefaultValue = pesquisar;
        sqlGridProdutoNacional.DataBind();
        gridProdutoNacional.DataBind();
    }
    protected void txbPesquisar_TextChanged(object sender, EventArgs e)
    {
        btnPesquisar_Click(sender, e);
    }
    protected void btnLimpar_Click(object sender, EventArgs e)
    {
        txbPesquisar.Text = "";
        sqlGridProdutoNacional.SelectParameters["search"].DefaultValue = "%";
        sqlGridProdutoNacional.DataBind();
        gridProdutoNacional.DataBind();
    }
}
