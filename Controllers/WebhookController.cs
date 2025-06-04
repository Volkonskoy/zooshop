using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;
using System.Text;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using Zooshop.Models;
using System.Text.Json;
using Zooshop.Data;

namespace Zooshop.Controllers
{
    [Route("api/[controller]")]
    public class WebhookController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly ILogger<WebhookController> _logger;
        private readonly AppDbContext db;

        public WebhookController(IConfiguration configuration, ILogger<WebhookController> logger, AppDbContext context)
        {
            _configuration = configuration;
            _logger = logger;
            db = context;
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] JsonElement payload)
        {
            Console.WriteLine("Webhook received: " + payload.ToString());

            var invoiceId = payload.GetProperty("invoiceId").GetString();
            var status = payload.GetProperty("status").GetString();

            if (status == "success")
            {
                Console.WriteLine($"Invoice {invoiceId} was successfully paid.");
                int userId;
                int.TryParse(payload.GetProperty("reference").GetString(), out userId);

                var cartItems = db.Carts.Where(c => c.UserId == userId).ToList();

                if (!cartItems.Any())
                {
                    return BadRequest("Корзина пуста.");
                }

                var lastOrder = db.Orders.Where(o => o.UserId == userId).OrderByDescending(o => o.OrderId).FirstOrDefault();

                int orderId = lastOrder != null ? lastOrder.OrderId + 1 : 1;

                var currentDate = DateTime.Now.ToString("yyyy-MM-dd");
                var state = "Сплачено";

                var orders = cartItems.Select(cartItem => new Order
                {
                    OrderId = orderId,
                    UserId = cartItem.UserId,
                    ProductId = cartItem.ProductId,
                    Date = currentDate,
                    State = state,
                    Count = cartItem.Count
                }).ToList();

                db.Orders.AddRange(orders);
                db.Carts.RemoveRange(cartItems);
                db.SaveChanges();
            }
            else
            {
                Console.WriteLine($"Invoice {invoiceId} was ERROR");
            }

            return Ok();
        }
    }
}