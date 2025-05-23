using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Zooshop.Data;
using Zooshop.Models;

namespace Zooshop.Controllers
{
    [Route("/api/[controller]")]
    public class ProductController : Controller
    {
        private readonly AppDbContext db;

        public ProductController(AppDbContext context)
        {
            db = context; //Создаём экземпляр дб контекста для операций с бд
        }

        [HttpGet]
        public IEnumerable<Product> Get() => db.Products.ToList();
    }
}