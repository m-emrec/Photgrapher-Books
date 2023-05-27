import 'package:flutter/material.dart';
import 'package:photo_book/logger.dart';

class InputField extends StatefulWidget {
  InputField({
    super.key,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.validatorFunc,
    this.isPassword = false,
    required this.controller,
    this.inputAction = TextInputAction.none,
  });

  final String label;
  final TextInputType keyboardType;
  final Function? validatorFunc;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputAction inputAction;
  bool showPassword = false;
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  Widget _showPassword() {
    return GestureDetector(
      onTap: () => setState(() {
        widget.showPassword = !widget.showPassword;
      }),
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        width: 32,
        height: 24,
        child: Icon(
          widget.showPassword ? Icons.lock_outline : Icons.lock_open_outlined,
          color: Colors.grey,
          size: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validatorFunc == null
          ? null
          : (value) => widget.validatorFunc!(value),
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && !widget.showPassword,
      decoration: InputDecoration(
        label: Text(
          widget.label,
        ),
        suffix: widget.isPassword ? _showPassword() : null,
      ),
      textInputAction: widget.inputAction,
    );
  }
}
