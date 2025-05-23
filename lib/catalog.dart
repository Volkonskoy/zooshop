import 'package:flutter/material.dart';
import 'package:zooshop/product.dart';
import 'package:zooshop/main.dart';
import 'header.dart';
import 'footer.dart';
import 'models/Product.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Scaffold(
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: screenWidth * 0.82,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderBlock(),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Товари для собак",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 69, 48, 40),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SettingsBlock(),
                        ProductsBlock(),
                      ],
                    ),
                  SizedBox(height: 70),
                ],
              ),
            ),
          ),

          Container(
            width: screenWidth,
            child: FooterBlock(), 
          ),
        ],
      ),
    ),
  );
}

}

class SettingsBlock extends StatelessWidget {
  const SettingsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ціна", style: TextStyle(fontSize: 25)),
              SizedBox(height: 20),
              Row(
                spacing: 10,
                children: [PriceFromTag(), PriceToTag()],
              ),
              SizedBox(height: 30),
              Text("Тип", style: TextStyle(fontSize: 25)),
              SizedBox(height: 20),
              ProductCheckbox(
                productName: "Корм",
                quantity: "345",
              ),
              ProductCheckbox(
                productName: "Іграшки",
                quantity: "233",
              ),
              ProductCheckbox(
                productName: "Аксесуари",
                quantity: "53",
              ),
              ProductCheckbox(
                productName: "Ліки",
                quantity: "12",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PriceFromTag extends StatelessWidget {
  const PriceFromTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ), // Цвет рамки
        borderRadius: BorderRadius.circular(
          8,
        ), // Закругленные углы
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize
                .min, // Ограничивает ширину контейнера до размера содержимого
        children: [
          Text(
            'Від',
            style: TextStyle(
              color: Colors.grey, // Цвет текста
              fontSize: 14, // Размер шрифта
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 30, // Ширина поля ввода
            child: TextField(
              keyboardType:
                  TextInputType
                      .number, // Ограничение для ввода чисел
              decoration: InputDecoration(
                border:
                    InputBorder
                        .none, // Без рамки внутри поля
                hintText: '300', // Подсказка по умолчанию
                hintStyle: TextStyle(
                  color:
                      Colors.brown, // Цвет текста подсказки
                  fontSize: 16, // Размер шрифта
                  fontWeight:
                      FontWeight.bold, // Жирный текст
                ),
              ),
              style: TextStyle(
                color:
                    Colors
                        .brown, // Цвет текста, который вводится
                fontSize: 16, // Размер шрифта
                fontWeight: FontWeight.bold, // Жирный текст
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PriceToTag extends StatelessWidget {
  const PriceToTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ), // Цвет рамки
        borderRadius: BorderRadius.circular(
          8,
        ), // Закругленные углы
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize
                .min, // Ограничивает ширину контейнера до размера содержимого
        children: [
          Text(
            'До',
            style: TextStyle(
              color: Colors.grey, // Цвет текста
              fontSize: 14, // Размер шрифта
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 30, // Ширина поля ввода
            child: TextField(
              keyboardType:
                  TextInputType
                      .number, // Ограничение для ввода чисел
              decoration: InputDecoration(
                border:
                    InputBorder
                        .none, // Без рамки внутри поля
                hintText: '800', // Подсказка по умолчанию
                hintStyle: TextStyle(
                  color:
                      Colors.brown, // Цвет текста подсказки
                  fontSize: 16, // Размер шрифта
                  fontWeight:
                      FontWeight.bold, // Жирный текст
                ),
              ),
              style: TextStyle(
                color:
                    Colors
                        .brown, // Цвет текста, который вводится
                fontSize: 16, // Размер шрифта
                fontWeight: FontWeight.bold, // Жирный текст
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCheckbox extends StatefulWidget {
  final String productName; // Название товара
  final String quantity; // Количество товара

  // Конструктор для передачи данных
  const ProductCheckbox({
    Key? key,
    required this.productName,
    required this.quantity,
  }) : super(key: key);

  @override
  _ProductCheckboxState createState() =>
      _ProductCheckboxState();
}

class _ProductCheckboxState extends State<ProductCheckbox> {
  bool isChecked = false; // Состояние чекбокса

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: isChecked, // Значение чекбокса
            onChanged: (bool? newValue) {
              setState(() {
                isChecked =
                    newValue ??
                    false; // Обновление состояния чекбокса
              });
            },
          ),
          SizedBox(width: 15),
          Text(
            widget
                .productName, // Использование переданного названия товара
            style: TextStyle(
              color: Colors.brown, // Цвет текста
              fontSize: 16, // Размер шрифта
              fontWeight: FontWeight.bold, // Жирный текст
            ),
          ),
          SizedBox(width: 8),
          Text(
            widget
                .quantity, // Использование переданного количества товара
            style: TextStyle(
              color: Colors.grey, // Цвет числа
              fontSize: 14, // Размер шрифта
            ),
          ),
        ],
      ),
    );
  }
}

class PurchasesBlock extends StatelessWidget {
  const PurchasesBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ProductsBlock extends StatelessWidget {
  const ProductsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: fetchProducts(), // Получаем список товаров
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Показать индикатор загрузки
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка загрузки данных')); // Обработка ошибки
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Нет товаров для отображения')); // Когда нет данных
        } else {
          List<Product> products = snapshot.data!;

          // Разбиваем список на несколько рядов
          return Column(
            children: List.generate((products.length / 4).ceil(), (index) {
              int startIndex = index * 4;
              int endIndex = (startIndex + 4) < products.length ? startIndex + 4 : products.length;
              List<Product> rowProducts = products.sublist(startIndex, endIndex);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Row(
                  spacing: 30,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: rowProducts.map((product) => ProductCard(product: product)).toList(),
                ),
              );
            }),
          );
        }
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 400,
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
          // Изображение продукта
          SizedBox(height: 10),
          Image.network(
            product.image, // Используем URL изображения
            height: 120,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          // Название продукта
          Text(
            product.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          // Описание
          Text(
            product.desc,
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
                '${product.price} ₴',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          // Кнопка
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(),
                ),
              );
            },
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
        ],
      ),
    );
  }
}


class PaginationWidget extends StatefulWidget {
  const PaginationWidget({super.key});

  @override
  _PaginationWidgetState createState() =>
      _PaginationWidgetState();
}

class _PaginationWidgetState
    extends State<PaginationWidget> {
  int currentPage = 1;
  int numPages = 49;

  void _onPageChanged(int page) {
    if (page > 0 && page <= numPages) {
      setState(() {
        currentPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        IconButton(
          onPressed: () {
            _onPageChanged(--currentPage);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        ...List.generate(5, (index) {
          int pageNumber = index + 1;
          return GestureDetector(
            onTap: () => _onPageChanged(pageNumber),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color:
                    currentPage == pageNumber
                        ? Colors.purple
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.brown,
                  width: 1,
                ),
              ),
              child: Text(
                '$pageNumber',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:
                      currentPage == pageNumber
                          ? Colors.white
                          : Colors.brown,
                ),
              ),
            ),
          );
        }),
        SizedBox(width: 2),
        IconButton(
          onPressed: () {
            _onPageChanged(++currentPage);
          },
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
