using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Page_log : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        log.Value=fileToString(MapPath("/log.log"));
    }
    /// <summary>
    /// 获取文件中的数据
    /// </summary>
    /// <param name="args"></param>


    public static string fileToString(String filePath)
    {
        string strData = "";
        try
        {
            string line;
            // 创建一个 StreamReader 的实例来读取文件 ,using 语句也能关闭 StreamReader
            using (StreamReader sr = new StreamReader(filePath))
            {
                // 从文件读取并显示行，直到文件的末尾
                while ((line = sr.ReadLine()) != null)
                {
                    //Console.WriteLine(line);
                    strData += line+"\n";
                }
            }
        }
        catch (Exception e)
        {
            // 向用户显示出错消息
            Console.WriteLine("The file could not be read:");
            Console.WriteLine(e.Message);
        }
        return strData;
    }

    protected void clear_Click(object sender, EventArgs e)
    {
        DSUtil.Logger.Create("新建文本文档.txt", "").Clear();
    }

}