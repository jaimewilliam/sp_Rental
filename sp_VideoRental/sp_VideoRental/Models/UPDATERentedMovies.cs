using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace sp_VideoRental.Models
{
    public class UPDATERentedMovies
    {
        public int RentedID { get; set; }
        public int? MovieFK { get; set; }
        public DateTime? DateReturned { get; set; }
    }
}