import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  const PasswordField({Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  var _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(),

        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible
                ? Icons.visibility_off
                : Icons.visibility,
            // color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }
}