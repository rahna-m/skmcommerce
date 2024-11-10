import 'package:flutter/material.dart';
import 'package:skmecom/utils/constants.dart';


class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const CustomButton({super.key, required this.title,  this.onPressed,});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primarycolor.withOpacity(0.78), 
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
       
       onPressed: onPressed,
      
    child: Text(title, 
    style: const TextStyle(color: Colors.white),));
  }
}