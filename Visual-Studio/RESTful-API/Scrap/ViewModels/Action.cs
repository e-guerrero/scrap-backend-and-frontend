using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace Scrap.ViewModels
{
    public class ActionTabItem
    {
        public string Header { get; set; }
        public UserControl Content { get; set; }
    }
    public class ActionTabViewModal : ViewModelBase
    {
        private ObservableCollection<ActionTabItem> _Tabs;
        public ObservableCollection<ActionTabItem> Tabs
        {
            get
            {
                if (_Tabs == null)
                    _Tabs = new ObservableCollection<ActionTabItem>();
                return _Tabs;
            }
            set
            {
                if (_Tabs != value)
                {
                    _Tabs = value;
                    OnPropertyChanged("Tabs");
                }
            }
        }
    }
}
