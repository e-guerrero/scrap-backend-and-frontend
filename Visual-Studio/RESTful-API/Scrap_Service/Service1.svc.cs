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
        public List<DTO_Manufacture> GetManufactures()
        {
            DB_111206_scrapEntities db = new DB_111206_scrapEntities();
            var listOfSQLObjects = db.Manufacturers.ToList();

            List<DTO_Manufacture> listOfLocalObjects = new List<DTO_Manufacture>();

            foreach (var sqlobj in listOfSQLObjects)
            {
                DTO_Manufacture o = new DTO_Manufacture();
                o.manID = sqlobj.manID;
                o.manName = sqlobj.manName;

                listOfLocalObjects.Add(o);
            }

            return listOfLocalObjects;
        }
    }
}
