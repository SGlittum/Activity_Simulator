using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Activity_Simulator
{
    class SequenceHandler
    {

        public List<DataTypes> AddSequenceToList(List<DataTypes> activityList, int listIndex, DateTime StartDate, DateTime EndDate, DateTime StartTime, DateTime EndTime, string Room, string Activity)
        {
            DateTime StartDateTime = StartDate.Date + StartTime.TimeOfDay;
            DateTime EndDateTime = EndDate.Date + EndTime.TimeOfDay;
            List<DataTypes> editedList = new List<DataTypes>();
            for (int i = listIndex; i < activityList.Count; i++)
            {
                if (StartDateTime >= activityList[i].StartTime && StartDateTime <= activityList[i].EndTime)
                {
                    DataTypes dataTypes = new DataTypes();
                    dataTypes.StartTime = StartDateTime;
                    dataTypes.EndTime = EndDateTime;
                    dataTypes.Room = Room;
                    dataTypes.Activity = Activity;
                    activityList.Insert(i+1, dataTypes);
                    DataTypes dataTypes2 = new DataTypes();
                    dataTypes2.StartTime = activityList[i+1].EndTime;
                    dataTypes2.EndTime = activityList[i].EndTime;
                    dataTypes2.Room = activityList[i].Room;
                    dataTypes2.Activity = activityList[i].Activity;
                    activityList.Insert(i + 2, dataTypes2);
                    activityList[i].EndTime = activityList[i + 1].StartTime;
                    for (int j = i + 3; j < activityList.Count;)
                    {
                        if (activityList[j].StartTime <= EndDateTime)
                        {
                            activityList.RemoveAt(j);
                        }
                        else
                        {
                            break;
                        }
                    }
                    break;
                }
            }
            editedList = activityList;
            return editedList;
        }
    }
}
