import 'package:flutter/material.dart';
import 'package:macro/widgets/password_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<StatefulWidget> {
  final _userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            children: [
              Image.asset('assets/images/food2.jpg'),

              Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(

                    decoration: InputDecoration(
                      labelText: 'Usuário',
                      border: OutlineInputBorder(),
                    ),
                  ),
              ),

              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: PasswordField(
                    controller: _userPasswordController,
                    labelText: 'Senhax',
                  ),
              ),

              TextButton(
                  onPressed: () {},
                  child: Text('Esqueci a senha')
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Entrar'),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('Criar uma conta'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
