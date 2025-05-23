import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<CartItem> cartItems = [
    CartItem(
      name: 'Savory Medium Breed сухий корм для собак 3 кг - індичка та ягня',
      price: 365,
      oldPrice: 450,
      imageAsset: 'assets/images/image.png',
      available: false,
    ),
    CartItem(
      name: 'Brit Care Mono Protein вологий корм для собак 400 г - кролик',
      price: 298,
      imageAsset: 'assets/images/image2.png',
    ),
    CartItem(
      name: 'Сухий корм для дорослих собак усіх порід Carnilove True Fresh',
      price: 365,
      oldPrice: 450,
      imageAsset: 'assets/images/image3.png',
    ),
    CartItem(
      name: 'Іграшка для гризуна морквина 10 см - натуральні матеріали',
      price: 189,
      imageAsset: 'assets/images/image4.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 140, vertical: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Кошик",
                    style: GoogleFonts.montserrat(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF95C74E),
                    ),
                  ),
                  SizedBox(height: 32),
                  ...cartItems.asMap().entries.map((entry) => _buildCartItem(entry.value, entry.key)).toList()

                ],
              ),
            ),

            SizedBox(width: 50),

            _buildSummaryBlock(),
          ],
        ),
      ),
    );
  }

    
  Widget _buildCartItem(CartItem item, int index) {
   return Container(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 126,
                  height: 126,
                  child: Image.asset(item.imageAsset, fit: BoxFit.contain),
                ),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            cartItems.removeAt(index);
                          });
                        },
                        icon: Icon(Icons.delete, color: Color(0xFFF54949)),
                        label: Text(
                          'Видалити',
                          style: TextStyle(
                              color: Color(0xFFF54949), fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: () {
                        },
                        icon: Icon(Icons.refresh, color: Color(0xFF8DD048)),
                        label: Text(
                          'Замовляти повторно',
                          style: TextStyle(
                              color: Color(0xFF8DD048), fontSize: 16),
                        ),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (item.quantity > 1) item.quantity--;
                                });
                              },
                              iconSize: 20,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '${item.quantity}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  item.quantity++;
                                });
                              },
                              iconSize: 20,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!item.available)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline,
                              size: 20, color: Colors.grey),
                          SizedBox(width: 4),
                          Text(
                            'Немає в наявності',
                            style:
                                TextStyle(color: Colors.grey[600], fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${(item.price * item.quantity).toStringAsFixed(0)} ₴',
                  style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF333333)),
                ),
                if (item.oldPrice != null)
                  Text(
                    '${item.oldPrice!.toStringAsFixed(0)} ₴',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
          ],
        ),
        Divider(height: 32),
      ],
    ),
  );
}
}

class CartItem {
  final String name;
  final double price;
  final double? oldPrice;
  final String imageAsset;
  final bool available;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    this.oldPrice,
    required this.imageAsset,
    this.available = true,
    this.quantity = 1,
  });
}

Widget _buildSummaryBlock() {
  return Container(
    width: 300,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFC16AFF)),
          onPressed: () {},
          child: Center(child: Text("Оформити замовлення")),
        ),
        SizedBox(height: 20),
        Text("4 товари", style: TextStyle(fontSize: 16)),
        Text("Доставка Новою Поштою: 50 ₴", style: TextStyle(fontSize: 16)),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Разом", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("6890 ₴", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        )
      ],
    ),
  );
}
