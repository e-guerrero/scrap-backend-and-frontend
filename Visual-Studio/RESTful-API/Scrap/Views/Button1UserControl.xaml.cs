using Scrap_DAL;
using System;
using System.Collections.Generic;
using System.Diagnostics;
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
    /// Interaction logic for Button1UserControl.xaml
    /// </summary>
    public partial class Button1UserControl : UserControl
    {
        public Button1UserControl()
        {
            InitializeComponent();

            CallWebService();
        }

        private void CallWebService()
        {

            BLL bll = new BLL();

            ServiceReference1.Service1Client ws = new ServiceReference1.Service1Client();
            var s = ws.GetManufactures();
            Debug.WriteLine(s);

        }
    }
}
