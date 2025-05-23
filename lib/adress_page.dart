import 'package:flutter/material.dart';
import 'package:zooshop/account_layout.dart';
import 'package:zooshop/new_address_page.dart';


class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<AddressForm> addresses = [AddressForm(), AddressForm()];

  @override
  Widget build(BuildContext context) {
    return AccountLayout(
      activeMenu: 'Адреса доставки',
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            ...addresses.asMap().entries.map((entry) {
              int index = entry.key;
              AddressForm form = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Адреса ${index + 1}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        TextButton.icon(
                          onPressed: () {
                            _confirmDelete(index);
                          },
                          icon: Icon(Icons.delete, color: Color(0xFFF54949)),
                          label: Text('Видалити', style: TextStyle(color: Color(0xFFF54949))),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),

                    DropdownButtonFormField<String>(
                      value: form.city,
                      items: ['Харків', 'Київ', 'Львів']
                          .map((city) => DropdownMenuItem(
                                value: city,
                                child: Text(city),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          form.city = val!;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Місто', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      initialValue: form.address,
                      onChanged: (val) => form.address = val,
                      decoration: InputDecoration(labelText: 'Адреса', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),),
                    ),
                  ],
                ),
              );
            }).toList(),
            SizedBox( 
              width: 238,
              height: 40,
              child: ElevatedButton(
              onPressed: () async {
                final newAddress = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NewAddressPage()),
                );

                if (newAddress != null) {
                  setState(() {
                    addresses.add(AddressForm()
                      ..city = newAddress['city']
                      ..address = newAddress['address']);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC16AFF),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
              child: Text('Додати нову адресу', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
            ),
            ),
           
          ],
          
        ),
      ),
    );
  }

void _confirmDelete(int index) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 460,
        height: 179,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                'Ви впевнені, що бажаєте\nвидалити адресу?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF512A09),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24, left: 94),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 131,
                    height: 40,
                    child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Color(0xFF67AF45),
                            side: BorderSide(color: Color(0xFF67AF45)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 0), 
                          ),
                          child: Text(
                            'Скасувати',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                            
                          ),
                        ),
                  ),
                  SizedBox(width: 15),
                  SizedBox(
                    width: 131,
                    height: 40,
                    child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              addresses.removeAt(index);
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF74E4E),
                            foregroundColor: Color(0xFFFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 0),
                          ),
                          child: Text(
                            'Видалити',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),

                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

}

class AddressForm {
  String city = 'Харків';
  String address = '';
}

