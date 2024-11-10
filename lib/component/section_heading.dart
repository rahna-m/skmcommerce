import 'package:flutter/material.dart';
import 'package:skmecom/utils/constants.dart';

class SectionHeading extends StatelessWidget {
  final String title;

  const SectionHeading({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              color: AppColors.primarycolor,
              thickness: 1,
              indent: 90,
              endIndent: 25, // Adds spacing between divider and text
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 2.5,
              color: Colors.black.withOpacity(0.68),
            ),
          ),
          const Expanded(
            child: Divider(
              color: AppColors.primarycolor,
              thickness: 1,
              indent: 25, // Adds spacing between divider and text
              endIndent: 90,
            ),
          ),
        ],
      ),
    );
  }
}
