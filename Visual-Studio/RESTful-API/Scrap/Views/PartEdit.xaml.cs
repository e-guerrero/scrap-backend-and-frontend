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
using Model;
using Scrap_DAL;

namespace Scrap.Views
{
    /// <summary>
    /// Interaction logic for PartEdit.xaml
    /// </summary>
    public partial class PartEdit : UserControl
    {
        public PartEdit()
        {
            InitializeComponent();

            LoadPart();
        }

        private void LoadPart()
        {
            DB_111206_scrapEntities db = new DB_111206_scrapEntities();
            var listOfSQLObjects = db.Manufacturers.ToList();

            List<DTO_Manufacture> listOfLocalObjects = new List<DTO_Manufacture>();

            foreach( var sqlobj in listOfSQLObjects)
            {
                DTO_Manufacture o = new DTO_Manufacture();
                o.manID = sqlobj.manID;
                o.manName = sqlobj.manName;

                listOfLocalObjects.Add(o);
            }
            cbMan.ItemsSource = listOfLocalObjects;

            var models = db.Models.ToList();
            cbModels.ItemsSource = models;

        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            var m = cbMan.SelectedItem as DTO_Manufacture;
            var model = cbModels.SelectedItem;

            

            string pn = tbPartNumber.Text;
            string pdesc = PartDesc.Text;

            DB_111206_scrapEntities db = new DB_111206_scrapEntities();

            // Need to fix id's 

            Part sqlPart = new Part();
            sqlPart.manID = m.manID;
            sqlPart.modelId = 1;
            sqlPart.partNum = pn;
            sqlPart.partDesc = pdesc;

            db.Parts.Add(sqlPart);
            db.SaveChanges();

        }
    }
}
