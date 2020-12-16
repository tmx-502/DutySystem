<%@ WebHandler Language="C#" Class="login" %>

using System;
using System.Web;

public class login : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
      
              string id = context.Request["id"];
            string pwd = context.Request["pwd"];
            
             int value = DS.BLL.User.Login(id, pwd);
              context.Response.Write(value);

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}