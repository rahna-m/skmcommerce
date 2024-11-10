// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:skmecom/utils/constants.dart';



class CommonHeader extends StatelessWidget {
  final String title;
  const CommonHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.primarycolor,
            thickness: 1,
            indent: 60,
            endIndent: 25, // Adds spacing between divider and text
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: titleFontSize - 5,
            letterSpacing: 2.5,
            color: AppColors.textcolor,
          ),
        ),
        const Expanded(
          child: Divider(
            color: AppColors.primarycolor,
            thickness: 1,
            indent: 25, // Adds spacing between divider and text
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
