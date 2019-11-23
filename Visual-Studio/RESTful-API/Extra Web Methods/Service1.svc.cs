using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using Scrap_DAL;

namespace Scrap_Service
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service1.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    public class Service1 : IService1
    {
        public List<DTO_Manufacture> GetManufactures(DTO_Manufacture m)
        {

            List<DTO_Manufacture> listOfLocalObjects = new List<DTO_Manufacture>();

            using (DB_111206_scrapEntities db = new DB_111206_scrapEntities())
            {
                var listOfSQLObjects = db.Manufacturers.ToList();

                foreach (var sqlobj in listOfSQLObjects)
                {
                    DTO_Manufacture o = new DTO_Manufacture();
                    o.manID = sqlobj.manID;
                    o.manName = sqlobj.manName;

                    listOfLocalObjects.Add(o);
                }
            }
            return listOfLocalObjects;
        }

        public List<DTO_Manufacture> GetManufactureById(DTO_Manufacture m)
        {

            List<DTO_Manufacture> listOfLocalObjects = new List<DTO_Manufacture>();

            DB_111206_scrapEntities db = new DB_111206_scrapEntities();
            var myManufacture = db.Manufacturers.Where(c => c.manID == m.manID).FirstOrDefault();

            if (myManufacture !=null)
            {
                DTO_Manufacture o = new DTO_Manufacture();
                o.manID = myManufacture.manID;
                o.manName = myManufacture.manName;

                listOfLocalObjects.Add(o);
            }
            return listOfLocalObjects;
        }

        // m.manName = "app"
        public List<DTO_Manufacture> GetManufactureByPartialName(DTO_Manufacture m)
        {

            List<DTO_Manufacture> listOfLocalObjects = new List<DTO_Manufacture>();

            DB_111206_scrapEntities db = new DB_111206_scrapEntities();
            var sqllist = db.Manufacturers.Where(c => c.manName.StartsWith(m.manName)).ToList();


            foreach(var sqlobj in sqllist)
            {
                DTO_Manufacture o = new DTO_Manufacture();
                o.manID = sqlobj.manID;
                o.manName = sqlobj.manName;

                listOfLocalObjects.Add(o);
            }
            return listOfLocalObjects;
        }

        public List<DTO_Manufacture> SaveManufactureById(DTO_Manufacture m)
        {

            List<DTO_Manufacture> listOfLocalObjects = new List<DTO_Manufacture>();

            DB_111206_scrapEntities db = new DB_111206_scrapEntities();
            var myManufacture = db.Manufacturers.Where(c => c.manID == m.manID).FirstOrDefault();

            if (myManufacture != null)
            {

                myManufacture.manName = m.manName;
                db.SaveChanges();

              
                listOfLocalObjects.Add(m);
            }
            else
            {
                Manufacturer sc = new Manufacturer();
                sc.manName = m.manName;
                db.Manufacturers.Add(sc);
                db.SaveChanges();

                DTO_Manufacture d = new DTO_Manufacture();
                d.manID = xx
            }
            return listOfLocalObjects;
        }

    }
}
