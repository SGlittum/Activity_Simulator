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
        private string _exportFileName;
        public string ExportFileName
        {
            get
            {
                return _exportFileName;
            }
            set
            {
                _exportFileName = value + ".csv";
            }
        }
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
        public void ExportToCSV(int dataSetIndex, List<DataTypes> activityList)
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
            System.IO.File.WriteAllText(string.Format(@"{0}"+"\\test.csv", folderName), csv);
        }
        public void ImportFromCSV()
        {

        }
    }
}
