using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace DSUtil
{
    /// <summary>
    /// 日志类
    /// </summary>
    public class Logger
    {
        /// <summary>
        /// 单例对象
        /// </summary>
        private static readonly Logger logger = new Logger();
        /// <summary>
        /// 文件夹名
        /// </summary>
        private static string FilePath;
        /// <summary>
        /// 文件名
        /// </summary>
        private static string FileName;
        /// <summary>
        /// 私有化自身构造器
        /// </summary>
        private Logger() { }
        /// <summary>
        /// 创建单例对象
        /// </summary>
        /// <param name="name">文件名</param>
        /// <returns>返回Logger</returns>
        public static Logger Create(string name, string directoryName)
        {
            var currentDir = AppDomain.CurrentDomain.BaseDirectory;
            FilePath = currentDir + "//" + directoryName;
            FileName = name;
            return logger;
        }
        /// <summary>
        /// 写入日志
        /// </summary>
        /// <param name="content">内容</param>
        /// <param name="type">类型</param>
        public void Write(string content, string type = "None", bool useTD = false)
        {
            var allPath = FilePath + "//" + FileName;
            try
            {
                lock (typeof(Logger))
                {
                    if (!Directory.Exists(FilePath))
                        Directory.CreateDirectory(FilePath);
                    using (var wr = new StreamWriter(path: allPath, append: true))
                    {
                        wr.WriteLine("[{0}]:{1}\t{2}", type, DateTime.Now.GetDateTimeFormats('F')[0].Trim(), content);
                    }
                }
            }
            catch (Exception e)
            {
                throw new Exception(e + "创建日志文件失败!");
            }
        }
        /// <summary>
        /// 写入信息日志
        /// </summary>
        /// <param name="content">内容</param>
        public void Info(string content) => Write(content, type: "信息");
        /// <summary>
        /// 写入警告日志
        /// </summary>
        /// <param name="content">内容</param>
        public void Warn(string content) => Write(content, type: "警告");
        /// <summary>
        /// 写入错误日志
        /// </summary>
        /// <param name="content">内容</param>
        public void Error(string content) => Write(content, type: "错误");
        /// <summary>
        /// 写入致命错误日志
        /// </summary>
        /// <param name="content">内容</param>
        public void Fatal(string content) => Write(content, type: "致命错误");
        /// <summary>
        /// 写入查错日志
        /// </summary>
        /// <param name="content">内容</param>
        public void Debug(string content) => Write(content, type: "Debug");
        /// <summary>
        /// 清理日志文件
        /// </summary>
        public void Clear()
        {
            var allPath = FilePath + "//" + FileName;
            File.Delete(allPath);
        }
    }
}
