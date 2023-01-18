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

public partial class Cadastros_LinhaServicos_Formulario : System.Web.UI.Page
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
                ViewLinhaServicos();
            else
                NewLinhaServicos();
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

    private void NewLinhaServicos()
    {    
        btnSave.Visible = true;
        btnCancel.Visible = true;
        btnHelp.Visible = true;
    }


    private void EditLinhaServicos()
    {
        OcultarIcons();

        btnSave.Visible = true;
        btnCancel.Visible = true;
        btnHelp.Visible = true;
        txblinha.ReadOnly = false;
        txbcodDN.ReadOnly = false;
        txbcodSgt.ReadOnly = false;
        //txbcodLinhaSatt.ReadOnly = false;
        txbcontaContabil.ReadOnly = false;
        txbordemValor.ReadOnly = false;
        txbcodProdERP.ReadOnly = false;
        
        //ckbAtivo.Enabled = true;
    }

    private void ViewLinhaServicos()
    {
        OcultarIcons();

        btnNew.Visible = false;
        btnEdit.Visible = true;
        btnDelete.Visible = true;
        btnHelp.Visible = true;
        txblinha.ReadOnly = true;
        txbcodDN.ReadOnly = true;
        txbcodSgt.ReadOnly = true;
        //txbcodLinhaSatt.ReadOnly = true;
        txbcontaContabil.ReadOnly = true;
        txbordemValor.ReadOnly = true;
        txbcodProdERP.ReadOnly = true;
        //ckbAtivo.Enabled = false;
       

        

        int id = (string.IsNullOrEmpty(Request.QueryString["id"]) ? 0 : Convert.ToInt32(Request.QueryString["id"]));

        LinhaServicos linha = db.LinhasServicos.FirstOrDefault(c => c.id == id);

        if (linha != null)
        {
            hfdidLinhaServicos.Value = id.ToString();
            txblinha.Text = linha.linha;
            txbcodDN.Text = linha.codDN.ToString();
            //txbcodProdERP.Text = linha.codProdERP;
            txbcodSgt.Text = linha.codSgt.ToString();
            //txbcontaContabil.Text = linha.contaContabil;
            //txbordemValor.Text = linha.ordemValor.ToString();

        }

    }

   

    protected void btnCancel_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToInt32(hfdidLinhaServicos.Value) == 0)
            Response.Redirect("~/Cadastros/LinhaServico/Default.aspx");
        else
        {
            OcultarIcons();

            btnNew.Visible = false;
            btnEdit.Visible = true;
            btnDelete.Visible = true;
            txblinha.ReadOnly = true;
            txbcodDN.ReadOnly = true;
            txbcodSgt.ReadOnly = true;
            //txbcodLinhaSatt.ReadOnly = true;
            txbcontaContabil.ReadOnly = true;
            txbordemValor.ReadOnly = true;
            txbcodProdERP.ReadOnly = true;
            btnHelp.Visible = true;
            //ckbAtivo.Enabled = false;

            ViewLinhaServicos();
        }
    }

    private bool SaveLinhaServicos()
    {
        Init();

        int id = Convert.ToInt32(hfdidLinhaServicos.Value);

        try
        {
            LinhaServicos linhaServicos = db.LinhasServicos.FirstOrDefault(c => c.id == id);

            if (linhaServicos == null)
                linhaServicos = new LinhaServicos();

            linhaServicos.id = Convert.ToInt32(hfdidLinhaServicos.Value);
            if (!string.IsNullOrWhiteSpace(txbcodDN.Text.Trim())) linhaServicos.codDN = Convert.ToInt32(txbcodDN.Text.Trim());
            if(!string.IsNullOrWhiteSpace(txbcodSgt.Text.Trim())) linhaServicos.codSgt = Convert.ToInt32(txbcodSgt.Text.Trim());
            linhaServicos.codProdERP = txbcodProdERP.Text.Trim();
            linhaServicos.contaContabil = txbcontaContabil.Text.Trim();
            if (!string.IsNullOrWhiteSpace(txbordemValor.Text.Trim())) linhaServicos.ordemValor = Convert.ToInt32(txbordemValor.Text.Trim());
            linhaServicos.linha = txblinha.Text.Trim();
            //if (!string.IsNullOrWhiteSpace(txbcodLinhaSatt.Text.Trim())) linhaServicos.codLinhaSatt = Convert.ToInt32(txbcodLinhaSatt.Text.Trim());
            linhaServicos.status = 1;

            

            if (linhaServicos.id == 0)
                db.LinhasServicos.Add(linhaServicos);

            db.SaveChanges();

            if (id == 0)
            {
                id = db.LinhasServicos.Max(cc => cc.id);
                hfdidLinhaServicos.Value = id.ToString();
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
        if (SaveLinhaServicos())
        {
            ViewLinhaServicos();

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "exibirAlert('Linha de serviços cadastrada', 'bg-success');", true);
        }
        else
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "exibirAlert('Não foi possível cadastrar a linha de serviços', 'bg-danger');", true);
    }
  

   

    protected void btnNew_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Cadastros/LinhaServicos/Formulario.aspx");
    }

    protected void btnDelete_Click(object sender, ImageClickEventArgs e)
    {
        int LinhaServicos = Convert.ToInt32(hfdidLinhaServicos.Value);

        using (SistecContext db = new SistecContext(HttpContext.Current.Session["database"].ToString()))
        {
            try
            {


                LinhaServicos linha = db.LinhasServicos.FirstOrDefault(c => c.id == LinhaServicos);
                if (linha != null) db.LinhasServicos.Remove(linha);
                db.SaveChanges();

                Response.Redirect("~/Cadastros/LinhaServico/Default.aspx");
            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "alert", "exibirAlert('Não foi possível deletar a carta de controle.', 'bg-danger');", true);
                throw;
            }
        }
    }


    protected void btnEdit_Click(object sender, ImageClickEventArgs e)
    {
        EditLinhaServicos();
    }

    protected void btnHelp_Click(object sender, ImageClickEventArgs e)
    {
      
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static bool ValidarNovaLinhaServico(string linha)
    {
        Init();

        linha = linha.Trim();

        if (string.IsNullOrWhiteSpace(linha))
            return false;

        var ls = db.LinhasServicos.FirstOrDefault(c => c.linha.Equals(linha));

        if (ls == null)
            return true;
        else
            return false;
    }


}
