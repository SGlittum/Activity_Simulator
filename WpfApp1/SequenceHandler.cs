﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Activity_Simulator
{
    class SequenceHandler
    {
        //The method returns a new activity list for the simulator
        public List<DataTypes> AddSequenceToList(List<DataTypes> activityList, int listIndex, DateTime StartDate, DateTime EndDate, DateTime StartTime, DateTime EndTime, string Room, string Activity)
        {
            string location = "";
            //Switch case in order to add a sensor location to the activity
            switch(Activity)
            {
                case "Sleeping":
                    location = "Bed";
                    break;
                case "Toileting":
                    location = "Toilet";
                    break;
                case "Showering":
                    location = "Shower";
                    break;
                case "Breakfast":
                    location = "Fridge";
                    break;
                case "Grooming":
                    location = "Basin";
                    break;
                case "SpareTime/TV":
                    location = "Seat";
                    break;
                case "Leaving":
                    location = "MainDoor";
                    break;
                case "Lunch":
                    location = "Fridge";
                    break;
                case "Snack":
                    location = "Fridge";
                    break;
            }
            DateTime StartDateTime = StartDate.Date + StartTime.TimeOfDay;
            DateTime EndDateTime = EndDate.Date + EndTime.TimeOfDay;
            List<DataTypes> editedList = new List<DataTypes>();
            for (int i = listIndex; i < activityList.Count; i++)
            {
                /*If the specified start time is between the start time and end time
                 of an existing activity, the new activity will start at the specified start time
                 and end at the specified end time before continuing with the original activity
                 */
                if (StartDateTime >= activityList[i].StartTime && StartDateTime <= activityList[i].EndTime)
                {
                    DataTypes dataTypes = new DataTypes();
                    dataTypes.StartTime = StartDateTime;
                    dataTypes.EndTime = EndDateTime;
                    dataTypes.Room = Room;
                    dataTypes.Location = location;
                    dataTypes.Activity = Activity;
                    activityList.Insert(i+1, dataTypes);
                    DataTypes dataTypes2 = new DataTypes();
                    dataTypes2.StartTime = activityList[i+1].EndTime;
                    dataTypes2.EndTime = activityList[i].EndTime;
                    dataTypes2.Room = activityList[i].Room;
                    dataTypes2.Location = activityList[i].Location;
                    dataTypes2.Activity = activityList[i].Activity;
                    activityList.Insert(i + 2, dataTypes2);
                    activityList[i].EndTime = activityList[i + 1].StartTime;
                    //For loop to remove any overlapping activities to the one inserted
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
                //If the new start time is specified to be between two existing activities, the new activity will be inserted here
                else if(StartDateTime > activityList[i].EndTime && StartDateTime < activityList[i+1].StartTime)
                {
                    DataTypes dataTypes = new DataTypes();
                    dataTypes.StartTime = StartDateTime;
                    dataTypes.EndTime = EndDateTime;
                    dataTypes.Room = Room;
                    dataTypes.Location = location;
                    dataTypes.Activity = Activity;
                    activityList.Insert(i+1, dataTypes);
                    //For loop to remove any overlapping activities to the one inserted
                    for (int j = i + 2; j < activityList.Count;)
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
                }
            }
            editedList = activityList;
            return editedList;
        }
    }
}
