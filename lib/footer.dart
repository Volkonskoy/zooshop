import 'package:flutter/material.dart';

class FooterBlock extends StatelessWidget {
  const FooterBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1.0, color: Colors.grey),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("О нас"),
            Text("Доставка"),
            Text("Часті запитання"),
            Text("Відгуки"),
            Text("Статті"),
            Text("Контакти"),
          ],
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "© 2025 Інтернет магазин зоотоварів \n“Пухнастик”",
            ),
            Text(
              "Вартість товарів на сайті не є \nпублічною офертою",
            ),
            Text("Умови угоди"),
            Row(
              spacing: 10,
              children: [
                Icon(Icons.call, color: Colors.green),
                Text("+380991992827"),
              ],
            ),
          ],
        ),
        SizedBox(height: 50),
      ],
    );
  }
}