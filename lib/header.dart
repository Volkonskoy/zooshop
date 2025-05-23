import 'package:flutter/material.dart';
import 'package:zooshop/account_page.dart';
import 'catalog.dart';
import 'main.dart';

class HeaderBlock extends StatelessWidget {
  const HeaderBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, 
      padding: EdgeInsets.only(top: 30),  
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 300,
            height: 200,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                );
              },
              child: Image(
                image: AssetImage('assets/images/logo.png'),
              ),
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
                    Expanded(
                      flex: 3,
                      child: SearchBar(),
                    ),
                    SizedBox(width: 20),
                    LoginButton(),
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

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage()));
        },
        icon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        label: Text(
          'Log In/Sign In',
          style: TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
       
        ),
      ),
    );
  }
}


class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Пошук товарів',
        suffixIcon: Icon(Icons.search, color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
      ),
    );
  }
}
