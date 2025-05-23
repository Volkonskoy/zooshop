import 'package:flutter/material.dart';
import 'package:zooshop/account_page.dart';
import 'package:zooshop/adress_page.dart';
import 'package:zooshop/change_password_page.dart';
import 'package:zooshop/orders_page.dart';
import 'package:zooshop/subscription_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class AccountLayout extends StatelessWidget {
  final Widget child;
  final String activeMenu;
  const AccountLayout({required this.child, required this.activeMenu, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidthForOrders = screenWidth - 280; 
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final ordersAmount = ordersProvider.processingCount;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 140, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activeMenu,
              style: GoogleFonts.montserrat(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF95C74E),
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _menuItem(context, 'Обліковий запис', page: AccountPage(), isActive: activeMenu == 'Обліковий запис'),
                      _menuItem(context, 'Адреса доставки', page: AddressPage(), isActive: activeMenu == 'Адреса доставки'),
                      _menuItem(context, 'Історія замовлень', page: OrdersPage(), isActive: activeMenu == 'Історія замовлень', ordersAmount: ordersAmount),
                      _menuItem(context, 'Підписки', page: SubscriptionPage(), isActive: activeMenu == 'Підписки'),
                      _menuItem(context, 'Змінити пароль', page: ChangePasswordPage(), isActive: activeMenu == 'Змінити пароль'),

                    ],
                  ),
                  SizedBox(width: 35), 
                  Container(
                    width: 1,                
                    height: 408, 
                    color: Color(0xFFC8CBD0),
                  ),
                  SizedBox(width: 55),
                  if (activeMenu == 'Історія замовлень' || activeMenu == 'Підписки') 
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidthForOrders),
                      child: child,
                    ),
                  )
                else 
                  SizedBox(
                    width: 365,
                    height: MediaQuery.of(context).size.height,
                    child: child,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem( BuildContext context, String title, { Widget? page, bool isActive = false, int ordersAmount = 0,}) {
    bool isOrders = title == 'Історія замовлень';

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (page != null && !isActive) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => page));
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isActive ? FontWeight.w800 : FontWeight.normal,
                  color:
                      isActive ? Colors.black : const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              if (isOrders && ordersAmount > 0) ...[
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Color(0xFFC16AFF),
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: Text(
                    '$ordersAmount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

}

