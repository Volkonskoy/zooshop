import 'package:flutter/material.dart';
import 'header.dart';
import 'footer.dart';
import 'package:zooshop/main.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 1300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 1200,
                    child: HeaderBlock(),
                  ),
                ),
                SizedBox(height: 20),
                ProductBlock(),
                SizedBox(height: 30),
                DetailBlock(),
                SizedBox(height: 60,),
                RecomendationBlock(),
                SizedBox(height: 70),
                Center(
                  child: SizedBox(
                    width: 1200,
                    child: FooterBlock(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductBlock extends StatelessWidget {
  const ProductBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          width: 370,
          height: 370,
          image: AssetImage('assets/images/product.png'),
          fit: BoxFit.cover,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Brit Care Mono Protein вологий корм для собак",
              style: TextStyle(
                color: const Color.fromARGB(
                  255,
                  69,
                  50,
                  43,
                ),
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 500,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text("Код товару: 13234"),
                      SizedBox(height: 50),
                      SizedBox(
                        width: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                Text("Тип"),
                                SizedBox(
                                  width: 50,
                                  child: Text("Корм"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                Text("Виробник"),
                                SizedBox(
                                  width: 50,
                                  child: Text("Brit"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      PriceCard(
                        oldPrice: "250",
                        newPrice: "400",
                      ),
                      SizedBox(height: 20),
                      Row(
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.purpleAccent,
                          ),
                          Text(
                            "Є на складі",
                            style: TextStyle(
                              color: Colors.purpleAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PriceCard extends StatelessWidget {
  final String oldPrice;
  final String newPrice;

  const PriceCard({
    super.key,
    required this.oldPrice,
    required this.newPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 264,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$newPrice ₴",
            style: TextStyle(
              color: Color(0xFFF54949),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 27),
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF95C74E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), 
                ),
              ),
              child: Text(
                "Купити",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 11),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 27),
            width: double.infinity,
            height: 40,
            child: OutlinedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => OneClickOrderDialog(), 
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color(0xFF95C74E)), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                foregroundColor: Color(0xFF95C74E), 
              ),
              child: Text("Купити в один клік"),
            ),
          ),

        ],
      ),
    );
  }
}

class DetailBlock extends StatelessWidget {
  const DetailBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Опис",
              style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Divider(height: 1.0, color: Colors.grey),
            SizedBox(height: 10),
            SizedBox(
              width: 600,
              child: Text(
                "Корм для британських короткошерстих котів створений з урахуванням особливостей цієї породи. Кремезні та сильні тварини потребують раціону, який дасть змогу зміцнити їхні суглоби та підтримає роботу серця. Застосування british shorthair adult знижує ризик серцевих захворювань. Кількість жирів обмежена.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecomendationBlock extends StatelessWidget {
  const RecomendationBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Рекомендовані товари",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            ProductCard(),
            ProductCard(),
            ProductCard(),
            ProductCard(),
          ],
        ),
      ],
    );
  }
}

// class ProductCard extends StatelessWidget {
//   const ProductCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Изображение продукта
//           SizedBox(height: 10),
//           Image.asset(
//             'assets/images/product.png', // Путь к изображению товара
//             height: 120,
//             fit: BoxFit.cover,
//           ),
//           SizedBox(height: 10),
//           // Название продукта
//           Text(
//             'Brit Care Mono Protein',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           // Описание
//           Text(
//             'вологий корм для собак 400 г - кролик',
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: 12,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           // Цена
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 '298 ₴',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               SizedBox(width: 8),
//               Text(
//                 '450 ₴',
//                 style: TextStyle(
//                   decoration: TextDecoration.lineThrough,
//                   color: Colors.grey,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//           // Кнопка
//           SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProductPage(),
//                 ),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.purple, // Цвет кнопки
//               padding: EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 12,
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Text(
//               'Купити',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           // Кнопка "Купить за 1 клик"
//           SizedBox(height: 10),
//           TextButton(
//             onPressed: () {},
//             child: Text(
//               'Купити за 1 клік',
//               style: TextStyle(color: Colors.purple),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }