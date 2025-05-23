import 'package:flutter/material.dart';
import 'package:zooshop/account_layout.dart';
import 'package:zooshop/cart_page.dart';
import 'package:zooshop/order_placing_page.dart';


class AccountPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController(text: 'Константин');
  final TextEditingController surnameController = TextEditingController(text: 'Онищенко');
  final TextEditingController phoneController = TextEditingController(text: '+380991032345');
  final TextEditingController emailController = TextEditingController(text: 'myname@gmail.com');

    @override
  Widget build(BuildContext context) {
   
    return AccountLayout(
      activeMenu: 'Обліковий запис',
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
   
            _labeledField('Ім’я', nameController),
            _labeledField('Прізвище', surnameController),
            _labeledField('Телефон', phoneController),
            _labeledField('E-mail', emailController),
            SizedBox(height: 20),
            SizedBox( 
              width: 140,
              height: 40,
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(140, 40),
                  backgroundColor: const Color(0xFFC16AFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), 
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Зберегти',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _labeledField(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14)),
        SizedBox(height: 6),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),  
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Color(0xFFC16AFF)),
            ),
          ),
        ),
      ],
    ),
  );
}

}
