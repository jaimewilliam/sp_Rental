using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace sp_VideoRental.Models
{
    public class UPDATERentalHeader
    {
        public int RentalID { get; set; }
        public int? CustomerFK { get; set; }
        public DateTime? DateRented { get; set; }
    }
}