import 'package:flutter/material.dart';
import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/widgets/custom_text.dart';

class InfoCardSmall extends StatelessWidget {
  final String title;
  final String value;
  final Color? color;
  final VoidCallback onTap;

  const InfoCardSmall(
      {Key? key,
      required this.title,
      required this.value,
      this.color,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: color ?? lightGrey, width: .5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: title,
                  size: 24,
                  weight: FontWeight.w300,
                  color: dark,
                ),
                CustomText(
                  text: value,
                  size: 24,
                  weight: FontWeight.w300,
                  color: lightGrey,
                )
              ],
            )),
      ),
    );
  }
}
