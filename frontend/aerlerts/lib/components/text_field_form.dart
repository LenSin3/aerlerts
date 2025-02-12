import 'package:flutter/material.dart';

class TextFieldForm extends StatelessWidget {
  const TextFieldForm({this.onChanged, this.decoration, this.validator});

  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    bool isPasswordField =
        (decoration!.hintText?.toLowerCase().contains('password') ?? false) ||
            (decoration!.labelText?.toLowerCase().contains('password') ??
                false);

    bool isEmailField =
        (decoration!.hintText?.toLowerCase().contains('email') ?? false) ||
            (decoration!.labelText?.toLowerCase().contains('email') ?? false);
    return TextFormField(
      textAlign: TextAlign.center,
      keyboardType: isEmailField ? TextInputType.emailAddress : null,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decoration,
      onChanged: (value) {},
      obscureText: isPasswordField,
      validator: validator,
    );
  }
}
