import 'package:flutter/material.dart';

class AppRadioButton extends StatefulWidget {
  const AppRadioButton({super.key, required this.onChange});
  final Function(bool?) onChange;

  @override
  State<AppRadioButton> createState() => _AppRadioButtonState();
}

class _AppRadioButtonState extends State<AppRadioButton> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), value: isChecked, onChanged: (value) => setState(() {
      isChecked = !isChecked;
      widget.onChange.call(value);
    }));
  }
}
