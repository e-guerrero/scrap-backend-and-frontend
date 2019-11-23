using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace Scrap_DAL
{
    public class BLL
    {
        string URL = @"http://www.jerrybhill.com/scrap/Service1.svc/";
        HttpClient client = new HttpClient();

        public BLL()
        {
            client.BaseAddress = new Uri(URL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            client.Timeout = new TimeSpan(0, 5, 0);
        }

        public async Task List<DTO_Manufacture> GetManufactures()
        {
            HttpResponseMessage response = await client.PostAsJsonAsync(string.Format(@"{0}{1}", URL, "GetManufactures"), s);
            response.EnsureSuccessStatusCode();
            var json = await response.Content.ReadAsStringAsync();

            var des = (Wrapper<DTO_Manufacture>)Newtonsoft.Json.JsonConvert.DeserializeObject(json, typeof(Wrapper<DTO_Manufacture>));

            return des.Data.ToList();
        }
    }
}
