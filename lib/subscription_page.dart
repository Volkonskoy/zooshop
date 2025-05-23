import 'package:flutter/material.dart';
import 'package:zooshop/account_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    final subscriptions = context.watch<SubscriptionProvider>().subscriptions;
    return AccountLayout(
      activeMenu: 'Підписки',
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: subscriptions
              .asMap()
              .entries
              .map((entry) => _buildSubscriptionCard(entry.value, entry.key))
              .toList(),
        ),
      ),
    );
  }

Widget _buildSubscriptionCard(Subscription subscription, int index) {
  return Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column (
              children:[ SizedBox(
                  width: 126,
                  height: 126,
                  child: subscription.product.image,
                ),
              ],
            ),
            Expanded(
              child: Column(
                children:[
                Text(
                  subscription.product.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                SizedBox(height: 29),
                Row(
                  children: [
                    TextButton.icon(
                    onPressed: () => _confirmDelete(index),
                    icon: Icon(Icons.delete, color: Color(0xFFF54949)),
                    label: Text(
                      'Скасувати підписку',
                      style: TextStyle(color: Color(0xFFF54949), fontSize: 16),
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
                            // уменьшить количество
                          },
                          iconSize: 20,
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '1', // текущая величина
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            // увеличить количество
                          },
                          iconSize: 20,
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                  ],
                )
              
              ],
              ),
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[ 
                Text(
                  '${subscription.product.price.toStringAsFixed(0)} ₴',
                  style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF333333)), 
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'раз на ',
                        style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                      ),
                      TextSpan(
                        text: subscription.periodInDays == 7
                            ? 'тиждень'
                            : subscription.periodInDays.toString(),
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC16AFF),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFC16AFF), 
                        ),
                        recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text('Деталі підписки'),
                              content: Text('Це період доставки: ${subscription.periodInDays} днів'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Закрити'),
                                ),
                              ],
                              ),
                            );
                        }
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
          ],
        ),
        Divider(height: 32)
      ],
    ),
  );
}

void _confirmDelete(int index) {
  final subscriptions = Provider.of<SubscriptionProvider>(context, listen: false).subscriptions;

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
                            setState(() {
                              subscriptions.elementAt(index).cancelled = true;
                            });
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

}

class Product {
  final int id;
  final String name;
  final double price;
  final Image image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image
  });
}

class Subscription {
  final Product product;
  final int periodInDays;
  final DateTime startDate;
  bool cancelled;

  Subscription({
    required this.product,
    this.periodInDays = 30,
    DateTime? startDate,
    this.cancelled = false
  }) : startDate = startDate ?? DateTime.now();

  DateTime get nextDeliveryDate => startDate.add(Duration(days: periodInDays));
}

class SubscriptionProvider extends ChangeNotifier {
  final List<Subscription> _subscriptions = [];

  List<Subscription> get subscriptions => List.unmodifiable(_subscriptions);

  void addSubscription(Subscription sub) {
    _subscriptions.add(sub);
    notifyListeners();
  }

  void removeSubscription(Subscription sub) {
    _subscriptions.remove(sub);
    notifyListeners();
  }

  void loadFromDatabase(List<Subscription> loaded) {
    _subscriptions.clear();
    _subscriptions.addAll(loaded);
    notifyListeners();
  }
}
