import 'package:flutter/material.dart';
import 'header.dart';
import 'footer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MainPage()
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 1200,
            child: Column(
              children: [
                HeaderBlock(),
                SizedBox(height: 50),
                PromoVetCard(),
                SizedBox(height: 50),
                SalesBlock(),
                SizedBox(height: 50),
                PromoConsultCard(),
                SizedBox(height: 50),
                NewsBlock(),
                SizedBox(height: 50),
                BrandsBlock(),
                SizedBox(height: 70),
                FooterBlock(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PromoVetCard extends StatelessWidget {
  const PromoVetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      height: 300,
      decoration: BoxDecoration(
        color: Colors.lightGreenAccent, // Цвет фона
        borderRadius: BorderRadius.circular(
          16,
        ), // Округлые углы
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Текстовая часть
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Кошталтість сильно підвищиться!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Знижка 20% на всі шампуні для кошенят.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 80),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.purple, // Цвет кнопки
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  spacing: 20,
                  children: [
                    Text(
                      'Дивитися шампуні',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 300,
            height: 300,
            child: Image(
              image: AssetImage('assets/images/cat.png'),
            ),
          ),
        ],
      ),
    );
  }
}

class PromoConsultCard extends StatelessWidget {
  const PromoConsultCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      height: 300,
      decoration: BoxDecoration(
        color: Colors.orangeAccent, // Цвет фона
        borderRadius: BorderRadius.circular(
          16,
        ), // Округлые углы
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Текстовая часть
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ми готові оказати вам підтримку в виборі',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Безкоштовні консультації',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 80),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green, // Цвет кнопки
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  spacing: 20,
                  children: [
                    Text(
                      'Зв`язок з консультантом',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 300,
            height: 300,
            child: Image(
              image: AssetImage(
                'assets/images/consultant.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SalesBlock extends StatelessWidget {
  const SalesBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1000,
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Акції",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  Text("Дивитись усе"),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              ProductCard(),
              ProductCard(),
              ProductCard(),
              ProductCard(),
            ],
          ),
        ],
      ),
    );
  }
}

class NewsBlock extends StatelessWidget {
  const NewsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1000,
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Новинки",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  Text("Дивитись усе"),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              ProductCard(),
              ProductCard(),
              ProductCard(),
              ProductCard(),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Стикер скидки
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '-33%',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Изображение продукта
          SizedBox(height: 10),
          Image.asset(
            'assets/images/product.png', // Путь к изображению товара
            height: 120,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          // Название продукта
          Text(
            'Brit Care Mono Protein',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          // Описание
          Text(
            'вологий корм для собак 400 г - кролик',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          // Цена
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '298 ₴',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '450 ₴',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          // Кнопка
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple, // Цвет кнопки
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Купити',
              style: TextStyle(color: Colors.white),
            ),
          ),
          // Кнопка "Купить за 1 клик"
          SizedBox(height: 10),
          TextButton(
            onPressed: () {},
            child: Text(
              'Купити за 1 клік',
              style: TextStyle(color: Colors.purple),
            ),
          ),
        ],
      ),
    );
  }
}

class BrandsBlock extends StatelessWidget {
  const BrandsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Популярні бренди',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              // Логотипы в одном ряду
              _buildLogo('assets/images/royalcanin.png'),
              _buildLogo('assets/images/whiskas.png'),
              _buildLogo('assets/images/royalcanin.png'),
              _buildLogo('assets/images/whiskas.png'),
              _buildLogo('assets/images/royalcanin.png'),
              _buildLogo('assets/images/whiskas.png'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogo(String imagePath) {
    return SizedBox(
      width: 150, // Фиксированная ширина
      height: 150, // Фиксированная высота
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          8,
        ), // Округление углов внутри контейнера
        child: Image.asset(
          imagePath,
          fit:
              BoxFit
                  .contain, // Растягивание изображения по контейнеру
        ),
      ),
    );
  }
}
