import 'package:flutter/material.dart';
import 'package:zooshop/account_page.dart';
import 'catalog.dart';
import 'main.dart';


class HeaderBlockAuth extends StatelessWidget {
  final String userName;

  const HeaderBlockAuth({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 158,
            height: 158,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuTopNavigation(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: SearchBar()),
                    SizedBox(width: 20),
                    UserProfileButton(userName: userName),
                  ],
                ),
                SizedBox(height: 20),
                MenuBottomNavigation(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileButton extends StatelessWidget {
  final String userName;

  const UserProfileButton({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton.icon(
        onPressed: () {
            Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => AccountPage(),
                          ),
                        );
        },
        icon: Icon(Icons.person, color: Colors.green),
        label: Text(
          userName,
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.grey),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    );
  }
}
class MenuTopNavigation extends StatelessWidget {
  const MenuTopNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 30.0,
          children: [
            Text("О нас"),
            Text("Доставка"),
            Text("Часті запитання"),
            Text("Відгуки"),
            Text("Статті"),
            Text("Контакти"),
            Row(
              spacing: 10,
              children: [
                Icon(Icons.call, color: Colors.green),
                Text("+380991992827"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class MenuBottomNavigation extends StatelessWidget {
  const MenuBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 30.0,
          children: [
            Row(
              spacing: 10,
              children: [
                TextButton(
                  onPressed:
                      () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CatalogPage(),
                          ),
                        ),
                      },
                  child: Text(
                    "Кішки",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed:
                      () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CatalogPage(),
                          ),
                        ),
                      },
                  child: Text(
                    "Собаки",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(width: 350),
            Row(
              spacing: 5,
              children: [
                Text("Акції"),
                Icon(Icons.percent, color: Colors.green),
              ],
            ),
          ],
        ),
      ],
    );
  }
}