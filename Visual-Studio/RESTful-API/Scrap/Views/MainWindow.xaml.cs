using Scrap.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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

namespace Scrap.Views
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private ActionTabViewModal vmd;

        public MainWindow()
        {
            InitializeComponent();

            vmd = new ActionTabViewModal();
            actionTabs.ItemsSource = vmd.Tabs;
        }

        private void btnExit_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }


        private void Close_Tab(object sender, MouseButtonEventArgs e)
        {
            vmd.Tabs.RemoveAt(actionTabs.SelectedIndex);
        }

        private void EditUser_Click(object sender, RoutedEventArgs e)
        {
            vmd.Tabs.Add(new ActionTabItem { Header = "Call Web Service", Content = new Button1UserControl() });
            actionTabs.SelectedIndex = vmd.Tabs.Count - 1;

        }

        private void AddPart_Click(object sender, RoutedEventArgs e)
        {
            vmd.Tabs.Add(new ActionTabItem { Header = "New Part", Content = new PartEdit() });
            actionTabs.SelectedIndex = vmd.Tabs.Count - 1;
        }

        private void AddUser_Click(object sender, RoutedEventArgs e)
        {
            vmd.Tabs.Add(new ActionTabItem { Header = "New User", Content = new Button1UserControl() });
            actionTabs.SelectedIndex = vmd.Tabs.Count - 1;

        }

        private void getParts_Click(object sender, RoutedEventArgs e)
        {
            vmd.Tabs.Add(new ActionTabItem { Header = "Part Listing", Content = new PartListView() });
            actionTabs.SelectedIndex = vmd.Tabs.Count - 1;

        }
    }
}
