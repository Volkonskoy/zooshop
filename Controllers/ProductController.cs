using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;
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

        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            var product = db.Products.SingleOrDefault(p => p.Id == id);

            if (product == null) { return NotFound(); }
            return Ok(product);
        }

        [HttpGet("Filtration")]
        public IActionResult Get([FromQuery] ProductDTO productDTO)
        {
            var query = db.Products.AsQueryable(); // Начинаем с запроса ко всем товарам

            // Фильтрация по Name, если он задан
            if (!string.IsNullOrEmpty(productDTO.Name))
            {
                query = query.Where(p => p.Name.Contains(productDTO.Name));
            }

            // Фильтрация по диапазону цен (StartPrice и EndPrice)
            if (productDTO.StartPrice.HasValue && productDTO.EndPrice.HasValue)
            {
                query = query.Where(p => p.Price >= productDTO.StartPrice.Value && p.Price <= productDTO.EndPrice.Value);
            }
            // Если указан только StartPrice, фильтруем по минимальной цене
            else if (productDTO.StartPrice.HasValue)
            {
                query = query.Where(p => p.Price >= productDTO.StartPrice.Value);
            }
            // Если указан только EndPrice, фильтруем по максимальной цене
            else if (productDTO.EndPrice.HasValue)
            {
                query = query.Where(p => p.Price <= productDTO.EndPrice.Value);
            }

            // Фильтрация по PetCategory, если она задана
            if (!string.IsNullOrEmpty(productDTO.PetCategory))
            {
                query = query.Where(p => p.PetCategory.Contains(productDTO.PetCategory));
            }

            // Фильтрация по ProductCategory, если она задана
            if (!string.IsNullOrEmpty(productDTO.ProductCategory))
            {
                query = query.Where(p => p.ProductCategory.Contains(productDTO.ProductCategory));
            }

            var products = query.ToList(); // Выполняем запрос и получаем товары

            if (products.Any())
            {
                return Ok(products); // Возвращаем найденные товары
            }

            return NotFound(); // Если товары не найдены, возвращаем 404
        }
    }
}

public class ProductDTO
{
    public string? Name { get; set; }
    public int? StartPrice { get; set; }
    public int? EndPrice { get; set; }
    public string? PetCategory { get; set; }
    public string? ProductCategory { get; set; }
}