using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Activity_Simulator
{
    class Person
    {
        public List<Coordinates> MovePerson(string targetActivity, int configId)
        {
            List<ConfigPositions> configPositionList = new List<ConfigPositions>();
            DatabaseHandler dbHandler = new DatabaseHandler();
            List<Coordinates> coordsList = new List<Coordinates>();
            configPositionList = dbHandler.GetConfigPositions(configId);
            double doorVerticalPosition = dbHandler.GetDoorVerticalPosition(configId);
            double xPos = 0;
            double yPos = 0;
            for(int i=0;i<configPositionList.Count;i++)
            {
                if(targetActivity == configPositionList[i].Activity)
                {
                    xPos = configPositionList[i].XPos;
                    yPos = configPositionList[i].YPos;
                    break;
                }
            }
            Coordinates doorCoord = new Coordinates
            {
                Dimension = "Y",
                Value = doorVerticalPosition
            };
            Coordinates xCoord = new Coordinates
            {
                Dimension = "X",
                Value = xPos
            };
            Coordinates yCoord = new Coordinates
            {
                Dimension = "Y",
                Value = yPos
            };
            coordsList.Add(doorCoord);
            coordsList.Add(xCoord);
            coordsList.Add(yCoord);
            return coordsList;
        }
    }
}
