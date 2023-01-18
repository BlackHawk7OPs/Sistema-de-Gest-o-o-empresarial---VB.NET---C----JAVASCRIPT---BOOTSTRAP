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
using System.Web.UI.HtmlControls;

public partial class Cadastros_CategoriaServicos_Formulario : System.Web.UI.Page
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
                ViewCategoriaServicos();
            else
                NewCategoriaServicos();
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

    private void NewCategoriaServicos()
    {
        btnSave.Visible = true;
        btnCancel.Visible = true;
        btnHelp.Visible = true;
        
        PopulaLinha();
    }

    private void EditCategoriaServicos()
    {
        OcultarIcons();
        PopulaLinha();

        btnSave.Visible = true;
        btnCancel.Visible = true;
        btnHelp.Visible = true;
        ddlLinha.Enabled= true;
        txbcategoria.ReadOnly = false;
        txbcodDN.ReadOnly = false;
        txbcodSgt.ReadOnly = false;

    }

    private void ViewCategoriaServicos()
    {
        OcultarIcons();
        PopulaLinha();


        btnNew.Visible = false;
        btnEdit.Visible = true;
        btnDelete.Visible = true;
        btnHelp.Visible = true;
        txbcategoria.ReadOnly = true;
        ddlLinha.Enabled = false ;
        txbcodDN.ReadOnly = true;
        txbcodSgt.ReadOnly = true;
       

        int id = string.IsNullOrEmpty(Request.QueryString["id"]) ? 0 : Convert.ToInt32(Request.QueryString["id"]);

        CategoriaServicos categoria = db.CategoriasServicos.FirstOrDefault(c => c.id == id);

        if (categoria != null)
        {
            hfdidCategoriaServicos.Value = id.ToString();
            ddlLinha.SelectedValue = categoria.idLinha.ToString();
            txbcategoria.Text = categoria.categoria;
            txbcodDN.Text = categoria.codDN.ToString();
            txbcodSgt.Text = categoria.codSgt.ToString();
          
        }

    }


    private void ViewCategoriaServicos(int id)
    {
        OcultarIcons();
        PopulaLinha();


        btnNew.Visible = false;
        btnEdit.Visible = true;
        btnDelete.Visible = true;
        btnHelp.Visible = true;
        txbcategoria.ReadOnly = true;
        ddlLinha.Enabled = false;
        txbcodDN.ReadOnly = true;
        txbcodSgt.ReadOnly = true;


        

        CategoriaServicos categoria = db.CategoriasServicos.FirstOrDefault(c => c.id == id);

        if (categoria != null)
        {
            hfdidCategoriaServicos.Value = id.ToString();
            ddlLinha.SelectedValue = categoria.idLinha.ToString();
            txbcategoria.Text = categoria.categoria;
            txbcodDN.Text = categoria.codDN.ToString();
            txbcodSgt.Text = categoria.codSgt.ToString();

        }

    }

    protected void btnCancel_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToInt32(hfdidCategoriaServicos.Value) == 0)
            Response.Redirect("~/Cadastros/CategoriaServicos/Default.aspx");
        else
        {
            OcultarIcons();
            PopulaLinha();


            btnNew.Visible = false;
            btnEdit.Visible = true;
            btnDelete.Visible = true;
            txbcategoria.ReadOnly = true;
            ddlLinha.Enabled = true;
            txbcodDN.ReadOnly = true;
            txbcodSgt.ReadOnly = true;
            btnHelp.Visible = true;
            

            ViewCategoriaServicos();
        }
    }

    private bool SaveCategoriaServicos()
    {
        Init();

        int id = Convert.ToInt32(hfdidCategoriaServicos.Value);

        try
        {
            CategoriaServicos categoriaServicos = db.CategoriasServicos.FirstOrDefault(c => c.id == id);

            if (categoriaServicos == null)
                categoriaServicos = new CategoriaServicos();

            categoriaServicos.idLinha = Convert.ToInt32(ddlLinha.SelectedValue);
            if (!string.IsNullOrWhiteSpace(txbcodDN.Text.Trim())) categoriaServicos.codDN = Convert.ToInt32(txbcodDN.Text.Trim());
            if (!string.IsNullOrWhiteSpace(txbcodSgt.Text.Trim())) categoriaServicos.codSgt = Convert.ToInt32(txbcodSgt.Text.Trim());
            
            categoriaServicos.categoria = txbcategoria.Text.Trim();
            categoriaServicos.status = 1;



            if (categoriaServicos.id == 0)
                db.CategoriasServicos.Add(categoriaServicos);

            db.SaveChanges();

            if (id == 0)
            {
               
                hfdidCategoriaServicos.Value = categoriaServicos.id.ToString();
            }

            return true;
        }
        catch (Exception ex)
        {
            return false;
            throw;
        }
    }

    protected void btnSave_Click(object sender, ImageClickEventArgs e)
    {
        if (SaveCategoriaServicos())
        {
            int id = Convert.ToInt32(hfdidCategoriaServicos.Value);
            ViewCategoriaServicos(id);

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "exibirAlert('Categoria de Serviço cadastrada', 'bg-success');", true);
        }
        else
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "exibirAlert('Não foi possível cadastrar a Categoria Serviço', 'bg-danger');", true);
    }


    protected void btnNew_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Cadastros/CategoriaServicos/Formulario.aspx");
    }

    protected void btnDelete_Click(object sender, ImageClickEventArgs e)
    {
        int CategoriaServicos = Convert.ToInt32(hfdidCategoriaServicos.Value);

        using (SistecContext db = new SistecContext(HttpContext.Current.Session["database"].ToString()))
        {
            try
            {
                CategoriaServicos categoria = db.CategoriasServicos.FirstOrDefault(c => c.id == CategoriaServicos);
                if (categoria != null) db.CategoriasServicos.Remove(categoria);
                db.SaveChanges();

                Response.Redirect("~/Cadastros/CategoriaServicos/Default.aspx");
            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "exibirAlert('Não foi possível deletar a Categoria de serviço.', 'bg-danger');", true);
                throw;
            }
        }
    }

    protected void btnEdit_Click(object sender, ImageClickEventArgs e)
    {
        EditCategoriaServicos();
    }

    protected void btnHelp_Click(object sender, ImageClickEventArgs e)
    {

    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static bool ValidarNovaCategoriaServico(string categoria)
    {
        Init();

        categoria = categoria.Trim();

        if (string.IsNullOrWhiteSpace(categoria))
            return false;

        var ls = db.CategoriasServicos.FirstOrDefault(c => c.categoria.Equals(categoria));

        if (ls == null)
            return true;
        else
            return false;
    }

    void PopulaLinha()
    {
            Init();
        
            ddlLinha.DataSource = db.LinhasServicos.Where(ls => ls.status == 1).Select(ls => new
            {
                ls.id,
                ls.linha
            }).OrderBy(ls => ls.linha).ToList();
            ddlLinha.DataTextField = "linha";
            ddlLinha.DataValueField = "id";
            ddlLinha.DataBind();
            ddlLinha.Items.Insert(0, new ListItem("Selecione a Linha", "0"));
        
    }
}


