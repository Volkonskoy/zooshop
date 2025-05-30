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
            // Выводим тело запроса в лог (или сохраняем)
            Console.WriteLine("Webhook received: " + payload.ToString());

            // Можно извлекать данные так:
            var invoiceId = payload.GetProperty("invoiceId").GetString();
            var status = payload.GetProperty("status").GetString();

            // Тут ваша логика — например, отметить в БД, что платёж прошёл
            if (status == "success")
            {
                Console.WriteLine($"Invoice {invoiceId} was successfully paid.");
                int orderId;
                //JsonElement merchantPaymInfo = payload.GetProperty("merchantPaymInfo");
                int.TryParse(payload.GetProperty("reference").GetString(), out orderId);
                var orderList = db.Orders.Where(o => o.OrderId == orderId).ToList();
                if(orderList != null)
                {
                    foreach (var order in orderList)
                    {
                        order.State = "Оплачено"; // Устанавливаем новое значение для поля State
                    }
                }
            }
            else
            {
                Console.WriteLine($"Invoice {invoiceId} was ERROR");
            }

            return Ok(); // Monobank ожидает 200 OK
        }
    }
}
