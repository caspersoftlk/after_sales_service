import 'package:after_sales_service_module/app/helpers/local_navigator.dart';
import 'package:after_sales_service_module/app/providers/auth.dart';
import 'package:after_sales_service_module/app/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LargeScreen extends StatelessWidget {
  const LargeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider provider = Provider.of(context);
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                  child: SideMenu()),
              Expanded(
                  flex: 5,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: localNavigator(provider),
                  ))
            ],
          );
  }
}