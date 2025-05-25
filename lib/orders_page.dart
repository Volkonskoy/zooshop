import 'package:flutter/material.dart';
import 'package:zooshop/account_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'package:zooshop/models/Order.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int _currentPage = 0;
  final int _ordersPerPage = 5;
  List<OrderDTO> orders = [];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    if (user == null || user.id == null) {
      return Scaffold(
        body: Center(child: Text('Користувач не авторизований')),
      );
    }

    return FutureBuilder<List<OrderDTO>>(
      future: fetchOrdersByUserId(user.id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Помилка: ${snapshot.error}')));
        }

        orders = snapshot.data ?? [];
        final totalPages = (orders.length / _ordersPerPage).ceil();
        final startIndex = _currentPage * _ordersPerPage;
        final endIndex = (_currentPage + 1) * _ordersPerPage;
        final currentOrders = orders.sublist(
          startIndex,
          endIndex > orders.length ? orders.length : endIndex,
        );

        if (orders.isEmpty) {
          return AccountLayout(
            activeMenu: 'Історія замовлень',
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Замовлень немає',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        } else {
          return AccountLayout(
            activeMenu: 'Історія замовлень',
            child: Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...currentOrders
                        .asMap()
                        .entries
                        .map((entry) => _buildOrderCard(entry.value, entry.key))
                        .toList(),
                    SizedBox(height: 24),
                    _buildPagination(totalPages),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void _confirmDelete(int index) {

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 460,
        height: 370,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 21),
                  child: Image.asset('assets/images/crying-cat-face.png'),
                ),
                Text(
                  'Ви впевнені, що бажаєте\nскасувати замовлення?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 31, left: 66, top: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 168,
                        height: 40,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Color(0xFF67AF45),
                            side: BorderSide(color: Color(0xFF67AF45)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 0),
                          ),
                          child: Text(
                            'Не скасовувати',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      SizedBox(
                        width: 145,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            // setState(() {
                            //   orders.elementAt(index).state = 'Скасовано';
                            // });
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF74E4E),
                            foregroundColor: Color(0xFFFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 0),
                          ),
                          child: Text(
                            'Скасувати',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.close, size: 28),
                onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(OrderDTO order, int index) {
    Color statusColor;
    final isCancellable = order.state == 'В обробці' || order.state == 'Не оплачен';
    final canReorder = order.state == 'Скасовано' || order.state == 'Доставлено';

    switch (order.state) {
      case 'В обробці':
        statusColor = Color(0xFF67AF45);
        break;
      case 'Доставлено':
        statusColor = Color(0xFF67AF45);
        break;
      case 'Скасовано':
        statusColor = Color(0xFFF54949);
        break;
      default:
        statusColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                  children: [
                    TextSpan(text: 'Замовлення від  ' + order.date),
                    TextSpan(
                      text: '№${order.id}',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF848992),
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(), 
              Text(
                order.state,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: order.state == 'В обробці' ? FontWeight.w800 : FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 24),
              Text(
                '${countItemsInOrder(order.orderId)} товари',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 24),
              Text(
                '${totalCost()} ₴',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
            ],
          ),

          SizedBox(height: 13),
          if (isCancellable)
          TextButton.icon(
            onPressed: () => _confirmDelete(index),
            icon: Icon(Icons.close, color: Color(0xFFF54949)),
            label: Text(
              'Скасувати замовлення',
              style: TextStyle(color: Color(0xFFF54949), fontSize: 16),
            ),
          ),
        if (canReorder)
          TextButton.icon(
            onPressed: () => _confirmReorder(order),
            icon: Icon(Icons.refresh, color: Color(0xFFFF8A00)),
            label: Text(
              'Замовити ще раз',
              style: TextStyle(color: Color(0xFFFF8A00), fontSize: 16),
            ),
          ),
        Divider(height: 32),
      ],
      ),
    );
  }

  int countItemsInOrder(int orderId ) {
    return orders.where((order) => order.orderId == orderId).length;
  }

  int totalCost(){
    int total = 0;
    
    for (var order in orders) {
      int quantity = 1; 
      // if (cartItem.quantity != null) {
      //   quantity = cartItem.quantity;
      // }

      total += order.product.price * quantity;
    }
    
    return total;
  }

  Widget _buildPagination(int totalPages) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: _currentPage > 0
            ? () {
                setState(() {
                  _currentPage--;
                });
              }
            : null, 
      ),
    ...List.generate(totalPages, (index) {
      final isActive = index == _currentPage;
      return GestureDetector(
        onTap: () {
          setState(() {
            _currentPage = index;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 6),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? Color(0xFFC16AFF) : const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }),
    
    IconButton(
        icon: Icon(Icons.chevron_right),
        onPressed: _currentPage < totalPages - 1
            ? () {
                setState(() {
                  _currentPage++;
                });
              }
            : null, 
      ),
    ]
  );
}


  void _confirmReorder(OrderDTO order) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: 460,
          height: 179,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30),
              Text(
                'Додати товари від "Замовлення від ${order.date}" до кошика?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF333333), 
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 29),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 143,
                    height: 40,
                    child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF67AF45)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text(
                      'Скасувати',
                      style: TextStyle(color: Color(0xFF67AF45), fontSize: 16),
                    ),
                  )
                  
                  ),
                  SizedBox(width: 16),
                  SizedBox(
                    width: 143,
                    height: 40,
                      child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Товари додано до кошика')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8DC63F), 
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        'Додати',
                        style: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600 ),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class Order {
  String name;
  String state;
  int quantity;
  int number;
  double sum;

  Order({
    String? name,
    this.state = "В обробці",
    this.quantity = 3,
    this.number = 10662,
    this.sum = 3651,
  }) : name = name ?? "Замовлення від ${DateTime.now().toIso8601String().split('T')[0]}";
}

// class OrdersProvider with ChangeNotifier {
//   List<Order> _orders = [];

//   List<Order> get orders => _orders;

//   int get processingCount =>
//       _orders.where((o) => o.state == 'В обробці').length;

//   void setOrders(List<Order> orders) {
//     _orders = orders;
//     notifyListeners();
//   }

//   void cancelOrder(int index) {
//     _orders[index].state = 'Скасовано';
//     notifyListeners();
//   }
// }
