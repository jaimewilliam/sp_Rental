using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace sp_VideoRental.Models
{
    public class DisplayRecords
    {
        [Display(Name = "Rental ID")]
        public int RentalID { get; set; }

        [Display(Name = "Customer Name")]
        public string CustomerName { get; set; }

        [Display(Name = "Date Rented")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public Nullable<System.DateTime> DateRented { get; set; }

        public int? CustomerFK { get; set; }
        public List<SELECTRented> SELECTRented { get; set; }
    }
}