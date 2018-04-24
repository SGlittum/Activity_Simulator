using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Activity_Simulator
{
    class ConfigHandler:ObservableObject
    {
        List<ConfigPositions> configPositionList = new List<ConfigPositions>();
        private string _bedCoords;
        private string _toiletCoords;
        private string _showerAreaCoords;
        private string _diningTableCoords;
        private string _basinCoords;
        private string _sofaCoords;
        private string _entranceCoords;
        private string _doorsCoords;
        public string BedCoords
        {
            get
            {
                return _bedCoords;
            }
            set
            {
                _bedCoords = value;
                OnPropertyChanged("BedCoords");
            }
        }
        public string ToiletCoords
        {
            get
            {
                return _toiletCoords;
            }
            set
            {
                _toiletCoords = value;
                OnPropertyChanged("ToiletCoords");
            }
        }
        public string ShowerCoords
        {
            get
            {
                return _showerAreaCoords;
            }
            set
            {
                _showerAreaCoords = value;
                OnPropertyChanged("ShowerCoords");
            }
        }
        public string DiningCoords
        {
            get
            {
                return _diningTableCoords;
            }
            set
            {
                _diningTableCoords = value;
                OnPropertyChanged("DiningCoords");
            }
        }
        public string BasinCoords
        {
            get
            {
                return _basinCoords;
            }
            set
            {
                _basinCoords = value;
                OnPropertyChanged("BasinCoords");
            }
        }
        public string SofaCoords
        {
            get
            {
                return _sofaCoords;
            }
            set
            {
                _sofaCoords = value;
                OnPropertyChanged("SofaCoords");
            }
        }
        public string EntranceCoords
        {
            get
            {
                return _entranceCoords;
            }
            set
            {
                _entranceCoords = value;
                OnPropertyChanged("EntranceCoords");
            }
        }
        public string DoorsCoords
        {
            get
            {
                return _doorsCoords;
            }
            set
            {
                _doorsCoords = value;
                OnPropertyChanged("DoorsCoords");
            }
        }
        public void AddActivityLocations()
        {
            DatabaseHandler dbHandler = new DatabaseHandler();
            List<string> activityList = new List<string>();
            activityList = dbHandler.GetActivityList();
            for(int i=0;i<activityList.Count;i++)
            {
                ConfigPositions configPosition = new ConfigPositions();
                configPosition.Activity = activityList[i];
                switch(activityList[i])
                {
                    case "Sleeping":
                        configPosition.ActivityLocation = "Bed";
                        break;
                    case "Toileting":
                        configPosition.ActivityLocation = "Toilet";
                        break;
                    case "Showering":
                        configPosition.ActivityLocation = "ShowerArea";
                        break;
                    case "Breakfast":
                        configPosition.ActivityLocation = "DiningTable";
                        break;
                    case "Grooming":
                        configPosition.ActivityLocation = "Basin";
                        break;
                    case "SpareTime/TV":
                        configPosition.ActivityLocation = "Sofa";
                        break;
                    case "Leaving":
                        configPosition.ActivityLocation = "Entrance";
                        break;
                    case "Lunch":
                        configPosition.ActivityLocation = "DiningTable";
                        break;
                    case "Snack":
                        configPosition.ActivityLocation = "DiningTable";
                        break;
                }
                configPositionList.Add(configPosition);
            }
        }
        public void SaveConfigChanges()
        {
            double bedX;
            double bedY;
            double toiletX;
            double toiletY;
            double showerAreaX;
            double showerAreaY;
            double diningTableX;
            double diningTableY;
            double basinX;
            double basinY;
            double sofaX;
            double sofaY;
            double entranceX;
            double entranceY;
            double doorsY;

            char[] separator = new char[] { ';' };

            AddActivityLocations();

            bedX = Convert.ToDouble(BedCoords.Split(separator)[0]);
            bedY = Convert.ToDouble(BedCoords.Split(separator)[1]);
            toiletX = Convert.ToDouble(ToiletCoords.Split(separator)[0]);
            toiletY = Convert.ToDouble(ToiletCoords.Split(separator)[1]);
            showerAreaX = Convert.ToDouble(ShowerCoords.Split(separator)[0]);
            showerAreaY = Convert.ToDouble(ShowerCoords.Split(separator)[1]);
            diningTableX = Convert.ToDouble(DiningCoords.Split(separator)[0]);
            diningTableY = Convert.ToDouble(DiningCoords.Split(separator)[1]);
            basinX = Convert.ToDouble(BasinCoords.Split(separator)[0]);
            basinY = Convert.ToDouble(BasinCoords.Split(separator)[1]);
            sofaX = Convert.ToDouble(SofaCoords.Split(separator)[0]);
            sofaY = Convert.ToDouble(SofaCoords.Split(separator)[1]);
            entranceX = Convert.ToDouble(EntranceCoords.Split(separator)[0]);
            entranceY = Convert.ToDouble(EntranceCoords.Split(separator)[1]);
            doorsY = Convert.ToDouble(DoorsCoords.Split(separator)[1]);
            AddActivityCoords(bedX, nameof(bedX));
            AddActivityCoords(bedY, nameof(bedY));
            AddActivityCoords(toiletX, nameof(toiletX));
            AddActivityCoords(toiletY, nameof(toiletY));
            AddActivityCoords(showerAreaX, nameof(showerAreaX));
            AddActivityCoords(showerAreaY, nameof(showerAreaY));
            AddActivityCoords(diningTableX, nameof(diningTableX));
            AddActivityCoords(diningTableY, nameof(diningTableY));
            AddActivityCoords(basinX, nameof(basinX));
            AddActivityCoords(basinY, nameof(basinY));
            AddActivityCoords(sofaX, nameof(sofaX));
            AddActivityCoords(sofaY, nameof(sofaY));
            AddActivityCoords(entranceX, nameof(entranceX));
            AddActivityCoords(entranceY, nameof(entranceY));
            DatabaseHandler dbHandler = new DatabaseHandler();
            dbHandler.SaveDoorsLocationToDatabase(doorsY, 1);
            dbHandler.SaveConfigLocationToDatabase(configPositionList, 1);
        }
        public void AddActivityCoords(double position, string variableName)
        {
            for(int i=0;i<configPositionList.Count;i++)
            {
                if(variableName.ToUpperInvariant().Contains(configPositionList[i].ActivityLocation.ToUpperInvariant()) && variableName.ToUpperInvariant().Contains("x".ToUpperInvariant()))
                {
                    configPositionList[i].XPos = position;
                }
                else if(variableName.ToUpperInvariant().Contains(configPositionList[i].ActivityLocation.ToUpperInvariant()) && variableName.ToUpperInvariant().Contains("y".ToUpperInvariant()))
                {
                    configPositionList[i].YPos = position;
                }
            }
        }
    }
}
