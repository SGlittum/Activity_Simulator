using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.ComponentModel;
using System.Windows.Input;

namespace Activity_Simulator
{
    class ActivityViewModel : ObservableObject
    {
        Simulation simulation = new Simulation();
        ConfigHandler configHandler = new ConfigHandler();
        ImportExport importExport = new ImportExport();
        public Simulation Simulation
        {
            get
            {
                return simulation;
            }
        }
        public ConfigHandler ConfigHandler
        {
            get
            {
                return configHandler;
            }
        }
        public ImportExport ImportExport
        {
            get
            {
                return importExport;
            }
        }
        public void StartSimulation()
        {
            simulation.StartSimulationThread();
        }
        public void PauseSimulation()
        {
            simulation.SimulationSuspended = true;
        }
        public void ResumeSimulation()
        {
            simulation.SimulationSuspended = false;
            simulation.simulationCaller.Interrupt();
        }
        public void AddSequence()
        {
            simulation.UpdateActivityList();
        }
        public void RandomizeSequence()
        {
            simulation.RandomizeSequence();
        }
        public void StartReplay()
        {
            simulation.Replay();
        }
        public List<DataTypes> GetRoomActivityCombo()
        {
            DatabaseHandler dbHandler = new DatabaseHandler();
            List<DataTypes> roomActivityList = new List<DataTypes>();
            roomActivityList = dbHandler.GetRoomActivityCombo();
            return roomActivityList;
        }
        public List<string> GetRoomList()
        {
            DatabaseHandler dbHandler = new DatabaseHandler();
            List<string> roomList = new List<string>();
            roomList = dbHandler.GetRoomList();
            return roomList;
        }
        public List<Dataset> GetDatasetInfo()
        {
            DatabaseHandler dbHandler = new DatabaseHandler();
            List<Dataset> dataSetList = new List<Dataset>();
            dataSetList = dbHandler.GetDatasetInfo();
            return dataSetList;
        }
        public void ExportToCSV()
        {
            simulation.ExportToCSV();
        }
        public void SaveConfig()
        {
            configHandler.SaveConfigChanges();
        }
        public static void ShowMessageBox(string msg, string caption)
        {
            MainWindow.ShowMessageBox(msg, caption);
        }
    }
}
