using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userUpdate : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        string number = Request.RawUrl.Replace("/Page/userUpdate.aspx?id=", "");
        if (!IsPostBack)
        {
            DS.Model.User user = DS.BLL.User.GetUser(int.Parse(number));
            this.UName.Text = user.Name;
            this.UPhone.Text = user.Phone;
            this.USex.Text = user.Sex.ToString();
            this.URole.Text = user.Role.ToString();
            this.UGroup.Text = user.Group.ToString();
        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        //string number = Request.RawUrl.Replace("/userUpdate.aspx?id=", "");
        //DS.Model.User user;
        //bool isPwd = this.CheckBox1.Checked;
        //if (isPwd)
        //{
        //    user = new DS.Model.User
        //    {
        //        Number = int.Parse(number),
        //        Name = this.UName.Text,
        //        Phone = this.UPhone.Text,
        //        Sex = this.USex.Text,
        //        Role = this.URole.Text,
        //        Pwd = "1234"
        //    };
        //}
        //else
        //{
        //    user = new DS.Model.User
        //    {
        //        Number = int.Parse(number),
        //        Name = this.UName.Text,
        //        Phone = this.UPhone.Text,
        //        Sex = this.USex.Text,
        //        Role = this.URole.Text,
        //    };
        //}


        //if (DS.BLL.User.Update(user) == true)
        //{
        //    this.result.Value = "修改成功!";
        //    Page_Load(sender, e);
        //}
        //else
        //{
        //    this.result.Value = "修改失败!";

        //}

    }



}