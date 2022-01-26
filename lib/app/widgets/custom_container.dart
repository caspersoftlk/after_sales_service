import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final List<Widget> children;

  const CustomContainer({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children));
  }
}

class CustomContainerWrap extends StatelessWidget {
  final List<Widget> children;

  const CustomContainerWrap({Key? key, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Wrap(children: children));
  }
}
