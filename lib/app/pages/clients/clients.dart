import 'package:after_sales_service_module/app/constants/controllers.dart';
import 'package:after_sales_service_module/app/helpers/reponsiveness.dart';
import 'package:after_sales_service_module/app/pages/clients/widgets/clients_table.dart';
import 'package:after_sales_service_module/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
         return Container(
                child: Column(
                children: [
                 Obx(() => Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:
                        ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                        child: CustomText(text: menuController.activeItem.value, size: 24, weight: FontWeight.bold,)),
                    ],
                  ),),

                  Expanded(child: ListView(
                    children: const [
                      ClientsTable(),
                    ],
                  )),

                  ],
                ),
              );
  }
}