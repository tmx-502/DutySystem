using System;
using System.Threading;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using System.Text;

public partial class manageDutyShow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
    }

    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    Session["str"] = this.number.Text;

    //    DS.JsHelper.JsHelper.Redirect("manageDutyShow.aspx");
    //}

    //protected void Button2_Click(object sender, EventArgs e)
    //{
    //    Session["str"] = this.name.Text;
    //    DS.JsHelper.JsHelper.Redirect("manageDutyShow.aspx");
    //}

    //protected void Button3_Click(object sender, EventArgs e)
    //{
    //    Session["str"] = null;
    //    DS.JsHelper.JsHelper.Redirect("manageDutyShow.aspx");
    //}

    //protected void Button4_Click(object sender, EventArgs e)
    //{
    //    DS.JsHelper.JsHelper.Redirect("manageMenu.aspx");
    //}

    //protected void Button5_Click(object sender, EventArgs e)
    //{
    //    DialogResult dr = MessageBox.Show("确认删除吗", "提示", MessageBoxButtons.OKCancel);
    //    if (dr == DialogResult.OK)
    //    {
    //        DateTime dateTime = DateTime.Parse(Session["date"].ToString());
    //        int number = int.Parse(Session["number"].ToString());
    //        if (DS.BLL.User.Delete(number, dateTime))
    //        {
    //            DS.JsHelper.JsHelper.AlertAndRedirect("删除成功！", "manageDutyShow.aspx");
    //        }
    //        else
    //        {
    //            DS.JsHelper.JsHelper.AlertAndRedirect("删除失败！", "manageDutyShow.aspx");
    //        }
    //    }
    //    else if (dr == DialogResult.Cancel)
    //    {
    //        DS.JsHelper.JsHelper.Redirect("manageDutyShow.aspx");
    //    }

    //}



    //protected void Button7_Click(object sender, EventArgs e)
    //{
    //    Thread t = new Thread((ThreadStart)(() =>
    //    {
    //        SaveFileDialog saveImageDialog = new SaveFileDialog();
    //        saveImageDialog.Filter = "Excel Files (*.xlsx)|*.xlsx";
    //        if (saveImageDialog.ShowDialog() == DialogResult.OK)
    //        {
    //            DS.DAL.User.OutDataToExcel(DS.DAL.User.excel, saveImageDialog.FileName);
    //        }
    //        else
    //        {
    //        }
    //    }
    //            ));
    //    t.SetApartmentState(ApartmentState.STA);
    //    t.Start();
    //    t.Join();
    //}

    //protected void Button6_Click(object sender, EventArgs e)
    //{
    //    Session["str"] = this.date.Text;
    //    DS.JsHelper.JsHelper.Redirect("manageDutyShow.aspx");
    //}

    protected void Button1_Click(object sender, EventArgs e)
    {
        
    }
}