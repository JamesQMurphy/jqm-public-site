using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PublicSite.Models;

namespace PublicSite.Controllers
{
    [Produces("application/json")]
    [Route("api/[controller]")]
    public class VehicleController : Controller
    {
        //TODO: Temporarily put here; need to extract this out to a service
        private Vehicle[] _vehicles = new Vehicle[]
        {
                new Vehicle()
                {
                    VehicleId = "id111",
                    Year = 2011,
                    Make = "Ford",
                    Model = "Escape"
                },
                new Vehicle()
                {
                    VehicleId = "id222",
                    Year = 2009,
                    Make = "Nissan",
                    Model = "Maxima"
                },
                new Vehicle()
                {
                    VehicleId = "id333",
                    Year = 2009,
                    Make = "Toyota",
                    Model = "Camry"
                }
        };

        [HttpGet()]
        public IEnumerable<Vehicle> GetAll()
        {
            return _vehicles;
        }
    }
}