<%@ WebHandler Language="C#" Class="userUpdate" %>

using System;
using System.Web;
using System.Text;

public class userUpdate : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        DS.Model.User user;
        bool isPwd = bool.Parse(context.Request["upIsPwd"]);
        string path = HttpContext.Current.Server.MapPath("/Jsons")+"\\json"+context.Request["fileID"]+".json";
        if (isPwd)
        {
            user = new DS.Model.User
            {
                Number = int.Parse(context.Request["upNumber"]),
                Name = context.Request["upName"],
                Phone = context.Request["upPhone"],
                Sex = context.Request["upSex"],
                Role = context.Request["upRole"],
                Pwd = "1234",
                Group = context.Request["upRole"]

        };
    }
        else
        {
            user = new DS.Model.User
            {
                Number = int.Parse(context.Request["upNumber"]),
                Name = context.Request["upName"],
                Phone = context.Request["upPhone"],
                Sex = context.Request["upSex"],
                Role = context.Request["upRole"],
                Group = context.Request["upGroup"]
            };
        }

        bool result;
if (DS.BLL.User.Update(user) == true)
{
    result = true;
    System.IO.File.WriteAllText(path, DS.BLL.User.GetUsersJson(), Encoding.UTF8);

}
else
{
    result = false;


}
context.Response.Write(result);
    }
    public bool IsReusable
{
    get
    {
        return false;
    }
}

}



