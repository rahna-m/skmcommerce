import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';

class CustomPasswordTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isRequired;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomPasswordTextField({
    Key? key,
    required this.label,
    required this.hintText,
    this.isRequired = false,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomPasswordTextField> createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isObscured = true;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (widget.isRequired)
              Text(
                "* ",
                style: TextStyle(color: Colors.red),
              ),
            Text(
              widget.label,
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscured ? Remix.eye_off_line : Remix.eye_line,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          obscureText: _isObscured,
        ),
      ],
    );
  }
}
