using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Media.Animation;

namespace Activity_Simulator
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private ActivityViewModel viewModel;
        public MainWindow()
        {
            InitializeComponent();
            viewModel = new ActivityViewModel();
            this.DataContext = viewModel;
            FillRoomCombobox();
            FillDatasetIndexCombobox();
        }
        private void btnImport_Click(object sender, RoutedEventArgs e)
        {
        }

        private void btnExport_Click(object sender, RoutedEventArgs e)
        {
            viewModel.ExportToCSV();
        }
        static public void ShowMessageBox(string msg, string caption)
        {
            MessageBox.Show(msg, caption);
        }

        private void btnStartSimulation_Click(object sender, RoutedEventArgs e)
        {
            viewModel.StartSimulation();
            FillSequenceTimeTextboxes();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            viewModel.AddSequence();
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            viewModel.PauseSimulation();
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            viewModel.ResumeSimulation();
        }

        private void Button_Click_3(object sender, RoutedEventArgs e)
        {
            viewModel.RandomizeSequence();
        }

        private void Button_Click_4(object sender, RoutedEventArgs e)
        {
            viewModel.StartReplay();
        }
        private void FillRoomCombobox()
        {
            List<string> roomList = new List<string>();
            roomList = viewModel.GetRoomList();
            for(int i = 0;i<roomList.Count;i++)
            {
                cmbRoom.Items.Add((roomList[i]));
            }
        }

        private void cmbRoom_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            cmbActivity.Items.Clear();
            List<DataTypes> roomActivityCombo = new List<DataTypes>();
            roomActivityCombo = viewModel.GetRoomActivityCombo();
            for(int i = 0;i<roomActivityCombo.Count;i++)
            {
                if(roomActivityCombo[i].Room.ToString() == cmbRoom.SelectedValue.ToString())
                {
                    cmbActivity.Items.Add(roomActivityCombo[i].Activity);
                }
            }
        }
        private void FillDatasetIndexCombobox()
        {
            List<Dataset> dataSetList = new List<Dataset>();
            dataSetList = viewModel.GetDatasetInfo();
            for (int i = 0; i < dataSetList.Count; i++)
            {
                cmbDataset.Items.Add(dataSetList[i].DataSetIndex.ToString());
            }
        }

        private void cmbDataset_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            List<Dataset> dataSetList = new List<Dataset>();
            dataSetList = viewModel.GetDatasetInfo();
            for(int i=0;i<dataSetList.Count;i++)
            {
                if(dataSetList[i].DataSetIndex.ToString() == cmbDataset.SelectedValue.ToString())
                {
                    txtDatasetStartTime.Text = Convert.ToString(dataSetList[i].StartTime);
                    txtDatasetEndTime.Text = Convert.ToString(dataSetList[i].EndTime);
                }
            }
        }

        private void canvasDrawing_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (chckConfigEdit.IsChecked == true)
            {
                if (txtBedCoords.IsFocused == true)
                {
                    txtBedCoords.Text = Mouse.GetPosition(canvasDrawing).ToString();
                }
                else if (txtToiletCoords.IsFocused == true)
                {
                    txtToiletCoords.Text = Mouse.GetPosition(canvasDrawing).ToString();
                }
                else if (txtShowerCoords.IsFocused == true)
                {
                    txtShowerCoords.Text = Mouse.GetPosition(canvasDrawing).ToString();
                }
                else if (txtDiningCoords.IsFocused == true)
                {
                    txtDiningCoords.Text = Mouse.GetPosition(canvasDrawing).ToString();
                }
                else if (txtBasinCoords.IsFocused == true)
                {
                    txtBasinCoords.Text = Mouse.GetPosition(canvasDrawing).ToString();
                }
                else if (txtSofaCoords.IsFocused == true)
                {
                    txtSofaCoords.Text = Mouse.GetPosition(canvasDrawing).ToString();
                }
                else if (txtEntranceCoords.IsFocused == true)
                {
                    txtEntranceCoords.Text = Mouse.GetPosition(canvasDrawing).ToString();
                }
                else if(txtDoorsCoords.IsFocused == true)
                {
                    txtDoorsCoords.Text = Mouse.GetPosition(canvasDrawing).ToString();
                }
            }
        }

        private void btnSaveConfig_Click(object sender, RoutedEventArgs e)
        {
            viewModel.SaveConfig();
        }
        private void FillSequenceTimeTextboxes()
        {
            DateTime currentTime;
            currentTime = viewModel.GetFirstDateTime();
            txtNewStartDate.Text = currentTime.Date.ToString("yyyy/MM/dd");
            txtNewEndDate.Text = currentTime.Date.ToString("yyyy/MM/dd");
            txtNewStartTime.Text = currentTime.TimeOfDay.ToString();
            txtNewEndTime.Text = currentTime.TimeOfDay.ToString();
        }

        private void btnNextActivity_Click(object sender, RoutedEventArgs e)
        {
            viewModel.NextActivity();
        }
    }
}
