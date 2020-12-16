using System;

namespace DS.Model
{
    public class User
    {

        private int number;
        private string name;
        private string pwd;
        private string sex;
        private string phone;
        private string role;
        private DateTime date;
        private string group;
        private int amount;


        public int Number { get => number; set => number = value; }
        public string Name { get => name; set => name = value; }
        public string Pwd { get => pwd; set => pwd = value; }
        public string Sex { get => sex; set => sex = value; }
        public string Phone { get => phone; set => phone = value; }
        public string Role { get => role; set => role = value; }
        public DateTime Date { get => date; set => date = value; } 
        public string Group { get => group; set => group = value; }
        public int Amount { get => amount; set => amount = value; }
    }

    public class Duty
    {

        private int number;
        private string name;
        private DateTime dutyDate;
        private string isWeekend;
        private string group;
        private bool isEat;

        public int Number { get => number; set => number = value; }
        public DateTime DutyDate { get => dutyDate; set => dutyDate = value; }
        public string IsWeekend { get => isWeekend; set => isWeekend = value; }
        public string Name { get => name; set => name = value; }
        public string Group { get => group; set => group = value; }
        public bool IsEat { get => isEat; set => isEat = value; }
    }
}
