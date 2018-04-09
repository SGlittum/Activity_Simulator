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
            con.Open();
            SqlCommand cmd = new SqlCommand(selectSQL, con);
            SqlDataReader dr = cmd.ExecuteReader();
            if(dr != null)
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
            return activityDataList;
        }
        public List<DataTypes> GetRoomActivityCombo()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            List<DataTypes> roomActivityList = new List<DataTypes>();
            SqlConnection con = new SqlConnection(connectionString);
            string selectSQL = "SELECT Room.Room, Activity.Activity FROM Room_Activity_Mapping INNER JOIN Room ON Room_Activity_Mapping.RoomId = Room.RoomId INNER JOIN Activity ON Room_Activity_Mapping.ActivityId = Activity.ActivityId";
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
            return roomActivityList;
        }
        public List<string> GetRoomList()
        {
            string Room;
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            List<string> roomList = new List<string>();
            SqlConnection con = new SqlConnection(connectionString);
            string selectSQL = "SELECT Room FROM Room";
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
            return roomList;
        }
        public List<string> GetActivityList()
        {
            string Activity;
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            List<string> activityList = new List<string>();
            SqlConnection con = new SqlConnection(connectionString);
            string selectSQL = "SELECT Activity FROM Activity";
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
            return activityList;
        }
        public List<Dataset> GetDatasetInfo()
        {
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
                List<Dataset> datasetList = new List<Dataset>();
                SqlConnection con = new SqlConnection(connectionString);
                string selectSQL = "SELECT * FROM DataSet";
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
                return datasetList;
            }
        }
        public List<ConfigPositions> GetConfigPositions(int configId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            List<ConfigPositions> configPositionList = new List<ConfigPositions>();
            SqlConnection con = new SqlConnection(connectionString);
            string selectSQL = String.Format("SELECT Activity.Activity, XPos, YPos FROM ActivityPosition INNER JOIN Activity ON ActivityPosition.ActivityId = Activity.ActivityId");
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
            return configPositionList;
        }
        public void SaveConfigIdToDatabase(int configId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            string insertSQL = string.Format("INSERT INTO Config (ConfigId) VALUES ({0})", configId);
            con.Open();
            SqlCommand cmd = new SqlCommand(insertSQL, con);
            cmd.ExecuteNonQuery();
            con.Close();
        }
        public void SaveConfigLocationToDatabase(string activity, string activityLocation, double xPos, double yPos, int configId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            string insertSQL = string.Format("INSERT INTO ActivityPosition (Position, XPos, YPos, ActivityId, ConfigId) VALUES ('{0}', {1}, {2}, (SELECT ActivityId FROM Activity WHERE Activity = '{3}'), {4})", activityLocation, Math.Round(xPos), Math.Round(yPos), activity, configId);
            con.Open();
            SqlCommand cmd = new SqlCommand(insertSQL, con);
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}
