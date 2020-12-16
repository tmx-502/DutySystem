using System;
using System.Collections.Generic;
using System.Data;
using System.Windows.Forms;
using System.Collections;
using System.Web.Script.Serialization;
using Newtonsoft.Json;
using System.Text;


namespace DS.DAL
{
    /// <summary>
    /// 用户数据访问类
    /// </summary>
    public class User
    {
        #region  用户登录

        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="number"></param>
        /// <param name="pwd"></param>
        /// <returns></returns>
        public static int Login(string number, string pwd)
        {
            string strSql0 = "select * from TUsers where UNumber=" + number + "  ";
            DataTable dataTable0 = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql0).Tables[0];
            if (dataTable0.Rows.Count == 0)
            {
                return 4;
            }
            
            string strSql1 = "select * from TUsers where UNumber=" + number + " and URole='员工' ";
            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql1).Tables[0];
            if (dataTable.Rows.Count != 0)
            {
                string strSql2 = "select * from TUsers where UNumber=" + number + " and UPwd='" + pwd + "'";
                DataTable dataTable1 = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql2).Tables[0];
                if (dataTable1.Rows.Count != 0)
                {
                    return 0;
                }
                return 1;
            }
            else
            {
                string strSql2 = "select * from TUsers where UNumber=" + number + " and UPwd='" + pwd + "'";
                DataTable dataTable1 = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql2).Tables[0];
                if (dataTable1.Rows.Count != 0)
                {
                    return 2;
                }
                return 3;
            }


        }
        #endregion

        #region 添加用户
        /// <summary>
        /// 添加用户方法
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public static bool Add(DS.Model.User user)
        {

            string strSql = "insert into TUsers (UNumber,UName,UPwd,USex,UPhone,URole,UAddTime,UGroup) values (" + user.Number + ",'" + user.Name + "','" + user.Pwd + "','" + user.Sex + "','" + user.Phone + "','" + user.Role + "','" + user.Date + "','" + user.Group + "')";


            int i = DS.MsSqlHelper.YFMsSqlHelper.ExecuteSql(strSql);


            if (i > 0)
            {
                return true;
            }

            return false;
        }
        /// <summary>
        /// 验证用户是否已存在
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        public static bool Search(string number)
        {
            string strSql = "select * from TUsers where UNumber=" + number + "";

            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql).Tables[0];
            if (dataTable.Rows.Count == 0)
            {
                return true;
            }
            return false;
        }
        #endregion

        #region 用户展示


        public static List<DS.Model.User> List()
        {
            string strsql = "select * from TUsers order by URole, CASE WHEN [UGroup] = '车检一组' THEN '1' WHEN [UGroup] = '车检二组' THEN '2' WHEN [UGroup] = '车检三组' THEN '3' WHEN[UGroup] = '环保组' THEN '4' WHEN[UGroup] = '综合组' THEN '5' WHEN[UGroup] = '驾考组' THEN '6' WHEN[UGroup] = '车管业务组'THEN '7' WHEN[UGroup] = '技术支持组' THEN '8' ELSE[UGroup] END";
            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strsql).Tables[0];
            return DoList(dataTable);
        }

        public static List<DS.Model.User> DoList(DataTable dataTable)
        {
            excel = dataTable;
            List<DS.Model.User> list = new List<Model.User>();

            if (dataTable.Rows.Count != 0)
            {

                for (int i = 0; i < dataTable.Rows.Count; i++)
                {
                    DS.Model.User user = new Model.User
                    {
                        Number = int.Parse(dataTable.Rows[i]["UNumber"].ToString()),
                        Name = dataTable.Rows[i]["UName"].ToString(),
                        Sex = dataTable.Rows[i]["USex"].ToString(),
                        Phone = dataTable.Rows[i]["UPhone"].ToString(),
                        Role = dataTable.Rows[i]["URole"].ToString(),
                        Date = DateTime.Parse(dataTable.Rows[i]["UAddTime"].ToString())
                    };
                    list.Add(user);
                }

            }

            return list;
        }

        #endregion

        #region 用户删除

        public static bool Delete(int number)
        {

            string strsql = "delete from TUsers where UNumber=" + number + "";

            int value = DS.MsSqlHelper.YFMsSqlHelper.ExecuteSql(strsql);

            if (value > 0)
            {
                return true;
            }
            else { return false; }

        }

        public static bool DeleteDuty(int number)
        {

            string strsql = "delete from Duty where UNumber=" + number + "";

            int value = DS.MsSqlHelper.YFMsSqlHelper.ExecuteSql(strsql);

            if (value > 0)
            {
                return true;
            }
            else { return false; }

        }


        #endregion

        #region 用户修改
        public static bool Update(DS.Model.User user)
        {
           
            if (user.Pwd == null) { 
            string strsql = "update TUsers set UName='" + user.Name + "',USex='" + user.Sex + "',UPhone='" + user.Phone + "',URole='" + user.Role + "',UGroup='"+user.Group+"' where UNumber=" + user.Number + " ";
                int value = DS.MsSqlHelper.YFMsSqlHelper.ExecuteSql(strsql);
                if (value == 1)
                {
                    return true;
                }
                else { return false; }

            }
            else{
                string strsql = "update TUsers set UName='" + user.Name + "',UPwd='" + user.Pwd + "',USex='" + user.Sex + "',UPhone='" + user.Phone + "',URole='" + user.Role + "',UGroup='" + user.Group + "' where UNumber=" + user.Number + " ";
                int value = DS.MsSqlHelper.YFMsSqlHelper.ExecuteSql(strsql);
                if (value == 1)
                {
                    return true;
                }
                else { return false; }
            }
            

            
        }


        /// <summary>
        /// 预览原有信息
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        public static DS.Model.User GetUser(int number)
        {
            DS.Model.User user = new Model.User();
            string strsql = "select * from TUsers where UNumber=" + number + "";
            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strsql).Tables[0];
            if (dataTable.Rows.Count != 0)
            {
                user.Number = int.Parse(dataTable.Rows[0]["UNumber"].ToString());
                user.Name = dataTable.Rows[0]["UName"].ToString();
                user.Sex = dataTable.Rows[0]["USex"].ToString();
                user.Phone = dataTable.Rows[0]["UPhone"].ToString();
                user.Role = dataTable.Rows[0]["URole"].ToString();
                user.Pwd = dataTable.Rows[0]["UPwd"].ToString();
                user.Group = dataTable.Rows[0]["UGroup"].ToString();
            }
            return user;

        }
        #endregion

        #region 员工信息修改

        public static bool WorkerUpdata(DS.Model.User user)
        {
            string strsql = "update TUsers set UPwd='" + user.Pwd + "' where UNumber=" + user.Number + " ";
            int value = DS.MsSqlHelper.YFMsSqlHelper.ExecuteSql(strsql);
            if (value == 1)
            {
                return true;
            }
            else { return false; }
        }

        /// <summary>
        /// 预览原有信息
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        public static DS.Model.User GetWorker(int number)
        {
            DS.Model.User worker = new Model.User();
            string strsql = "select * from TUsers where UNumber=" + number + "";
            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strsql).Tables[0];
            if (dataTable.Rows.Count != 0)
            {
                worker.Number = int.Parse(dataTable.Rows[0]["UNumber"].ToString());
                worker.Name = dataTable.Rows[0]["UName"].ToString();
                worker.Sex = dataTable.Rows[0]["USex"].ToString();
                worker.Phone = dataTable.Rows[0]["UPhone"].ToString();
                worker.Role = dataTable.Rows[0]["URole"].ToString();
                worker.Date = DateTime.Parse(dataTable.Rows[0]["UAddTime"].ToString());
            }
            return worker;
        }


        #endregion

        #region 值班信息添加
        public static bool AddDuty(DS.Model.Duty duty)
        {
            string week;
            if (duty.DutyDate.DayOfWeek.ToString() == "Saturday") { week = "星期六"; }
            else if (duty.DutyDate.DayOfWeek.ToString() == "Sunday") { week = "星期天"; }
            else
            {
                week = "工作日";
            }
            string strSql2 = "select UName,UGroup from TUsers where UNumber = '" + duty.Number + "' ";
            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql2).Tables[0];
            string name = dataTable.Rows[0]["UName"].ToString();
            string group = dataTable.Rows[0]["UGroup"].ToString();
            string strSql = "insert into Duty (UNumber,UName,DutyTime,IsWeekend,UGroup,IsEat) values  (" + duty.Number + ",'" + name + "','" + duty.DutyDate + "','" + week + "','" + group + "','" + duty.IsEat+ "')";
            int i = DS.MsSqlHelper.YFMsSqlHelper.ExecuteSql(strSql);

            if (i > 0)
            {
                string strSql1 = "UPDATE  TUsers SET UAmount = UAmount + 1 where UNumber =" + duty.Number + "";
                DS.MsSqlHelper.YFMsSqlHelper.ExecuteSql(strSql1);
                return true;
            }

            return false;
        }
        public static bool Search(int number, DateTime date)
        {

            string strSql = "select * from Duty where UNumber='" + number + "' and DutyTime='" + date + "'";

            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql).Tables[0];
            if (dataTable.Rows.Count == 0)
            {
                return true;
            }
            return false;
        }

        #endregion

        #region 员工历史值班信息查看
        public static List<DS.Model.Duty> LookDuty(int number)
        {
            string strSql = "select * from Duty where UNumber='" + number + "'";
            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql).Tables[0];
            return DutyList(dataTable);
        }
        public static List<DS.Model.Duty> DutyList(DataTable dataTable)
        {
            List<DS.Model.Duty> dutyList = new List<DS.Model.Duty>();

            if (dataTable.Rows.Count != 0)
            {

                for (int i = 0; i < dataTable.Rows.Count; i++)
                {
                    DS.Model.Duty duty = new Model.Duty
                    {
                        Number = int.Parse(dataTable.Rows[i]["UNumber"].ToString()),
                        DutyDate = DateTime.Parse(dataTable.Rows[i]["DutyTime"].ToString()),
                        IsWeekend = dataTable.Rows[i]["IsWeekend"].ToString()

                    };
                    dutyList.Add(duty);
                }
            }
            return dutyList;
        }

        #endregion

        #region 值班信息删除
        public static bool Delete(int number, DateTime dateTime)
        {

            string strsql = "delete from Duty where UNumber=" + number + " and DutyTime='" + dateTime + "'";
            int value = DS.MsSqlHelper.YFMsSqlHelper.ExecuteSql(strsql);
            if (value == 1)
            {
                string strSql1 = "UPDATE  TUsers SET UAmount = UAmount - 1 where UNumber =" + number + "";
                DS.MsSqlHelper.YFMsSqlHelper.ExecuteSql(strSql1);
                return true;
            }
            else { return false; }
        }
        #endregion

        #region 值班信息查看
        /// <summary>
        /// 全部信息
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        public static string DutySearch(object group)
        {
            
            string group1 = group.ToString();
            string strSql;
            if (group1 == "-软件工程部-")
            {
                strSql = "select top(1000) * from Duty order by DutyTime desc";
            }
            else
            {
                strSql = "select top(1000) * from Duty where UGroup='"+group1+"' order by DutyTime desc";
            }
            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql).Tables[0];
            return CreateJsonParameters(dataTable);
        }

        public static string SearchGroup(string group)
        {
            string sql = "select * from Tusers where UGroup='" + group+ "'";
            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(sql).Tables[0];
            return CreateJsonParameters(dataTable);
        }
        /// <summary>
        /// 姓名查询
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        public static string DutySearch(string name)
        {

            string strSql = "select top(1000) * from Duty where UName='" + name + "' order by ID desc, DutyTime desc  ";
            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql).Tables[0];
            return CreateJsonParameters(dataTable);
        }

        /// <summary>
        /// 工号查询
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        public static string DutySearch(int number)
        {
            string strSql = "select top(1000) * from Duty where UNumber='" + number + "' order by ID desc, DutyTime desc";
            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql).Tables[0];
            return CreateJsonParameters(dataTable);
        }

        /// <summary>
        /// 日期查询
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        public static string DutySearch(DateTime dateTime, DateTime dateTime1,string Querygroup)
        {
            string strSql;
            if (Querygroup == "-软件工程部-")
            {
                strSql = "select top(1000) * from Duty where DutyTime>='" + dateTime + "'and DutyTime<='" + dateTime1 + "' order by DutyTime desc,CASE WHEN [UGroup] = '车检一组' THEN '1' WHEN [UGroup] = '车检二组' THEN '2' WHEN [UGroup] = '车检三组' THEN '3' WHEN[UGroup] = '环保组' THEN '4' WHEN[UGroup] = '综合组' THEN '5' WHEN[UGroup] = '驾考组' THEN '6' WHEN[UGroup] = '车管业务组'THEN '7' WHEN[UGroup] = '技术支持组' THEN '8' ELSE[UGroup] END ";
            }
            else
            {
               strSql = "select top(1000) * from Duty where DutyTime>='" + dateTime + "'and DutyTime<='" + dateTime1 + "' and UGroup='"+Querygroup+"' order by DutyTime desc,CASE WHEN [UGroup] = '车检一组' THEN '1' WHEN [UGroup] = '车检二组' THEN '2' WHEN [UGroup] = '车检三组' THEN '3' WHEN[UGroup] = '环保组' THEN '4' WHEN[UGroup] = '综合组' THEN '5' WHEN[UGroup] = '驾考组' THEN '6' WHEN[UGroup] = '车管业务组'THEN '7' WHEN[UGroup] = '技术支持组' THEN '8' ELSE[UGroup] END ";
            }
            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql).Tables[0];
            //return DutyShowList(dataTable);
            return CreateJsonParameters(dataTable);
        }

        public static string DutySearch(int number, DateTime dateTime)
        {
            string strSql = "select top(1000)* from Duty  where UNumber='" + number + "'and DutyTime='" + dateTime + "' order by ID desc,DutyTime desc";
            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strSql).Tables[0];
            //return DutyShowList(dataTable);
            return CreateJsonParameters(dataTable);
        }

       
        #endregion
        
        #region 导出表
        public static DataTable excel;
        public static void OutDataToExcel(System.Data.DataTable srcDataTable, string excelFilePath)
        {

            Microsoft.Office.Interop.Excel.Application xlApp = new Microsoft.Office.Interop.Excel.Application();

            object missing = System.Reflection.Missing.Value;
            //导出到execl   

            try

            {

                if (xlApp == null)

                {

                    MessageBox.Show("无法创建Excel对象，可能您的电脑未安装Office Excel!");

                    return;

                }



                Microsoft.Office.Interop.Excel.Workbooks xlBooks = xlApp.Workbooks;

                Microsoft.Office.Interop.Excel.Workbook xlBook = xlBooks.Add(Microsoft.Office.Interop.Excel.XlWBATemplate.xlWBATWorksheet);

                Microsoft.Office.Interop.Excel.Worksheet xlSheet = (Microsoft.Office.Interop.Excel.Worksheet)xlBook.Worksheets[1];



                //让后台执行设置为不可见，为true的话会看到打开一个Excel，然后数据在往里写  

                xlApp.Visible = false;

                object[,] objData = new object[srcDataTable.Rows.Count + 1, srcDataTable.Columns.Count];

                //首先将数据写入到一个二维数组中  

                for (int i = 0; i < srcDataTable.Columns.Count; i++)

                {

                    objData[0, i] = srcDataTable.Columns[i].ColumnName;

                }

                if (srcDataTable.Rows.Count > 0)

                {

                    for (int i = 0; i < srcDataTable.Rows.Count; i++)

                    {

                        for (int j = 0; j < srcDataTable.Columns.Count; j++)

                        {

                            objData[i + 1, j] = srcDataTable.Rows[i][j];

                        }

                    }

                }



                string startCol = "A";

                int iCnt = (srcDataTable.Columns.Count / 26);

                string endColSignal = (iCnt == 0 ? "" : ((char)('A' + (iCnt - 1))).ToString());

                string endCol = endColSignal + ((char)('A' + srcDataTable.Columns.Count - iCnt * 26 - 1)).ToString();

                Microsoft.Office.Interop.Excel.Range range = xlSheet.get_Range(startCol + "1", endCol + (srcDataTable.Rows.Count - iCnt * 26 + 1).ToString());



                range.Value = objData; //给Exccel中的Range整体赋值  

                range.EntireColumn.AutoFit(); //设定Excel列宽度自适应  

                xlSheet.get_Range(startCol + "1", endCol + "1").Font.Bold = 1;//Excel文件列名 字体设定为Bold  


                //设置禁止弹出保存和覆盖的询问提示框  

                xlApp.DisplayAlerts = false;

                xlApp.AlertBeforeOverwriting = true;

                if (xlSheet != null)
                {
                    xlSheet.SaveAs(excelFilePath, missing, missing, missing, missing, missing, missing, missing, missing, missing);

                    xlApp.Quit();
                    //KillProcess(xlApp);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("导出失败！");
            }

        }

        #endregion
        

        #region DataTable 转换为Json 字符串       

        public static string GetUsersJson()
        {
            string strsql = "select * from TUsers order by URole, CASE WHEN [UGroup] = '车检一组' THEN '1' WHEN [UGroup] = '车检二组' THEN '2' WHEN [UGroup] = '车检三组' THEN '3' WHEN[UGroup] = '环保组' THEN '4' WHEN[UGroup] = '综合组' THEN '5' WHEN[UGroup] = '驾考组' THEN '6' WHEN[UGroup] = '车管业务组'THEN '7' WHEN[UGroup] = '技术支持组' THEN '8' ELSE[UGroup] END";
            DataTable dataTable = DS.MsSqlHelper.YFMsSqlHelper.Query(strsql).Tables[0];
            return CreateJsonParameters(dataTable);
        }

        public static string CreateJsonParameters(DataTable dt)
        {
            StringBuilder JsonString = new StringBuilder();
            //Exception Handling        
            
                JsonString.Append("{ ");
                JsonString.Append("\"code\": 0,\"msg\":\"\",\"count\":"+dt.Rows.Count+",\"data\": [");
            if (dt != null && dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    JsonString.Append("{ ");
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        if (j < dt.Columns.Count - 1)
                        {
                            JsonString.Append("\"" + dt.Columns[j].ColumnName.ToString() + "\":" + "\"" + dt.Rows[i][j].ToString() + "\",");
                        }
                        else if (j == dt.Columns.Count - 1)
                        {
                            JsonString.Append("\"" + dt.Columns[j].ColumnName.ToString() + "\":" + "\"" + dt.Rows[i][j].ToString() + "\"");
                        }
                    }
                    /**//**/
                    /**//*end Of String*/
                    if (i == dt.Rows.Count - 1)
                    {
                        JsonString.Append("} ");
                    }
                    else
                    {
                        JsonString.Append("}, ");
                    }
                }
            }
            JsonString.Append("]}");
                return JsonString.ToString();
           
            
        }
        #endregion
    }
}
