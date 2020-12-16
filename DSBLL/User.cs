using System;
using System.Collections.Generic;
using System.Data;

namespace DS.BLL
{
    public class User
    {
        public static bool Update(DS.Model.User user)
        {
            return DS.DAL.User.Update(user);
        }

        public static bool Delete(int number)
        {
            return DS.DAL.User.Delete(number);
        }
        public static List<DS.Model.User> List()
        {
            return DS.DAL.User.List();
        }

        public static int Login(string number, string pwd)
        {
            return DS.DAL.User.Login(number, pwd);
        }

        public static bool Add(DS.Model.User user)
        {
            return DS.DAL.User.Add(user);
        }

        public static bool Search(string number)
        {
            return DS.DAL.User.Search(number);
        }
        public static string SearchGroup(string group)
        {
            return DS.DAL.User.SearchGroup(group);
        }

        public static DS.Model.User GetUser(int number)
        {
            return DS.DAL.User.GetUser(number);
        }

        public static bool WorkerUpdate(DS.Model.User worker)
        {
            return DS.DAL.User.WorkerUpdata(worker);
        }
        public static DS.Model.User GetWorker(int number)
        {
            return DS.DAL.User.GetWorker(number);
        }

        public static bool AddDuty(DS.Model.Duty duty)
        {
            return DS.DAL.User.AddDuty(duty);
        }
        public static bool Search(int number, DateTime date)
        {
            return DS.DAL.User.Search(number, date);
        }

        public static List<DS.Model.Duty> LookList(int number)
        {
            return DAL.User.LookDuty(number);
        }

        public static bool Delete(int number, DateTime dateTime)
        {
            return DS.DAL.User.Delete(number, dateTime);
        }

        public static string DutySearch(int number)
        {
            return DS.DAL.User.DutySearch(number);
        }
        public static string DutySearch(object group)
        {
            return DS.DAL.User.DutySearch(group);
        }
        public static string DutySearch(string name)
        {
            return DS.DAL.User.DutySearch(name);
        }

        public static bool DeleteDuty(int number)
        {
            return DS.DAL.User.DeleteDuty(number);
        }

        public static string DutySearch(DateTime dateTime, DateTime dateTime1,string Querygroup)
        {
            return DS.DAL.User.DutySearch(dateTime,dateTime1,Querygroup);
        }
        public static string DutySearch(int number,DateTime dateTime)
        {
            return DS.DAL.User.DutySearch(number, dateTime);
        }
        
       
        public static string GetUsersJson()
        {
            return DS.DAL.User.GetUsersJson();
        }
    }
}
