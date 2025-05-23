using System.ComponentModel.DataAnnotations;

namespace Zooshop.Models
{
    public class Product
    {
        public int Id { get; set; }
        [Required]
        public string Name { get; set; }
        public int Price { get; set; }
        public string Image { get; set; }
        public string Desc { get; set; }
    }
}
