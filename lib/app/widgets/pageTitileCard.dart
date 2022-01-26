import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:flutter/material.dart';

class PageTitleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const PageTitleCard({Key? key, required this.title, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Icon(icon,color: lightGrey,),
          const SizedBox(width: 8,),
          Text(title,style: pageTitle,),
        ],
      ),
    );
  }
}
