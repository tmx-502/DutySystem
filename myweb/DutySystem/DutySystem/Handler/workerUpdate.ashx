<%@ WebHandler Language="C#" Class="workerUpdate" %>

using System;
using System.Web;

public class workerUpdate : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string id = context.Request["id"];
        string npwd = context.Request["npwd"];
        string pwd = context.Request["pwd"];
        string result="修改失败！";
        DS.Model.User userPwd = DS.BLL.User.GetUser(int.Parse(id));
        if (npwd == userPwd.Pwd)
        {
            DS.Model.User worker = new DS.Model.User
            {
                Number = int.Parse(id),
                Pwd = pwd
            };
            if (DS.BLL.User.WorkerUpdate(worker) == true)result="修改成功！";
        }
        else { result = "当前密码不正确"; }
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