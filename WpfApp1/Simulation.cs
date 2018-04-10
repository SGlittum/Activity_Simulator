using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;

namespace Activity_Simulator
{
    class Simulation : ObservableObject
    {
        DatabaseHandler dbHandler = new DatabaseHandler();
        List<DataTypes> activityList = new List<DataTypes>();
        Person person = new Person();
        SequenceHandler sequence = new SequenceHandler();
        static Random rnd = new Random();
        public Thread simulationCaller;
        private DateTime _currentTime;
        private DateTime _startTime;
        private DateTime _endTime;
        private string _room;
        private string _activity;
        private int _dataSetIndex;
        private double _simulationSpeed;
        private double _personPositionX;
        private double _personPositionY;
        public bool SimulationSuspended = false;
        public DateTime CurrentTime
        {
            get
            {
                return _currentTime;
            }
            set
            {
                _currentTime = value;
                OnPropertyChanged("CurrentTime");
            }
        }
        public DateTime StartTime
        {
            get
            {
                return _startTime;
            }
            set
            {
                _startTime = value;
                OnPropertyChanged("StartTime");
            }
        }
        public DateTime EndTime
        {
            get
            {
                return _endTime;
            }
            set
            {
                _endTime = value;
                OnPropertyChanged("EndTime");
            }
        }
        public string Room
        {
            get
            {
                if (string.IsNullOrEmpty(_room))
                    return "Unknown";
                return _room;
            }
            set
            {
                _room = value;
                OnPropertyChanged("Room");
            }
        }
        public string Activity
        {
            get
            {
                if (string.IsNullOrEmpty(_activity))
                    return "Unknown";
                return _activity;
            }
            set
            {
                _activity = value;
                OnPropertyChanged("Activity");
            }
        }
        public int DataSetIndex
        {
            get
            {
                return _dataSetIndex;
            }
            set
            {
                _dataSetIndex = value;
            }
        }
        public double SimulationSpeed
        {
            get
            {
                if (_simulationSpeed == 0)
                    _simulationSpeed = 1;
                return _simulationSpeed;
            }
            set
            {
                _simulationSpeed = value;
                OnPropertyChanged("SimulationSpeed");
            }
        }
        public double PersonPositionX
        {
            get
            {
                return _personPositionX;
            }
            set
            {
                _personPositionX = value;
                OnPropertyChanged("PersonPositionX");
            }
        }
        public double PersonPositionY
        {
            get
            {
                return _personPositionY;
            }
            set
            {
                _personPositionY = value;
                OnPropertyChanged("PersonPositionY");
            }
        }
        public bool nextActivity;
        public int listIndex;

        public void StartSimulationThread()
        {
            simulationCaller = new Thread(new ThreadStart(StartSimulation));
            simulationCaller.Start();
        }

        public void StartSimulation()
        {
            listIndex = 0;
            activityList = dbHandler.GetActivityData(DataSetIndex);
            SetInitialPosition(activityList[listIndex].Activity);
            CurrentTime = activityList[listIndex].StartTime.AddSeconds(-1);
            while (1==1)
            {
                CurrentTime = CurrentTime.AddSeconds(1);
                if(CurrentTime < activityList[listIndex+1].StartTime)
                {
                    if(nextActivity == true)
                    {
                        SkipToNextActivity();
                        Thread animationCaller = new Thread(new ThreadStart(AnimateMovement));
                        animationCaller.Start();
                        CurrentTime = activityList[listIndex].StartTime;
                    }
                    StartTime = activityList[listIndex].StartTime;
                    EndTime = activityList[listIndex].EndTime;
                    Room = activityList[listIndex].Room;
                    Activity = activityList[listIndex].Activity;
                }
                else
                {
                    Thread animationCaller = new Thread(new ThreadStart(AnimateMovement));
                    animationCaller.Start();
                    listIndex++;
                }
                if (SimulationSuspended == true)
                {
                    try
                    {
                        Thread.Sleep(Timeout.Infinite);
                    }
                    catch(ThreadInterruptedException)
                    {
                        Thread.Sleep((int)(Math.Round(1000 / SimulationSpeed)));
                    }
                }
                else
                {
                    try
                    {
                        Thread.Sleep((int)(Math.Round(1000 / SimulationSpeed)));
                    }
                    catch(ThreadInterruptedException)
                    {
                        Thread.Sleep((int)(Math.Round(1000 / SimulationSpeed)));
                    }
                }
            }
        }
        private void SkipToNextActivity()
        {
            for(int i=listIndex;i<activityList.Count;i++)
            {
                if(activityList[i].Activity != activityList[listIndex].Activity)
                {
                    listIndex = i;
                    nextActivity = false;
                    break;
                }
            }
        }
        private void SetInitialPosition(string activity)
        {
            double xPos = 0;
            double yPos = 0;
            List<ConfigPositions> configPositionList = new List<ConfigPositions>();
            configPositionList = dbHandler.GetConfigPositions(1);
            for(int i=0;i<configPositionList.Count;i++)
            {
                if(configPositionList[i].Activity == activity)
                {
                    xPos = configPositionList[i].XPos;
                    yPos = configPositionList[i].YPos;
                    break;
                }
            }
            PersonPositionX = xPos;
            PersonPositionY = yPos;
        }
        private void AnimateMovement()
        {
            string currentRoom = activityList[listIndex - 1].Room;
            string targetRoom = activityList[listIndex].Room;
            string targetActivity = activityList[listIndex].Activity;
            List<Coordinates> coordsList = new List<Coordinates>();
            coordsList = person.MovePerson(currentRoom, targetRoom, targetActivity, 1);
            for(int i=0;i<coordsList.Count;i++)
            {
                if(coordsList[i].Dimension == "X")
                {
                    while(PersonPositionX < coordsList[i].Value)
                    {
                        PersonPositionX++;
                        Thread.Sleep((int)(Math.Round(10 / SimulationSpeed)));
                    }
                    while (PersonPositionX > coordsList[i].Value)
                    {
                        PersonPositionX--;
                        Thread.Sleep((int)(Math.Round(10 / SimulationSpeed)));
                    }
                }
                if(coordsList[i].Dimension == "Y")
                {
                    while(PersonPositionY < coordsList[i].Value)
                    {
                        PersonPositionY++;
                        Thread.Sleep((int)(Math.Round(10 / SimulationSpeed)));
                    }
                    while(PersonPositionY > coordsList[i].Value)
                    {
                        PersonPositionY--;
                        Thread.Sleep((int)(Math.Round(10 / SimulationSpeed)));
                    }
                }
            }

        }
        private DateTime _newStartDate;
        private DateTime _newEndDate;
        private DateTime _newStartTime;
        private DateTime _newEndTime;
        private string _newRoom;
        private string _newActivity;
        public DateTime NewStartDate
        {
            get
            {
                return _newStartDate;
            }
            set
            {
                _newStartDate = value;
                OnPropertyChanged("NewStartDate");
            }
        }
        public DateTime NewEndDate
        {
            get
            {
                return _newEndDate;
            }
            set
            {
                _newEndDate = value;
                OnPropertyChanged("NewEndDate");
            }
        }

        public DateTime NewStartTime
        {
            get
            {
                return _newStartTime;
            }
            set
            {
                _newStartTime = value;
                OnPropertyChanged("NewStartTime");
            }
        }
        public DateTime NewEndTime
        {
            get
            {
                return _newEndTime;
            }
            set
            {
                _newEndTime = value;
                OnPropertyChanged("NewEndTime");
            }
        }
        public string NewRoom
        {
            get
            {
                return _newRoom;
            }
            set
            {
                _newRoom = value;
                OnPropertyChanged("NewRoom");
            }
        }
        public string NewActivity
        {
            get
            {
                return _newActivity;
            }
            set
            {
                _newActivity = value;
                OnPropertyChanged("NewActivity");
            }
        }
        public void UpdateActivityList()
        {
            if (NewStartDate.Date + NewStartTime.TimeOfDay < CurrentTime)
            {
                ActivityViewModel.ShowMessageBox("Start time must be later than current time", "Error entering sequence");
            }
            else if (NewStartDate.Date + NewStartTime.TimeOfDay > NewEndDate.Date + NewEndTime.TimeOfDay)
            {
                ActivityViewModel.ShowMessageBox("Start time can not be later than end time", "Error entering sequence");
            }
            else if (NewActivity == "" || NewRoom == "")
            {
                ActivityViewModel.ShowMessageBox("Enter a room and activity combo", "Error entering sequence");
            }
            else
            {
                activityList = sequence.AddSequenceToList(activityList, listIndex, NewStartDate, NewEndDate, NewStartTime, NewEndTime, NewRoom, NewActivity);
            }
        }
        public void RandomizeSequence()
        {
            int randomIndex;
            NewStartTime = activityList[listIndex + 1].StartTime;
            NewEndTime = activityList[listIndex + 1].EndTime;
            List<DataTypes> RoomActivityList = new List<DataTypes>();
            RoomActivityList = dbHandler.GetRoomActivityCombo();
            randomIndex = rnd.Next(RoomActivityList.Count);
            NewRoom = RoomActivityList[randomIndex].Room;
            NewActivity = RoomActivityList[randomIndex].Activity;
        }
        private int _replayTime;
        public int ReplayTime
        {
            get
            {
                if (string.IsNullOrEmpty(Convert.ToString(_replayTime)))
                    _replayTime = 0;
                return _replayTime;
            }
            set
            {
                _replayTime = value;
            }
        }
        public void Replay()
        {
            DateTime tempCurrentTime = CurrentTime;
            tempCurrentTime = tempCurrentTime.AddMinutes((double)(-ReplayTime));
            for(int i = 0;i<activityList.Count;)
            {
                if(tempCurrentTime>=activityList[i].StartTime && tempCurrentTime<activityList[i].EndTime)
                {
                    listIndex = i;
                    CurrentTime = tempCurrentTime;
                    break;
                }
                else if(tempCurrentTime>=activityList[i].EndTime && tempCurrentTime<activityList[i+1].StartTime)
                {
                    listIndex = i + 1;
                    CurrentTime = tempCurrentTime;
                    break;
                }
                else if(tempCurrentTime<activityList[i].StartTime)
                {
                    MessageBox.Show("Replay time outside of simulation boundaries", "Error!");
                    break;
                }
                else
                {
                    i++;
                }
            }
        }
        public void ExportToCSV()
        {
            ImportExport export = new ImportExport();
            export.ExportToCSV(DataSetIndex, activityList);
        }
        public DateTime GetFirstDateTime()
        {
            return dbHandler.GetActivityData(DataSetIndex)[listIndex].StartTime;
        }
    }
}
