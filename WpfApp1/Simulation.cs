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
        List<ConfigPositions> configPositionList = new List<ConfigPositions>();
        Person person = new Person();
        SequenceHandler sequence = new SequenceHandler();
        Thread animationCaller;
        static Random rnd = new Random();
        public Thread simulationCaller;
        public Thread fastmodeCaller;
        private DateTime _currentTime;
        private DateTime _startTime;
        private DateTime _endTime;
        private string _room;
        private string _activity;
        private string _nextActivity;
        private DateTime _nextActivityStartTime;
        private int _dataSetIndex;
        private double _simulationSpeed;
        private double _personPositionX;
        private double _personPositionY;
        public bool SimulationSuspended = false;
        bool animationThreadFinished = true;
        bool fastmodeThreadFinished = true;
        bool simulationThreadFinished = true;
        public bool fastMode;
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
        public string NextActivity
        {
            get
            {
                if (string.IsNullOrEmpty(_nextActivity))
                    return "Unknown";
                return _nextActivity;
            }
            set
            {
                _nextActivity = value;
                OnPropertyChanged("NextActivity");
            }
        }
        public DateTime NextActivityStartTime
        {
            get
            {
                return _nextActivityStartTime;
            }
            set
            {
                _nextActivityStartTime = value;
                OnPropertyChanged("NextActivityStartTime");
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
        public bool nextActivity = false;
        public int listIndex;

        public void StartSimulationThread()
        {
            if (simulationThreadFinished)
            {
                simulationThreadFinished = false;
                simulationCaller = new Thread(new ThreadStart(StartSimulation));
                simulationCaller.Start();
            }
            else
            {
                ActivityViewModel.ShowMessageBox("Simulation already running", "Error!");
            }
        }
        public void ActivateFastMode()
        {
            fastmodeThreadFinished = false;
            while(fastMode && !SimulationSuspended)
            {
                SkipToNextActivity();
                Thread.Sleep(5000);
            }
            fastmodeThreadFinished = true;
        }
        public void StartSimulation()
        {
            listIndex = 0;
            activityList = dbHandler.GetActivityData(DataSetIndex);
            SetInitialPosition(activityList[listIndex].Activity);
            CurrentTime = activityList[listIndex].StartTime.AddSeconds(-1);
            Room = activityList[listIndex].Room;
            Activity = activityList[listIndex].Activity;
            configPositionList = dbHandler.GetConfigPositions(1);
            ShowNextActivity();
            //Simulation loop
            while (listIndex <= activityList.Count-1)
            {
                Room = activityList[listIndex].Room;
                Activity = activityList[listIndex].Activity;
                if (fastMode && fastmodeThreadFinished)
                {
                    fastmodeCaller = new Thread(new ThreadStart(ActivateFastMode));
                    fastmodeCaller.Start();
                }
                for (int i = 0; i < configPositionList.Count; i++)
                {
                    if (configPositionList[i].Activity == Activity)
                    {
                        if(PersonPositionX != configPositionList[i].XPos && PersonPositionY != configPositionList[i].YPos && listIndex != 0 && animationThreadFinished)
                        {
                            animationThreadFinished = false;
                            animationCaller = new Thread(new ThreadStart(AnimateMovement));
                            animationCaller.Start();
                        }
                    }
                }
                CurrentTime = CurrentTime.AddSeconds(1);
                if (CurrentTime < activityList[listIndex + 1].StartTime)
                {
                    if (nextActivity == true)
                    {
                        SkipToNextActivity();
                    }
                }
                else
                {
                    Room = activityList[listIndex].Room;
                    Activity = activityList[listIndex].Activity;
                    if (animationThreadFinished)
                    {
                        animationThreadFinished = false;
                        animationCaller = new Thread(new ThreadStart(AnimateMovement));
                        animationCaller.Start();
                    }
                    ShowNextActivity();
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
                    catch (ThreadInterruptedException)
                    {
                        Thread.Sleep((int)(Math.Round(1000 / SimulationSpeed)));
                    }
                }
            }
            simulationThreadFinished = true;
        }
        private void SkipToNextActivity()
        {
            for(int i=listIndex;i<activityList.Count;i++)
            {
                if(activityList[i].Activity != activityList[listIndex].Activity)
                {
                    listIndex = i;
                    Room = activityList[listIndex].Room;
                    Activity = activityList[listIndex].Activity;
                    CurrentTime = activityList[listIndex].StartTime;
                    if (animationThreadFinished)
                    {
                        animationThreadFinished = false;
                        animationCaller = new Thread(new ThreadStart(AnimateMovement));
                        animationCaller.Start();
                    }
                    nextActivity = false;
                    break;
                }
            }
            ShowNextActivity();
        }
        private void ShowNextActivity()
        {
            for (int i = listIndex; i < activityList.Count; i++)
            {
                if (activityList[i].Activity != activityList[listIndex].Activity)
                {
                    NextActivity = activityList[i].Activity;
                    NextActivityStartTime = activityList[i].StartTime;
                    break;
                }
            }
        }
        public void PreviousActivity()
        {
            for(int i=listIndex;i>=0;i--)
            {
                if (activityList[i].Activity != activityList[listIndex].Activity)
                {
                    listIndex = i;
                    Room = activityList[listIndex].Room;
                    Activity = activityList[listIndex].Activity;
                    CurrentTime = activityList[listIndex].StartTime;
                    if (animationThreadFinished)
                    {
                        animationThreadFinished = false;
                        animationCaller = new Thread(new ThreadStart(AnimateMovement));
                        animationCaller.Start();
                    }
                    nextActivity = false;
                    break;
                }
            }
            ShowNextActivity();
        }
        private void SetInitialPosition(string activity)
        {
            double xPos = 0;
            double yPos = 0;
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
            const int animationSpeed = 3;
            string targetActivity = activityList[listIndex].Activity;
            List<Coordinates> coordsList = new List<Coordinates>();
            coordsList = person.MovePerson(targetActivity, 1);
            for (int i = 0; i < coordsList.Count; i++)
            {
                if (coordsList[i].Dimension == "X")
                {
                    while (PersonPositionX < coordsList[i].Value)
                    {
                        PersonPositionX++;
                        Thread.Sleep((int)(Math.Round(animationSpeed / SimulationSpeed)));
                    }
                    while (PersonPositionX > coordsList[i].Value)
                    {
                        PersonPositionX--;
                        Thread.Sleep((int)(Math.Round(animationSpeed / SimulationSpeed)));
                    }
                }
                if (coordsList[i].Dimension == "Y")
                {
                    while (PersonPositionY < coordsList[i].Value)
                    {
                        PersonPositionY++;
                        Thread.Sleep((int)(Math.Round(animationSpeed / SimulationSpeed)));
                    }
                    while (PersonPositionY > coordsList[i].Value)
                    {
                        PersonPositionY--;
                        Thread.Sleep((int)(Math.Round(animationSpeed / SimulationSpeed)));
                    }
                }
            }
            animationThreadFinished = true;
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
                activityList = sequence.AddSequenceToList(activityList, listIndex, NewStartDate, NewEndDate,
                    NewStartTime, NewEndTime, NewRoom, NewActivity);
                ShowNextActivity();
                ActivityViewModel.ShowMessageBox("Sequence added to list", "Success!");
            }
        }
        /*
         The method randomizes the sequence textboxes.
         New start time: (current simulation time) + (random amount of minutes between 5 and 120)
         New end time: (New start time) + (random amount of minutes between 5 and 120)
         New room and activity: random selection from database where the new room and activity are compatible with each other
         */
        public void RandomizeSequence()
        {
            try
            {
                int randomIndex;
                NewStartTime = CurrentTime.AddMinutes(rnd.Next(5,120));
                NewEndTime = NewStartTime.AddMinutes(rnd.Next(5, 120));
                List<DataTypes> RoomActivityList = new List<DataTypes>();
                RoomActivityList = dbHandler.GetRoomActivityCombo();
                randomIndex = rnd.Next(RoomActivityList.Count);
                NewRoom = RoomActivityList[randomIndex].Room;
                NewActivity = RoomActivityList[randomIndex].Activity;
            }
            catch(ArgumentOutOfRangeException)
            {
                ActivityViewModel.ShowMessageBox("Simulator must be running", "Error");
            }
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
            tempCurrentTime = tempCurrentTime.AddMinutes(-ReplayTime);
            for(int i = 0;i<activityList.Count;)
            {
                if(tempCurrentTime>=activityList[i].StartTime && tempCurrentTime<activityList[i].EndTime)
                {
                    listIndex = i;
                    CurrentTime = tempCurrentTime;
                    Room = activityList[listIndex].Room;
                    Activity = activityList[listIndex].Activity;
                    SetInitialPosition(activityList[listIndex].Activity);
                    break;
                }
                else if(tempCurrentTime>=activityList[i].EndTime && tempCurrentTime<activityList[i+1].StartTime)
                {
                    listIndex = i + 1;
                    CurrentTime = tempCurrentTime;
                    Room = activityList[listIndex].Room;
                    Activity = activityList[listIndex].Activity;
                    SetInitialPosition(activityList[listIndex].Activity);
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
        string _exportFileName;
        public string ExportFileName
        {
            get
            {
                return _exportFileName;
            }
            set
            {
                _exportFileName = value;
            }
        }
        public void ExportToCSV()
        {
            ImportExport export = new ImportExport();
            export.ExportToCSV(DataSetIndex, activityList, ExportFileName);
        }
        public DateTime GetFirstDateTime()
        {
            return dbHandler.GetActivityData(DataSetIndex)[listIndex].StartTime;
        }
    }
}
