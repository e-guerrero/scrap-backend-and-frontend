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
using Scrap_DAL;
using Model;

namespace Scrap.Views
{
    /// <summary>
    /// Interaction logic for PartListView.xaml
    /// </summary>
    public partial class PartListView : UserControl
    {
        public PartListView()
        {
            InitializeComponent();

            LoadParts();
        }

        private void LoadParts()
        {
            DB_111206_scrapEntities db = new DB_111206_scrapEntities();
            var sqllist = db.Parts.ToList();

            List<DTO_Part> parts = new List<DTO_Part>();

            foreach( var sqlObject in sqllist)
            {
                DTO_Part p = new DTO_Part();
                p.manID = sqlObject.manID.Value;
                p.modelID = sqlObject.modelId.Value;
                p.partDesc = sqlObject.partDesc;
                p.partNum = sqlObject.partNum;
                p.partPic = string.Format( "{0}{1}", @"http://www.jerrybhill.com/scrapimages/", sqlObject.partPic);
                p.partsID = sqlObject.partsID;

                // Missing import object

                DTO_Manufacture m = new DTO_Manufacture();
                m.manID = sqlObject.manID.Value;
                m.manName = sqlObject.Manufacturer.manName;

                p.manufacture = m;

                parts.Add(p);
            }

            lv.ItemsSource = parts;
        }
    }
}
