using sp_VideoRental.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sp_VideoRental.Controllers
{
    public class HomeController : Controller
    {
        VideoRentalEntities db = new VideoRentalEntities();

        public ActionResult Index()
        {
            //var result = db.Database.SqlQuery<GetFunctionByID>("GetFunctionByID @FunctionId", new SqlParameter("@FunctionId", functionId)).ToList());
            var listtView = db.Database.SqlQuery<DisplayRecords>("DisplayRecords").ToList();
            return View(listtView);
        }

        public ActionResult Edit(int id)
        {
            var editList = db.Database.SqlQuery<SELECTRentalHeader_Result>("SELECTRentalHeader @id", new SqlParameter("@id", id)).FirstOrDefault();
            DisplayRecords records = new DisplayRecords();
            if (editList != null)
            {
                records = new DisplayRecords
                {
                    RentalID = id,
                    CustomerName = db.Database.SqlQuery<SELECTCustomer>("SELECTCustomers @CustomerFK", new SqlParameter("@CustomerFK", editList.CustomerFK)).Select(c => c.CustomerName).FirstOrDefault().ToString(),
                    DateRented = editList.DateRented,
                    CustomerFK = editList.CustomerFK
                };
            }
            if (id != 0)
            {
                var rented = db.Database.SqlQuery<SELECTRented>("SELECTRented @id", new SqlParameter("@id", id)).ToList();
                records.SELECTRented = rented.ToList();
            }
            

            return View(records);
        }

        //public ActionResult Rented()
        //{
        //    var rented = db.Database.SqlQuery<SELECTRented_Result>("SELECTRented").ToList();

        //    return View(rented);
        //}

        public ActionResult CustomerList()
        {
            var customers = db.Database.SqlQuery<SELECTCustomer>("SELECTCustomers").ToList();
            return PartialView(customers);
        }

        public ActionResult DdlMovies()
        {
            var movies = db.Database.SqlQuery<SELECTMovies_Result>("SELECTMovies").ToList();
            return PartialView(movies);
        }

        public ActionResult DdlGenres()
        {
            
            var genres = db.Database.SqlQuery<SELECTGenres_Result>("SELECTGenres").ToList();
            return PartialView(genres);
        }

        [HttpPost]
        public ActionResult Edit(DisplayRecords displayRecords, string newMovieIdholder)
        {
            var rid = displayRecords.RentalID;
            var scopeIdentity = 0;
            if (displayRecords != null)
            {
                if (displayRecords.RentalID == 0)
                {
                    //Return the SCOPE_IDENTITY() from sp!
                    var returnValue = new SqlParameter("@RentalID", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };

                    SqlParameter[] parameters =
                    {
                      new SqlParameter("@CustomerFK", displayRecords.CustomerFK),
                      new SqlParameter("@DateRented", displayRecords.DateRented),
                      returnValue
                    };

                    if (displayRecords.CustomerFK != null && displayRecords.DateRented != null)
                    {
                       db.Database.ExecuteSqlCommand("exec @RentalID = INSERTRentalHeader @CustomerFK, @DateRented",
                        parameters);

                        scopeIdentity = (int)returnValue.Value;
                    }
                    //else { Error Message }

                    //SqlParameter[] param =
                    //{
                    //  new SqlParameter("@MovieFK",Convert.ToInt32(newMovieIdholder)),
                    //  new SqlParameter("@DateReturned", DBNull.Value),
                    //  new SqlParameter("@RentalFK", scopeIdentity)

                    //};

                    //if (newMovieIdholder != null && displayRecords.DateRented != null)
                    //{
                    //    db.Database.ExecuteSqlCommand("exec INSERTRentedMovies @MovieFK, @DateReturned, @RentalFK",
                    //    param);
                    //}

                    if (!string.IsNullOrEmpty(newMovieIdholder))
                    {
                        //*Convert the value into string Array[] and split w/ comma!
                        string[] newmovies = newMovieIdholder.Split(',');
                        //newmovies = new[] { "1", "2", "5", "6"};

                        //*Loop inside newmovies!
                        for (int i = 0; i < newmovies.Count(); i++)
                        {
                            SqlParameter[] param =
                            {
                              new SqlParameter("@MovieFK",Convert.ToInt32(newmovies[i])),
                              new SqlParameter("@DateReturned", DBNull.Value),
                              new SqlParameter("@RentalFK", scopeIdentity)

                            };

                            if (newMovieIdholder != null && displayRecords.DateRented != null)
                            {
                                db.Database.ExecuteSqlCommand("exec INSERTRentedMovies @MovieFK, @DateReturned, @RentalFK",
                                param);
                            }

                        }
                    }

                }
                else
                {
                    //var Rentalheader = db.Database.SqlQuery<UPDATERentalHeader>("UPDATERentalHeader @RentalID, @CustomerFK, @DateRented",
                    //    new SqlParameter("@RentalID", displayRecords.RentalID), new SqlParameter("@CustomerFK", displayRecords.CustomerFK),
                    //    new SqlParameter("@DateRented", displayRecords.DateRented)).FirstOrDefault();

                    var Rentalheader = db.Database.ExecuteSqlCommand("UPDATERentalHeader @RentalID, @CustomerFK, @DateRented",
                        new SqlParameter("@RentalID", displayRecords.RentalID),
                        new SqlParameter("@CustomerFK", displayRecords.CustomerFK),
                        new SqlParameter("@DateRented", displayRecords.DateRented));


                    if (displayRecords.SELECTRented != null)
                    {
                        //movies info
                        foreach (var item in displayRecords.SELECTRented)
                        {
                            var param = new SqlParameter();
                            if (item.DateReturned == null)
                            {
                                param = new SqlParameter("@DateReturned", DBNull.Value);
                            }
                            else
                            {
                                param = new SqlParameter("@DateReturned", item.DateReturned);
                            }
                            var RentedMovies = db.Database.ExecuteSqlCommand("UPDATERentedMovies @RentedID, @MovieFK, @DateReturned",
                                new SqlParameter("@RentedID", item.RentedID),
                                new SqlParameter("@MovieFK", item.MovieID),
                                param);
                        }
                    }

                    if (!string.IsNullOrEmpty(newMovieIdholder))
                    {
                        //*Convert the value into string Array[] and split w/ comma!
                        string[] newmovies = newMovieIdholder.Split(',');
                        //newmovies = new[] { "1", "2", "5", "6"};

                        //*Loop inside newmovies!
                        for (int i = 0; i < newmovies.Count(); i++)
                        {
                            SqlParameter[] param =
                            {
                              new SqlParameter("@MovieFK",Convert.ToInt32(newmovies[i])),
                              new SqlParameter("@DateReturned", DBNull.Value),
                              new SqlParameter("@RentalFK", displayRecords.RentalID)

                            };

                            if (newMovieIdholder != null && displayRecords.DateRented != null)
                            {
                                db.Database.ExecuteSqlCommand("exec INSERTRentedMovies @MovieFK, @DateReturned, @RentalFK",
                                param);
                            }

                        }
                    }
                }
                
            }
            return RedirectToAction("Edit", new { id = rid });
        }

        public ActionResult Remove(int rentedID, int rentalFK)
        {
            db.Database.SqlQuery<DELETERentedMovies>("DELETERentedMovies @RentedID", new SqlParameter("@RentedID", rentedID)).FirstOrDefault();
            
            return RedirectToAction("Edit", new { id = rentalFK});
        }

        public ActionResult Delete(int rentalid)
        {
            db.Database.SqlQuery<DELETERentalHeader>("DELETERentalHeader @RentalID", new SqlParameter("@RentalID", rentalid)).FirstOrDefault();
            db.Database.SqlQuery<DELETERentedMoviesbyRentalFK>("DELETERentedMoviesbyRentalFK @RentalFK", new SqlParameter("@RentalFK", rentalid)).FirstOrDefault();

            return RedirectToAction("Index");
        }
    }
}