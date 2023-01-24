using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MoviesMVC.Controllers
{
    public class MovieController : Controller
    {
        private readonly ModelContainer db = new ModelContainer();

        ~MovieController()
        {
            db?.Dispose();
        }
        // GET: Movie
        public ActionResult Index()
        {
            return View(db.Movies);
        }

        // GET: Movie/Details/5
        public ActionResult Details(int? id)
        {
            return CommonAction(id);
        }

        private ActionResult CommonAction(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);
            }

            Movie movie = db.Movies
                .Include(m => m.UploadedFiles)
                .SingleOrDefault(m => m.IDMovie == id);

            if (movie == null)
            {
                return HttpNotFound();
            }

            return View(movie);
        }

        // GET: Movie/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Movie/Create
        [HttpPost]
        public ActionResult Create(Movie movie, IEnumerable<HttpPostedFileBase> files)
        {
            if (ModelState.IsValid)
            {
                movie.UploadedFiles = new List<UploadedFile>();
                AddFiles(movie, files);

                db.Movies.Add(movie);
                db.SaveChanges();
            }

            return RedirectToAction("Index");
        }

        private void AddFiles(Movie movie, IEnumerable<HttpPostedFileBase> files)
        {
            foreach (var file in files)
            {
                if (file != null && file.ContentLength > 0)
                {
                    var picture = new UploadedFile
                    {
                        Name = file.FileName,
                        ContentType = file.ContentType
                    };

                    using (var reader = new System.IO.BinaryReader(file.InputStream))
                    {
                        picture.Content = reader.ReadBytes(file.ContentLength);
                    }
                    movie.UploadedFiles.Add(picture);
                }
            }
        }

        // GET: Movie/Edit/5
        public ActionResult Edit(int? id)
        {
            return CommonAction(id);
        }

        // POST: Movie/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, IEnumerable<HttpPostedFileBase> files)
        {
            Movie movie = db.Movies.Find(id);

            if (TryUpdateModel(movie, "", new string[] {
                nameof(Movie.Title),
                nameof(Movie.Description),
                nameof(Movie.Duration),
                nameof(Movie.PublishedDate),
                nameof(Movie.Genre),
                nameof(Movie.Director)
            }))
            {
                AddFiles(movie, files);

                db.Entry(movie).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(movie);
        }

        // GET: Movie/Delete/5
        public ActionResult Delete(int? id)
        {
            return CommonAction(id);
        }

        // POST: Movie/Delete/5
        [HttpPost]
        public ActionResult Delete(int id)
        {
            db.UploadedFiles.RemoveRange(db.UploadedFiles.Where(f =>
            f.MovieIDMovie == id));
            db.Movies.Remove(db.Movies.Find(id));
            db.SaveChanges();

            return RedirectToAction("Index");
        }
    }
}
