using Microsoft.AspNetCore.Mvc;
using Zooshop.Data;
using Zooshop.Models;

namespace Zooshop.Controllers
{
    [Route("/api/[controller]")]
    public class UserController : Controller
    {
        private readonly AppDbContext db;

        public UserController(AppDbContext context)
        {
            db = context; //Создаём экземпляр дб контекста для операций с бд
        }

        [HttpGet]
        public IEnumerable<User> Get() => db.Users.ToList();
    }
}
