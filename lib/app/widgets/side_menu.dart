import 'package:after_sales_service_module/app/constants/controllers.dart';
import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/helpers/reponsiveness.dart';
import 'package:after_sales_service_module/app/pages/authentication/authentication.dart';
import 'package:after_sales_service_module/app/pages/job/job_overview.dart';
import 'package:after_sales_service_module/app/providers/auth.dart';
import 'package:after_sales_service_module/app/routing/routes.dart';
import 'package:after_sales_service_module/app/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'custom_text.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    AuthProvider auth = Provider.of(context);

    return Container(
      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: _width / 48),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset(
                        "assets/icons/logo.png",
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "Dash",
                        size: 20,
                        weight: FontWeight.bold,
                        color: active,
                      ),
                    ),
                    SizedBox(width: _width / 48),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: getSideMenuItem(auth.userModel!.permitedMenus)
                .map((item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (item.route == authenticationPageRoute) {
                        auth.setStatus(Status.Unauthenticated);
                      }
                      if (!menuController.isActive(item.name)) {
                        menuController.changeActiveItemTo(item.name);
                        if (ResponsiveWidget.isSmallScreen(context)) {
                          Get.back();
                        }
                        navigationController.navigateTo(item.route);
                      }
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
