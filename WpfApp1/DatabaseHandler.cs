using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;
using System.Threading;

namespace Activity_Simulator
{
    class DatabaseHandler
    {
        public List<DataTypes> GetActivityData(int DataSetIndex)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            List<DataTypes> activityDataList = new List<DataTypes>();
            SqlConnection con = new SqlConnection(connectionString);
            string selectSQL = String.Format("SELECT ActivityData.StartTime, ActivityData.EndTime, SensorLocation.Location, Room.Room, Activity.Activity FROM ActivityData LEFT JOIN SensorLocation ON ActivityData.SensorLocationId = SensorLocation.SensorLocationId INNER JOIN Room ON SensorLocation.RoomId = Room.RoomId LEFT JOIN Activity ON ActivityData.ActivityId = Activity.ActivityId WHERE ActivityData.DataSetIndex = {0}", DataSetIndex);
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(selectSQL, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr != null)
                {
                    while (dr.Read())
                    {
                        DataTypes dataTypes = new DataTypes();

                        dataTypes.StartTime = Convert.ToDateTime(dr["StartTime"]);
                        dataTypes.EndTime = Convert.ToDateTime(dr["EndTime"]);
                        dataTypes.Location = Convert.ToString(dr["Location"]);
                        dataTypes.Room = Convert.ToString(dr["Room"]);
                        dataTypes.Activity = Convert.ToString(dr["Activity"]);

                        activityDataList.Add(dataTypes);
                    }
                }
                con.Close();
            }
            catch(Exception ex)
            {
                ActivityViewModel.ShowMessageBox(ex.ToString(), "Error!");
            }
            return activityDataList;
        }
        public List<DataTypes> GetRoomActivityCombo()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            List<DataTypes> roomActivityList = new List<DataTypes>();
            SqlConnection con = new SqlConnection(connectionString);
            string selectSQL = "SELECT Room.Room, Activity.Activity FROM Room_Activity_Mapping INNER JOIN Room ON Room_Activity_Mapping.RoomId = Room.RoomId INNER JOIN Activity ON Room_Activity_Mapping.ActivityId = Activity.ActivityId";
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(selectSQL, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr != null)
                {
                    while (dr.Read())
                    {
                        DataTypes dataTypes = new DataTypes();

                        dataTypes.Room = Convert.ToString(dr["Room"]);
                        dataTypes.Activity = Convert.ToString(dr["Activity"]);

                        roomActivityList.Add(dataTypes);
                    }
                }
                con.Close();
            }
            catch(Exception ex)
            {
                ActivityViewModel.ShowMessageBox(ex.ToString(), "Error!");
            }
            return roomActivityList;
        }
        public List<string> GetRoomList()
        {
            string Room;
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            List<string> roomList = new List<string>();
            SqlConnection con = new SqlConnection(connectionString);
            string selectSQL = "SELECT Room FROM Room";
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(selectSQL, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr != null)
                {
                    while (dr.Read())
                    {

                        Room = Convert.ToString(dr["Room"]);

                        roomList.Add(Room);
                    }
                }
                con.Close();
            }
            catch(Exception ex)
            {
                ActivityViewModel.ShowMessageBox(ex.ToString(), "Error!");
            }
            return roomList;
        }
        public List<string> GetActivityList()
        {
            string Activity;
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            List<string> activityList = new List<string>();
            SqlConnection con = new SqlConnection(connectionString);
            string selectSQL = "SELECT Activity FROM Activity";
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(selectSQL, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr != null)
                {
                    while (dr.Read())
                    {

                        Activity = Convert.ToString(dr["Activity"]);

                        activityList.Add(Activity);
                    }
                }
                con.Close();
            }
            catch(Exception ex)
            {
                ActivityViewModel.ShowMessageBox(ex.ToString(), "Error!");
            }
            return activityList;
        }
        public List<Dataset> GetDatasetInfo()
        {
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
                List<Dataset> datasetList = new List<Dataset>();
                SqlConnection con = new SqlConnection(connectionString);
                string selectSQL = "SELECT * FROM DataSet";
                try
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(selectSQL, con);
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr != null)
                    {
                        while (dr.Read())
                        {
                            Dataset dataSet = new Dataset();

                            dataSet.DataSetIndex = Convert.ToInt16(dr["DataSetIndex"]);
                            dataSet.StartTime = Convert.ToDateTime(dr["StartTime"]);
                            dataSet.EndTime = Convert.ToDateTime(dr["EndTime"]);

                            datasetList.Add(dataSet);
                        }
                    }
                    con.Close();
                }
                catch(Exception ex)
                {
                    ActivityViewModel.ShowMessageBox(ex.ToString(), "Error!");
                }
                return datasetList;
            }
        }
        public List<ConfigPositions> GetConfigPositions(int configId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            List<ConfigPositions> configPositionList = new List<ConfigPositions>();
            SqlConnection con = new SqlConnection(connectionString);
            string selectSQL = String.Format("SELECT Activity.Activity, XPos, YPos FROM ActivityPosition INNER JOIN Activity ON ActivityPosition.ActivityId = Activity.ActivityId");
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(selectSQL, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr != null)
                {
                    while (dr.Read())
                    {
                        ConfigPositions configPosition = new ConfigPositions();

                        configPosition.Activity = Convert.ToString(dr["Activity"]);
                        configPosition.XPos = Convert.ToDouble(dr["XPos"]);
                        configPosition.YPos = Convert.ToDouble(dr["YPos"]);

                        configPositionList.Add(configPosition);
                    }
                }
                con.Close();
            }
            catch(Exception ex)
            {
                ActivityViewModel.ShowMessageBox(ex.ToString(), "Error!");
            }
            return configPositionList;
        }
        public void SaveConfigLocationToDatabase(List<ConfigPositions> configPositionList, int configId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            try
            {
                con.Open();
                for (int i = 0; i < configPositionList.Count; i++)
                {
                    string insertSQL = string.Format("UPDATE ActivityPosition SET XPos = {0}, YPos = {1} WHERE ActivityId = (SELECT ActivityId FROM Activity WHERE Activity = '{2}') AND ConfigId = {3}", Math.Round(configPositionList[i].XPos), Math.Round(configPositionList[i].YPos), configPositionList[i].Activity, configId);
                    SqlCommand cmd = new SqlCommand(insertSQL, con);
                    cmd.ExecuteNonQuery();
                }
                con.Close();
                ActivityViewModel.ShowMessageBox("Config locations saved to database", "Success!");
            }
            catch (Exception ex)
            {
                ActivityViewModel.ShowMessageBox(ex.ToString(), "Error");
            }
        }
        public void SaveDoorsLocationToDatabase(double doorsY, int configId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            string insertSQL = string.Format("UPDATE DoorsPosition SET VerticalPosition = {0} WHERE ConfigId = {1}", Math.Round(doorsY), configId);
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(insertSQL, con);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch(Exception ex)
            {
                ActivityViewModel.ShowMessageBox(ex.ToString(), "Error!");
            }
        }
        public void SaveStartTimeAndEndTime(List<DataTypes> importedList, int datasetIndex)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            string insertSQL = string.Format("INSERT INTO DataSet (DataSetIndex, StartTime, EndTime) VALUES ({0}, '{1:u}', '{2:u}')", datasetIndex+1, importedList[0].StartTime, importedList[importedList.Count - 1].EndTime);
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(insertSQL, con);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch(Exception ex)
            {
                ActivityViewModel.ShowMessageBox(ex.ToString(), "Error");
            }
        }
        public void SaveActivityData(List<DataTypes> importedList, int previousDatasetIndex)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            try
            {
                con.Open();
                for (int i = 0;i<importedList.Count;i++)
                {
                    string insertSQL = string.Format("INSERT INTO ActivityData (StartTime, EndTime, SensorLocationId, ActivityId, DatasetIndex) VALUES ('{0:u}', '{1:u}', (SELECT SensorLocationId FROM SensorLocation WHERE Location = '{2}'), (SELECT ActivityId FROM Activity WHERE Activity = '{3}'), {4})", importedList[i].StartTime, importedList[i].EndTime, importedList[i].Location, importedList[i].Activity, previousDatasetIndex+1);
                    SqlCommand cmd = new SqlCommand(insertSQL, con);
                    cmd.ExecuteNonQuery();
                }
                con.Close();
                ActivityViewModel.ShowMessageBox("Activity data saved to database", "Success!");
            }
            catch(Exception ex)
            {
                ActivityViewModel.ShowMessageBox(ex.ToString(), "Error");
            }
        }
    }
}
