import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderPlacingPage extends StatefulWidget {
  @override
  _OrderPlacingPageState createState() => _OrderPlacingPageState();
}

class _OrderPlacingPageState extends State<OrderPlacingPage> {
  String selectedDelivery = 'courier';
  String selectedPayment = 'cash';
  bool agreedToTerms = true;

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final commentController = TextEditingController();

  final Map<String, String> addressOptions = {
  'address1': 'вул. Полтавський шлях 6 А',
  'address2': 'вул. Лесі Українки 12',
  'address3': 'проспект Перемоги 101',
};

  String selectedAddress = 'address1';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 140, vertical: 50),
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Оформлення замовлення",
              style: GoogleFonts.montserrat(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF95C74E),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle('Покупець'),
                        _buildInput('Ім’я', controller: nameController),
                        _buildInput('Прізвище', controller: surnameController),
                        _buildInput('Email', controller: emailController),
                        SizedBox(height: 30),
                        _sectionTitle('Адреса доставки'),
                        DropdownButtonFormField<String>(
                          value: selectedAddress,
                          items: addressOptions.entries.map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedAddress = val!;
                            });
                          },
                        ),

                        SizedBox(height: 30),
                        _sectionTitle('Коментар до замовлення'),
                        _buildCommentField(),
                      ],
                    ),
                  ),

                  SizedBox(width: 50),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle('Спосіб доставки'),
                        _buildRadioOption('Доставка кур’єром\nпо м. Київ, от 500 грн - безкоштовно', 'courier'),
                        _buildRadioOption('Самовивіз\nвул. Полтавський шлях 6 А - магазин зоотоварів "Пухнастик"', 'pickup'),
                        _buildRadioOption('Нова Пошта\nвід 500 грн (за передплатою) - безкоштовно', 'nova'),

                        SizedBox(height: 30),
                        _sectionTitle('Спосіб оплати'),
                        DropdownButtonFormField<String>(
                            value: selectedPayment,
                            items: [
                              DropdownMenuItem(
                                value: 'cash',
                                child: Text('Готівкою при отриманні'),
                              ),
                              DropdownMenuItem(
                                value: 'card',
                                child: Text('Оплата картою'),
                              ),
                            ],
                            onChanged: (val) {
                              setState(() {
                                selectedPayment = val!;
                              });
                            },
                          ),

                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Сума замовлення: ',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '6890 ₴',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF67AF45),
                  ),
                ),
                Spacer(),
                Checkbox(
                  value: agreedToTerms,
                  onChanged: (val) => setState(() => agreedToTerms = val!),
                  activeColor: Color(0xFFB460DC),
                ),
                Text('Я прочитав та згоден з '),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Умовами згоди',
                    style: TextStyle(color: Color(0xFFB460DC)),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: agreedToTerms ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB460DC),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: Text(
                    'Підтвердити замовлення',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildInput(String label, {required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  Widget _buildCommentField() {
    return TextField(
      controller: commentController,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Коментар',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }

  Widget _buildRadioOption(String text, String value) {
    return RadioListTile<String>(
      value: value,
      groupValue: selectedDelivery,
      onChanged: (val) => setState(() => selectedDelivery = val!),
      title: Text(text),
      contentPadding: EdgeInsets.zero,
    );
  }
}
