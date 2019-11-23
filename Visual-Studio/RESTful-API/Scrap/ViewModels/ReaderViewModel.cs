using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace Scrap.ViewModels
{
    public class ReaderViewModel : ViewModelBase
    {
        #region Commands

        private RelayCommand _Button1Command;
        public ICommand Button1Command
        {
            get
            {
                if (_Button1Command == null)
                {
                    _Button1Command = new RelayCommand(param => this.Button1(),
                        param => this.CanButton1Command);
                }
                return _Button1Command;
            }
        }

        private bool CanButton1Command
        {
            get
            {
                return true;
            }
        }
        #endregion

        #region Properties

        private bool _AllowButton1;
        public bool AllowButton1
        {
            get
            {
                return _AllowButton1;
            }
            set
            {
                if (_AllowButton1 != value)
                {
                    _AllowButton1 = value;
                    OnPropertyChanged("AllowButton1");
                }
            }
        }
        #endregion

        public ReaderViewModel()
        {
            AllowButton1 = true;
        }

        public void Button1()
        {
            Debug.WriteLine("button 1");
        }
    }
}
