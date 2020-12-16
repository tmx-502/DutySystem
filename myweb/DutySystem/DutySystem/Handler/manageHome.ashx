<%@ WebHandler Language="C#" Class="manageHome" %>

using System;
using System.Web;
using System.Text;
using System.Threading;
using System.Windows.Forms;

public class manageHome : IHttpHandler
{
    private static object locker = new object();
    public void ProcessRequest(HttpContext context)

    {

        context.Response.ContentType = "text/plain";
        string number = context.Request["num"];
        string path = HttpContext.Current.Server.MapPath("/Jsons")+"\\json"+context.Request["fileID"]+".json";
        if (number != null)
        {
            DS.BLL.User.Delete(int.Parse(number));
            DS.BLL.User.DeleteDuty(int.Parse(number));
            System.IO.File.WriteAllText(path, DS.BLL.User.GetUsersJson(), Encoding.UTF8);
            context.Response.Write(true);
            return;
        }
       
        if (context.Request["groupList"] != null&context.Request["groupList"] != "-软件工程部-")
        {

            System.IO.File.WriteAllText(path, DS.BLL.User.SearchGroup(context.Request["groupList"]), Encoding.UTF8);
            return;
        }




        string result;
        if (context.Request["addNumber"]!=null&&context.Request["addNumber"]!=""&&!DS.BLL.User.Search(context.Request["addNumber"]))
        {
            result = "工号已存在！";
            context.Response.Write(result);
            return;
        }


        if (context.Request["addName"] != null&&context.Request["addNumber"]!="")
        {
            DS.Model.User user = new DS.Model.User
            {
                Number = int.Parse(context.Request["addNumber"]),
                Pwd = "1234",
                Name = context.Request["addName"],
                Sex = context.Request["addSex"],
                Phone = context.Request["addPhone"],
                Role = context.Request["addRole"],
                Group = context.Request["addGroup"],
                Date = DateTime.Now
            };
            lock (locker) {
                if ( DS.BLL.User.Add(user))
                {
                    result = "注册成功！";
                    
                }
                else
                {
                    result = "注册失败！";
                }
            }
            context.Response.Write(result);
        }

        lock (locker)
        {
            System.IO.File.WriteAllText(path, DS.BLL.User.GetUsersJson(), Encoding.UTF8);
        }


    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}