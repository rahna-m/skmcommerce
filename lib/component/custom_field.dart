import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool? isRequired;
  final TextEditingController? controller;
   final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText,
    this.isRequired = true,
    this.controller,
      this.validator,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();
      final _formKey = GlobalKey<FormFieldState<String>>();

      void _validateOnChange(String value) {
    if (_formKey.currentState != null) {
      _formKey.currentState!.validate();
    }
  }

    

    @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (widget.isRequired!)
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
        // SizedBox(
        //   height: 50,
        //   child: 
          TextFormField(
            controller: widget.controller,
              validator: widget.validator,
          onChanged: _validateOnChange,
                focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: widget.hintText,
             
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
               
              ),
            ),
           
          ),
        // ),
      ],
    );
  }
}
