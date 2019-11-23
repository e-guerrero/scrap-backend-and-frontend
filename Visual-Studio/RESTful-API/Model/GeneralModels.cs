using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace Model
{
    public class Wrapper<T>
    {
        public List<T> Data { get; set; }
    }
    [DataContract]
    public class DTO_Manufacture
    {
        [DataMember]
        public int manID { get; set; }
        [DataMember]
        public string manName { get; set; }
    }

    public class DTO_Part
    {
        [DataMember]
        public int partsID { get; set; }
        [DataMember]
        public int manID { get; set; }
        [DataMember]
        public int modelID { get; set; }
        [DataMember]
        public string partNum { get; set; }
        [DataMember]
        public string partDesc { get; set; }
        [DataMember]
        public string partPic { get; set; }
        public DTO_Manufacture manufacture { get; set; }

    }
}
