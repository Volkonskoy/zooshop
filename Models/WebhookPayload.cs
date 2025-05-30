namespace Zooshop.Models
{
    public class WebhookPayload
    {
        public string InvoiceId { get; set; }
        public string Status { get; set; }
        public int Amount { get; set; }
        public int Ccy { get; set; }
        public int FinalAmount { get; set; }
        public string CreatedDate { get; set; }
        public string ModifiedDate { get; set; }
    }
}
