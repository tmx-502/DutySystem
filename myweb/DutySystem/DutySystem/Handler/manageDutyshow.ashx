<%@ WebHandler Language="C#" Class="manageDutyshow" %>
using System;
using System.Web;
using System.Text;
using System.Data;
using System.Text.RegularExpressions;


public class manageDutyshow : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string getName;
        string addResult;
        string path = HttpContext.Current.Server.MapPath("/Jsons") + "\\json" + context.Request["fileID"] + ".json";

        if (context.Request["checkID"] != null)
        {
            string checkID = context.Request["checkID"];
            try
            {
                string sql = "SELECT UName FROM TUsers WHERE (UNumber = " + checkID + ")";
                System.Data.DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(sql).Tables[0];
                getName = dataTable.Rows[0]["UName"].ToString();
                context.Response.Write(getName);
            }
            catch (Exception)
            {
                if (checkID == "")
                {
                    getName = null;
                }
                else { getName = "用户不存在"; }
                context.Response.Write(getName);
            }
            return;
        }
        if (context.Request["setID"] != null && context.Request["setDate"] != null)
        {

            int setID = int.Parse(context.Request["setID"]);
            DateTime setDate = DateTime.Parse(context.Request["setDate"]);
            bool setEat = bool.Parse(context.Request["setEat"]);
            if (DS.BLL.User.Search(setID, setDate) != true)
            {
                addResult = "该值班信息已存在";
            }
            else
            {
                DS.Model.Duty duty = new DS.Model.Duty();
                duty.Number = setID;
                duty.DutyDate = setDate;
                duty.IsEat = setEat;
                bool result = DS.BLL.User.AddDuty(duty);
                if (result)
                {
                    addResult = "添加成功";
                    System.IO.File.WriteAllText(path, DS.BLL.User.DutySearch(int.Parse(context.Request["setID"])), Encoding.UTF8);

                    #region 日志打印
                    string strSql = "select UName from TUsers where UNumber = '" + duty.Number + "' ";
                    DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql).Tables[0];
                    string name = dataTable.Rows[0]["UName"].ToString();
                    if (int.Parse(context.Request["fileID"]) != setID)
                    {
                        string strSql1 = "select UName from TUsers where UNumber = '" + int.Parse(context.Request["fileID"]) + "' ";
                        DataTable dataTable1 = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql1).Tables[0];
                        string name1 = dataTable1.Rows[0]["UName"].ToString();
                        DSUtil.Logger.Create("log.log", "").Info("管理员[" + name1 + "]新增[" + name + "]" + setDate.ToShortDateString() + " 的值班");
                    }
                    else
                    {
                        DSUtil.Logger.Create("log.log", "").Info("[" + name + "]新增 " + setDate.ToShortDateString() + " 的值班");
                    }
                    #endregion
                }
                else
                {
                    addResult = "添加失败";
                }

            }
            context.Response.Write(addResult);
            return;
        }


        if (context.Request["deleteID"] != null && context.Request["deleteDate"] != null)
        {
            bool deleteResult = DS.BLL.User.Delete(int.Parse(context.Request["deleteID"]), DateTime.Parse(context.Request["deleteDate"]));
            context.Response.Write(deleteResult);
            if (deleteResult)
            {
                     #region 日志打印
                    string strSql = "select UName from TUsers where UNumber = '" + int.Parse(context.Request["deleteID"]) + "' ";
                    DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql).Tables[0];
                    string name = dataTable.Rows[0]["UName"].ToString();
                    if (int.Parse(context.Request["fileID"]) != int.Parse(context.Request["deleteID"]))
                    {
                        string strSql1 = "select UName from TUsers where UNumber = '" + int.Parse(context.Request["fileID"]) + "' ";
                        DataTable dataTable1 = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql1).Tables[0];
                        string name1 = dataTable1.Rows[0]["UName"].ToString();
                        DSUtil.Logger.Create("log.log", "").Info("管理员 [" + name1 + "] 删除了[" + name + "]" + DateTime.Parse(context.Request["deleteDate"]).ToShortDateString() + " 的值班");
                    }
                    else
                    {
                        DSUtil.Logger.Create("log.log", "").Info("[" + name + "]删除了" + DateTime.Parse(context.Request["deleteDate"]).ToShortDateString() + "的值班");
                    }
                    #endregion
            }
            return;
        }

        if (context.Request["QueryData"] != null & context.Request["QueryData"] != "")
        {
            string str = "未查询到记录";
            string QueryData = context.Request["QueryData"];
            string[] sArray = Regex.Split(QueryData, " ~ ", RegexOptions.IgnoreCase);
            {
                string jsonStr = DS.BLL.User.DutySearch(DateTime.Parse(sArray[0]), DateTime.Parse(sArray[1]), context.Request["Querygroup"]);
                if (jsonStr == null)
                {
                    context.Response.Write(str);
                    return;
                }
                System.IO.File.WriteAllText(path, jsonStr, Encoding.UTF8);
                return;
            }
        }
        else if (context.Request["QueryData1"] != null)
        {
            string str = "未查询到记录";
            string QueryData1 = context.Request["QueryData1"];
            Object Querygroup = context.Request["Querygroup"];
            if (QueryData1 == "")
            {
                System.IO.File.WriteAllText(path, DS.BLL.User.DutySearch(Querygroup), Encoding.UTF8);
                return;
            }
            else
            {
                try
                {
                    string jsonStr = DS.BLL.User.DutySearch(int.Parse(QueryData1));
                    if (jsonStr == null)
                    {
                        context.Response.Write(str);

                    }
                    System.IO.File.WriteAllText(path, jsonStr, Encoding.UTF8);
                    return;
                }
                catch
                {
                    string jsonStr = DS.BLL.User.DutySearch(QueryData1);
                    if (jsonStr == null)
                    {
                        context.Response.Write(str);
                        return;
                    }
                    System.IO.File.WriteAllText(path, jsonStr, Encoding.UTF8);
                    return;
                }
            }
        }
        else if (DS.MsSqlHelper.YFMsSqlHelper.Query("SELECT * FROM TUsers WHERE (UNumber = '" + context.Request["fileID"] + "') AND (URole = '管理员')").Tables[0].Rows.Count > 0)
        {
            Object Querygroup = context.Request["Querygroup"];
            string Querygroup1 = context.Request["Querygroup"];
            System.IO.File.WriteAllText(path, DS.BLL.User.DutySearch(Querygroup), Encoding.UTF8);
            return;
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