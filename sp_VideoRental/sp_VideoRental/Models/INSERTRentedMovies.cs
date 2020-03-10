using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace sp_VideoRental.Models
{
    public class INSERTRentedMovies
    {
        public int? MovieFK { get; set; }
        public DateTime? DateReturned { get; set; }
        public int? RentalFK { get; set; }
    }
}