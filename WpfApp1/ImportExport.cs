using System;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace Activity_Simulator
{
    class ImportExport
    {
        private string filePath;
        private string folderName;
        private void SelectFolderPath()
        {
            // Show the FolderBrowserDialog.
            FolderBrowserDialog folderBrowserDialog1 = new FolderBrowserDialog();
            OpenFileDialog openFileDialog1 = new OpenFileDialog();
            DialogResult result = folderBrowserDialog1.ShowDialog();
            if (result == DialogResult.OK)
            {
                folderName = folderBrowserDialog1.SelectedPath;
            }
        }
        private void SelectFilePath()
        {
            Stream myStream = null;
            OpenFileDialog openFileDialog1 = new OpenFileDialog();

            openFileDialog1.InitialDirectory = "c:\\";
            openFileDialog1.Filter = "csv files (*.csv)|*.csv|All files (*.*)|*.*";
            openFileDialog1.FilterIndex = 2;
            openFileDialog1.RestoreDirectory = true;

            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    if ((myStream = openFileDialog1.OpenFile()) != null)
                    {
                        using (myStream)
                        {
                            filePath = Convert.ToString(openFileDialog1.FileName);
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error: Could not read file from disk. Original error: " + ex.Message);
                }
            }
        }
        public void ExportToCSV(int dataSetIndex, List<DataTypes> activityList, string exportFileName)
        {
            if(!activityList.Any())
            {
                DatabaseHandler dbHandler = new DatabaseHandler();
                activityList = dbHandler.GetActivityData(dataSetIndex);
            }
            SelectFolderPath();
            string csv = "";
            for (int i = 0; i < activityList.Count; i++)
            {
                csv = csv + string.Format("{0:yyyy/MM/dd hh:mm:ss};{1:yyyy/MM/dd hh:mm:ss};{2};{3};{4}" + "\n", Convert.ToString(activityList[i].StartTime), Convert.ToString(activityList[i].EndTime), Convert.ToString(activityList[i].Location), Convert.ToString(activityList[i].Room), Convert.ToString(activityList[i].Activity));
            }
            try
            {
                System.IO.File.WriteAllText(string.Format(@"{0}" + "\\{1}.csv", folderName, exportFileName), csv);
            }
            catch(Exception ex)
            {
                ActivityViewModel.ShowMessageBox(ex.ToString(), "Error!");
            }
        }
        public void ImportFromCSV(int previousDatasetIndex)
        {
            DatabaseHandler dbHandler = new DatabaseHandler();
            List<DataTypes> importedList = new List<DataTypes>();
            SelectFilePath();
            try
            {
                using (var reader = new StreamReader(filePath))
                {
                    while (!reader.EndOfStream)
                    {
                        DataTypes dataTypes = new DataTypes();
                        var line = reader.ReadLine();
                        var values = line.Split(';');
                        dataTypes.StartTime = Convert.ToDateTime(values[0]);
                        dataTypes.EndTime = Convert.ToDateTime(values[1]);
                        dataTypes.Location = Convert.ToString(values[2]);
                        dataTypes.Room = Convert.ToString(values[3]);
                        dataTypes.Activity = Convert.ToString(values[4]);

                        importedList.Add(dataTypes);
                    }
                }
                dbHandler.SaveStartTimeAndEndTime(importedList, previousDatasetIndex);
                dbHandler.SaveActivityData(importedList, previousDatasetIndex);
            }
            catch(Exception ex)
            {
                ActivityViewModel.ShowMessageBox(ex.ToString(), "Error!");
            }

        }
    }
}
