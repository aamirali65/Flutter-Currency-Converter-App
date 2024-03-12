import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final Widget? suffix;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.suffix
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: suffix,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(
            color: Colors.red
        )),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey
          )
        ),
        enabledBorder: const OutlineInputBorder( borderSide: BorderSide(
            color: Colors.grey
        )),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide(
          color: Colors.red
        ))
      ),
    );
  }
}
