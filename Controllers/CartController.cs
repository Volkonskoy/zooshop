using Microsoft.AspNetCore.Mvc;
using Zooshop.Data;
using Zooshop.Models;

namespace Zooshop.Controllers
{
    [Route("/api/[controller]")]
    public class CartController : Controller
    {
        private readonly AppDbContext db;

        public CartController(AppDbContext context)
        {
            db = context; //Создаём экземпляр дб контекста для операций с бд
        }

        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            var cart = db.Carts.Where(c => c.UserId == id).ToList();

            if (cart == null) { return NotFound(); }
            return Ok(cart);
        }

        [HttpPost] //Этот запрос выполняется когда уже известны все атрибуты класса, тоесть они переданы прямо
        public IActionResult Post([FromBody] Cart cart)
        {
            if (!ModelState.IsValid) //Проверяет атрибуты Required
            {
                return BadRequest(ModelState);
            }

            var newCart = new Cart { UserId = cart.UserId, ProductId = cart.ProductId };

            db.Carts.Add(newCart);
            db.SaveChanges();
            return Ok(newCart);
        }
    }
}