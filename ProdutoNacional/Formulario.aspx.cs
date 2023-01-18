using System;
using System.Linq;
using System.Configuration;
using System.Web;
using System.Web.UI;
using SistecWeb.Database;
using SistecWeb.Entidade;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class Cadastros_ProdutoNacional_Formulario : System.Web.UI.Page
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

        if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["id"]))
                ViewProdutoNacional();
            else
                NewProdutoNacional();
        }
    }

    private void OcultarIcons()
    {
        btnNew.Visible = false;
        btnSave.Visible = false;
        btnEdit.Visible = false;
        btnDelete.Visible = false;
        btnCancel.Visible = false;
        btnHelp.Visible = true;

    }

    private void NewProdutoNacional()
    {
        btnSave.Visible = true;
        btnCancel.Visible = true;
        btnHelp.Visible = true;

        PopulaCategoria();
    }


    private void EditProdutoNacional()
    {
        OcultarIcons();

        btnSave.Visible = true;
        btnCancel.Visible = true;
        btnHelp.Visible = true;   
        txbcodSGT.ReadOnly = false;
        txbcodDN.ReadOnly = false;
        txbprodutoNacional.ReadOnly = false;
        ddlCategoria.Enabled = true;
    }

    private void ViewProdutoNacional()
    {
        OcultarIcons();
        PopulaCategoria();

        btnNew.Visible = false;
        btnEdit.Visible = true;
        btnDelete.Visible = true;
        btnHelp.Visible = true;      
        txbcodSGT.ReadOnly = true;
        txbcodDN.ReadOnly = true;
        txbprodutoNacional.ReadOnly = true;
        ddlCategoria.Enabled = false;


        int id = (string.IsNullOrEmpty(Request.QueryString["id"]) ? 0 : Convert.ToInt32(Request.QueryString["id"]));

        ProdutoNacional produtoNacional = db.ProdutosNacionais.FirstOrDefault(c => c.id == id);

        if (produtoNacional != null)
        {
            hfdidProdutoNacional.Value = id.ToString();
            ddlCategoria.SelectedValue = produtoNacional.idCategoria.ToString();
            txbprodutoNacional.Text = produtoNacional.produtoNacional;
            txbcodDN.Text = produtoNacional.codDN.ToString();           
            txbcodSGT.Text = produtoNacional.codSGT.ToString();           
        }

    }

    private void ViewProdutoNacional(int id)
    {
        OcultarIcons();
        PopulaCategoria();

        btnNew.Visible = false;
        btnEdit.Visible = true;
        btnDelete.Visible = true;
        btnHelp.Visible = true;
        txbcodSGT.ReadOnly = true;
        txbcodDN.ReadOnly = true;
        txbprodutoNacional.ReadOnly = true;
        ddlCategoria.Enabled = false;

        ProdutoNacional produtoNacional = db.ProdutosNacionais.FirstOrDefault(c => c.id == id);

        if (produtoNacional != null)
        {
            hfdidProdutoNacional.Value = id.ToString();
            ddlCategoria.SelectedValue = produtoNacional.idCategoria.ToString();
            txbprodutoNacional.Text = produtoNacional.produtoNacional;
            txbcodDN.Text = produtoNacional.codDN.ToString();
            txbcodSGT.Text = produtoNacional.codSGT.ToString();
        }

    }



    protected void btnCancel_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToInt32(hfdidProdutoNacional.Value) == 0)
            Response.Redirect("~/Cadastros/ProdutoNacional/Default.aspx");
        else
        {
            OcultarIcons();

            btnNew.Visible = false;
            btnEdit.Visible = true;
            btnDelete.Visible = true;
            txbprodutoNacional.Visible = true;
            txbcodDN.ReadOnly = true;
            txbcodSGT.ReadOnly = true;
            
            btnHelp.Visible = true;


            ViewProdutoNacional();
        }
    }

    private bool SaveProdutoNacional()
    {
        Init();

        int id = Convert.ToInt32(hfdidProdutoNacional.Value);

        try
        {
            ProdutoNacional produtoNacional = db.ProdutosNacionais.FirstOrDefault(c => c.id == id);

            if (produtoNacional == null)
                produtoNacional = new ProdutoNacional();

            produtoNacional.idCategoria = Convert.ToInt32(ddlCategoria.SelectedValue);
            if (!string.IsNullOrWhiteSpace(txbcodDN.Text.Trim())) produtoNacional.codDN = Convert.ToInt32(txbcodDN.Text.Trim());
            if (!string.IsNullOrWhiteSpace(txbcodSGT.Text.Trim())) produtoNacional.codSGT = Convert.ToInt32(txbcodSGT.Text.Trim());
            
            produtoNacional.produtoNacional = txbprodutoNacional.Text.Trim();
            produtoNacional.status = 1;

            if (produtoNacional.id == 0)
                db.ProdutosNacionais.Add(produtoNacional);

            db.SaveChanges();

            if (id == 0)
            {
                hfdidProdutoNacional.Value = produtoNacional.id.ToString();
            }

            return true;
        }
        catch (Exception)
        {
            return false;
            throw;
        }
    }
    protected void btnSave_Click(object sender, ImageClickEventArgs e)
    {
        if (SaveProdutoNacional())
        {
            int id = Convert.ToInt32(hfdidProdutoNacional.Value);
            ViewProdutoNacional(id);

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "exibirAlert('Produto Nacional cadastrado', 'bg-success');", true);
        }
        else
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "exibirAlert('Não foi possível cadastrar o Produto Nacional', 'bg-danger');", true);
    }

    protected void btnNew_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Cadastros/ProdutoNacional/Formulario.aspx");
    }

    protected void btnDelete_Click(object sender, ImageClickEventArgs e)
    {
        int ProdutoNacional = Convert.ToInt32(hfdidProdutoNacional.Value);

        using (SistecContext db = new SistecContext(HttpContext.Current.Session["database"].ToString()))
        {
            try
            {
                ProdutoNacional produtoNacional = db.ProdutosNacionais.FirstOrDefault(c => c.id == ProdutoNacional);
                if (produtoNacional != null) db.ProdutosNacionais.Remove(produtoNacional);
                db.SaveChanges();
                Response.Redirect("~/Cadastros/ProdutoNacional/Default.aspx");
            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "exibirAlert('Não foi possível deletar o produto nacional.', 'bg-danger');", true);
                throw;
            }
        }
    }

    protected void btnEdit_Click(object sender, ImageClickEventArgs e)
    {
        EditProdutoNacional();
    }

    protected void btnHelp_Click(object sender, ImageClickEventArgs e)
    {

    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static bool ValidarNovoProdutoNacional(string linha)
    {
        Init();

        linha = linha.Trim();

        if (string.IsNullOrWhiteSpace(linha))
            return false;

        var ls = db.ProdutosNacionais.FirstOrDefault(c => c.produtoNacional.Equals(linha));

        if (ls == null)
            return true;
        else
            return false;
    }


    void PopulaCategoria()
    {
        Init();

        ddlCategoria.DataSource = db.CategoriasServicos.Where(cs => cs.status == 1).Select(cs => new
        {
            cs.id,
            cs.categoria
        }).OrderBy(ls => ls.categoria).ToList();
        ddlCategoria.DataTextField = "categoria";
        ddlCategoria.DataValueField = "id";
        ddlCategoria.DataBind();
        ddlCategoria.Items.Insert(0, new ListItem("Selecione a Categoria", "0"));

    }

}