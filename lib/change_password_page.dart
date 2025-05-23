import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/account_layout.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      // Здесь логика смены пароля (например, API вызов)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пароль успішно змінено')),
      );
      newPasswordController.clear();
      confirmPasswordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AccountLayout(
      activeMenu: 'Змінити пароль',
      child: Container(
        width: 365,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Новий пароль", 
              style: TextStyle(color: Color(0xFF848992),
              fontSize: 12
              )),
              SizedBox(height: 8),

              TextFormField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "••••••••••",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введіть новий пароль';
                  if (value.length < 6) return 'Пароль має містити щонайменше 6 символів';
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text("Повторіть пароль", 
              style: TextStyle(color: Color(0xFF848992),
              fontSize: 12
              )),
              SizedBox(height: 8),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "••••••••••",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                validator: (value) {
                  if (value != newPasswordController.text) return 'Паролі не співпадають';
                  return null;
                },
              ),
              SizedBox(height: 24),
              SizedBox(
                width: 201,
                height: 40,
                child: ElevatedButton(
                  onPressed: _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC16AFF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Text(
                    'Змінити пароль',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
