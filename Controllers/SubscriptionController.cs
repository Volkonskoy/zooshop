using Microsoft.AspNetCore.Mvc;
using Zooshop.Data;

namespace Zooshop.Controllers
{
    [Route("/api/[controller]")]
    public class SubscriptionController : Controller
    {
        private readonly AppDbContext db;

        public SubscriptionController(AppDbContext context)
        {
            db = context; //Создаём экземпляр дб контекста для операций с бд
        }
    }
}
