using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;
using Zooshop.Data;
using Zooshop.Models;
using Marten.Util;
using LinqKit;
using Polly;

namespace Zooshop.Controllers
{
    [Route("/api/[controller]")]
    public class ProductController : Controller
    {
        private readonly AppDbContext db;

        public ProductController(AppDbContext context)
        {
            db = context;
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
            var query = db.Products.AsQueryable();

            if (!string.IsNullOrEmpty(productDTO.Name))
            {
                String tempName = productDTO.Name.ToLower();
                query = query.ToList().AsQueryable().Where(p => p.Name.ToLower().Contains(productDTO.Name.ToLower()));
            }

            if (productDTO.StartPrice.HasValue && productDTO.EndPrice.HasValue)
            {
                query = query.Where(p => p.Price >= productDTO.StartPrice.Value && p.Price <= productDTO.EndPrice.Value);
            }
            else if (productDTO.StartPrice.HasValue)
            {
                query = query.Where(p => p.Price >= productDTO.StartPrice.Value);
            }
            else if (productDTO.EndPrice.HasValue)
            {
                query = query.Where(p => p.Price <= productDTO.EndPrice.Value);
            }

            if (!string.IsNullOrEmpty(productDTO.PetCategory))
            {
                query = query.Where(p => p.PetCategory.Contains(productDTO.PetCategory));
            }

            if (!string.IsNullOrEmpty(productDTO.ProductCategory))
            {
                var categories = productDTO.ProductCategory.Split(',')
                                              .Select(c => c.Trim())
                                              .ToArray();
                var predicate = LinqKit.PredicateBuilder.New<Product>(p => false);

                foreach (var category in categories)
                {
                    predicate = predicate.Or(p => p.ProductCategory.Contains(category));
                }

                query = query.Where(predicate);
            }

            var products = query.ToList();

            if (products.Any())
            {
                return Ok(products);
            }

            return NotFound();
        }

        [HttpGet("Categories")]
        public IActionResult GetCategories()
        {
            var productCategories = db.Products
                .Select(p => p.ProductCategory)
                .Distinct()
                .Where(c => !string.IsNullOrEmpty(c))
                .ToList();

            var petCategories = db.Products
                .Select(p => p.PetCategory)
                .Distinct()
                .Where(c => !string.IsNullOrEmpty(c))
                .ToList();

            var result = new
            {
                ProductCategories = productCategories,
                PetCategories = petCategories
            };

            return Ok(result);
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
    public int? DiscountPercent { get; set; }

}