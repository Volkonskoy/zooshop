import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/pages/account_layout.dart';

class NewAddressPage extends StatefulWidget {
  @override
  _NewAddressPageState createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  String city = 'Харків';
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AccountLayout(
      activeMenu: "Адреса доставки",
      child: Container(
        width: 365, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black),
              label: Text(
                'Назад',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Нова адреса',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32),
            DropdownButtonFormField<String>(
              value: city,
              items: ['Харків', 'Київ', 'Львів']
                  .map((city) => DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  city = val!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Місто',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Адреса',
                hintText: 'Вулиця, номер дому, квартира',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: 140,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'city': city,
                    'address': addressController.text,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFC16AFF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                child: Text(
                  'Зберегти',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
