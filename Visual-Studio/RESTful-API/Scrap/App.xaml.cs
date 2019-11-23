using Scrap.ViewModels;
using Scrap.Views;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;

namespace Scrap
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        private void Application_Startup(object sender, StartupEventArgs e)
        {
            ReaderViewModel vm = new ViewModels.ReaderViewModel();
            MainWindow win = new MainWindow();
            win.DataContext = vm;
            win.Show();

        }
    }
}
