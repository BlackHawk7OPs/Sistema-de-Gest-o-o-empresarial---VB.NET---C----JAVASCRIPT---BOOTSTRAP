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

public partial class Cadastros_LinhaServicos_Default : System.Web.UI.Page
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

        //int id = 5;
        //LinhaServicos linha = db.LinhasServicos.FirstOrDefault(ls => ls.id == id);

        //if (linha != null)
        //{
        //    string nomeLinha = linha.linha;
        //    string codDN = linha.codDN.ToString();
        //    string codSgt= linha.codSgt.ToString();
        //    string codProdERP = linha.codProdERP.ToString();
        //    string contaContabil = linha.contaContabil.ToString();
        //    string ordemValor = linha.ordemValor.ToString();
        //    string codLinhaSatt = linha.codLinhaSatt.ToString();
        //    int status = linha.status;
        //}
    }

    protected void CarregarLinhaServicos(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(((LinkButton)sender).CommandArgument);
        Response.Redirect(String.Format("~/Cadastros/LinhaServico/Formulario.aspx?id={0}", id));
    }

    protected void btn_listaServicos_Click(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(((LinkButton)sender).CommandArgument);
        Response.Redirect(String.Format("~/Cadastros/LinhaServico/Default.aspx?id={0}", id));
    }



    protected void btnPesquisar_Click(object sender, EventArgs e)
    {
        string pesquisar = string.IsNullOrWhiteSpace(txbPesquisar.Text.Trim()) ? "%" : string.Format("%{0}%", txbPesquisar.Text.Trim());

        sqlGridLinhaServicos.SelectParameters["search"].DefaultValue = pesquisar;
        sqlGridLinhaServicos.DataBind();
        gridLinhaServicos.DataBind();

    }

    protected void txbPesquisar_TextChanged(object sender, EventArgs e)
    {
        btnPesquisar_Click(sender, e);
    }


    protected void btnLimpar_Click(object sender, EventArgs e)
    {
        txbPesquisar.Text = "";

        sqlGridLinhaServicos.SelectParameters["search"].DefaultValue = "%";
        sqlGridLinhaServicos.DataBind();

        gridLinhaServicos.DataBind();
    }

}
