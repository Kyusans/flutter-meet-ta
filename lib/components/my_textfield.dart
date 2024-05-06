import 'package:flutter/material.dart';

class MyTextfield extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool? isAutoFocus;
  final bool? isObscure;
  final bool? onlyNumber;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final int? maxLength;

  const MyTextfield({
    Key? key,
    required this.labelText,
    required this.controller,
    this.isAutoFocus,
    this.isObscure,
    this.onlyNumber,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
  }) : super(key: key);

  @override
  _MyTextfieldState createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscure ?? false;
  }

  void _handleObscureSwitch() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.isAutoFocus ?? false,
      obscureText: _obscureText,
      controller: widget.controller,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: widget.labelText,
        suffixIcon: widget.suffixIcon != null
            ? Icon(widget.suffixIcon)
            : widget.isObscure == true
                ? IconButton(
                    onPressed: () {
                      _handleObscureSwitch();
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  )
                : null,
        prefix: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
