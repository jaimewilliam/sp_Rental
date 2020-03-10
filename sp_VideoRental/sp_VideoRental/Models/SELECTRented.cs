using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace sp_VideoRental.Models
{
    public class SELECTRented
    {
        public string MovieName { get; set; }
        public string GenreName { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public Nullable<System.DateTime> DateReturned { get; set; }

        public int MovieID { get; set; }
        public int GenreFK { get; set; }
        public int RentedID { get; set; }
        public int? RentalFK { get; set; }
    }
}