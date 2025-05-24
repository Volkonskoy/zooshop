import 'package:flutter/material.dart';
import 'header.dart';
import 'footer.dart';
import 'package:provider/provider.dart';
import 'package:zooshop/orders_page.dart';
import 'package:zooshop/subscription_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'auth_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<OrdersProvider>(
          create: (_) {
            final provider = OrdersProvider();
            provider.setOrders([
              Order(state: "В обробці", quantity: 1),
              Order(state: "В обробці", quantity: 5),
              Order(state: "Доставлено"),
              Order(state: "Скасовано"),
              Order(state: "Доставлено"),
              Order(state: "Доставлено"),
              Order(state: "Скасовано", quantity: 8),

            ]);
            return provider;
          },
        ),
        ChangeNotifierProvider<SubscriptionProvider>(
          create: (_) {
            final subscriptionProvider = SubscriptionProvider();
            subscriptionProvider.loadFromDatabase([
              Subscription(product: Product(id: 1, name: 'Savory Medium Breed сухий корм для собак 3 кг - індичка та ягня', price: 365, image: Image.asset('assets/images/image.png')), periodInDays: 7),
              Subscription(product: Product(id: 2, name: 'Brit Care Mono Protein вологий корм для собак 400 г - кролик', price: 365, image: Image.asset('assets/images/image.png')), periodInDays: 7)

            ]);
            return subscriptionProvider;
          }, 
        ),
        ChangeNotifierProvider<AuthProvider>( 
          create: (_) => AuthProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zooshop',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
              children: [
                HeaderBlock(),
                SizedBox(height: 50),
                PromoVetCard(),
                SizedBox(height: 50),
                SalesBlock(),
                SizedBox(height: 130),
                PromoConsultCard(),
                SizedBox(height: 100),
                NewsBlock(),
                SizedBox(height: 50),
                BrandsBlock(),
                SizedBox(height: 70),
              ],
            ),
          ),
        ),
        FooterBlock(),  
      ],
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
      height: 400,
      decoration: BoxDecoration(
        color: Color(0xFF95C74E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
           
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Кошлатість сильно\nпідвищиться!',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Знижка 20% на всі шампуні\nдля кошенят.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 65),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC16AFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Дивитися шампуні',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 20),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 450), 
            ],
          ),
         
          Positioned(
            right: -50, 
            top: -100,
            child: SizedBox(
              width: 450,
              height: 450,
              child: Image.asset(
                'assets/images/cat.png',
                fit: BoxFit.cover,
              ),
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
      height: 400,
      decoration: BoxDecoration(
        color: Color(0xFFFF9955),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        clipBehavior: Clip.none, 
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ми готові оказати вам\nпідтримку в виборі',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Безкоштовні консультації',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 75),

                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF95C74E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Зв'язок з консультантом",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 20),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 150), 
            ],
          ),
          Positioned(
            right: -50,
            top: -100,
            width: 450,
            height: 450,
            child: Image.asset(
              'assets/images/consultant.png',
              fit: BoxFit.cover,
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
                    color: Color(0xFF95C74E),
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
                    color: Color(0xFF95C74E),
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
        borderRadius: BorderRadius.circular(4),
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
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Color(0xFFF54949),
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
          Image.asset(
            'assets/images/product.png', 
            height: 190,
            width: 190,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            'Brit Care Mono Protein вологий корм для собак 400 г - кролик',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        SizedBox(height: 75),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: 8),
                 child:Text(
                  '298 ₴',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                ),
               
                SizedBox(width: 8),
                Text(
                  '450 ₴',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity, 
            height: 35,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Товар додано до кошика',
                      style: TextStyle(color: Colors.white), 
                    ),

                    duration: Duration(seconds: 2),
                    backgroundColor: Color(0xFF95C74E),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC16AFF), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), 
                ),
              ),
              child: Text('Купити', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
            ),
          ),
         SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 10), 
            child: OneClickOrderText(),
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
        SizedBox(height: 50),
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
              _buildLogo('assets/images/royalcanin.png', true),
              _buildLogo('assets/images/whiskas.png', true),
              _buildLogo('assets/images/royalcanin.png', true),
              _buildLogo('assets/images/whiskas.png', true),
              _buildLogo('assets/images/royalcanin.png', true),
              _buildLogo('assets/images/whiskas.png', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogo(String imagePath, bool line) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ),
        if (line)
          Padding(
            padding: const EdgeInsets.only(left: 22.0), 
            child: Container(
              width: 2,
              height: 150,
              color: Color(0xFFE0E0E0),
            ),
          ),
      ],
    );
  }

}

class OneClickOrderText extends StatelessWidget {
  const OneClickOrderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '',
        children: [
          TextSpan(
            text: 'Купити за 1 клік',
            style: TextStyle(
              color: Color(0xFF95C74E),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                showDialog(
                  context: context,
                  builder: (context) => OneClickOrderDialog(),
                );
              },
          ),
        ],
      ),
    );
  }
}
class OneClickOrderDialog extends StatefulWidget {
  @override
  _OneClickOrderDialogState createState() => _OneClickOrderDialogState();
}

class _OneClickOrderDialogState extends State<OneClickOrderDialog> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

 @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 35),
              Center(
                child: Text(
                  "Для замовлення в 1 клік\nвкажіть своє ім’я та номер\nтелефону",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Ім’я',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Телефон',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final name = _nameController.text;
                    final phone = _phoneController.text;
                    print('Надіслано: $name, $phone');
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF95C74E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: Text(
                    'Надіслати',
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

}
