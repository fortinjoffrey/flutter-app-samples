import 'package:flutter/material.dart';
import 'package:flutter_app_samples/common/presentation/theme/app_widgets_constants.dart';

class AuthTextFormField extends StatelessWidget {
  const AuthTextFormField({
    Key? key,
    this.controller,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: authLoginTextFormFieldDecoration,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onChanged: onChanged,
      obscureText: obscureText,
      readOnly: readOnly,
      validator: validator,
    );
  }
}
