import 'package:after_sales_service_module/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  get green => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(text: 'Loading..'),
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: const EdgeInsets.all(16),
                  child: const LinearProgressIndicator())
            ],
          ),
        ));
  }
}
