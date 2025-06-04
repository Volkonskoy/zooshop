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
            db = context;
        }

        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            var cart = db.Carts.Where(c => c.UserId == id).ToList();

            if (cart == null) { return NotFound(); }
            return Ok(cart);
        }

        [HttpPost]
        public IActionResult Post([FromBody] Cart cart)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var oldCart = db.Carts.SingleOrDefault(c => c.UserId == cart.UserId && c.ProductId == cart.ProductId);

            if(oldCart == null)
            {
                var newCart = new Cart { UserId = cart.UserId, ProductId = cart.ProductId, Count = cart.Count };
                db.Carts.Add(newCart);
                db.SaveChanges();
                return Ok(newCart);
            } else
            {
                oldCart.Count = oldCart.Count + 1;
                db.SaveChanges();
                return Ok(oldCart);
            }
        }

        [HttpDelete("DeleteProduct/{userId}/{productId}")]
        public IActionResult Delete(int userId, int productId)
        {
            
            var cartItem = db.Carts.SingleOrDefault(c => c.UserId == userId && c.ProductId == productId);

            
            if (cartItem == null)
            {
                return NotFound("Товар не знайдено у кошику.");
            }

            
            db.Carts.Remove(cartItem);
            db.SaveChanges();

            return Ok("Товар успішно видалено з кошику.");
        }

        [HttpDelete("ClearCart/{userId}")]
        public IActionResult ClearCart(int userId)
        {
            
            var cartItems = db.Carts.Where(c => c.UserId == userId).ToList();

            
            if (!cartItems.Any())
            {
                return NotFound("Кошик порожній.");
            }

            
            db.Carts.RemoveRange(cartItems);
            db.SaveChanges(); 

            return Ok("Корзина успешно очищена.");
        }

        [HttpPut]
        public IActionResult UpdateQuantity([FromBody] Cart updatedCart)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var cartItem = db.Carts.SingleOrDefault(c => c.UserId == updatedCart.UserId && c.ProductId == updatedCart.ProductId);

            if (cartItem == null)
            {
                return NotFound("Товар не знайдено в кошику.");
            }

            cartItem.Count = updatedCart.Count;

            db.SaveChanges();
            return Ok(cartItem);
        }

    }
}