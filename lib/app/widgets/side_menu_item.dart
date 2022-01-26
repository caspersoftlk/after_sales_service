import 'package:flutter/material.dart';
import 'package:after_sales_service_module/app/helpers/reponsiveness.dart';
import 'package:after_sales_service_module/app/widgets/horizontal_menu_item.dart';
import 'package:after_sales_service_module/app/widgets/vertical_menu_item.dart';


class SideMenuItem extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;

  const SideMenuItem({ Key? key,required this.itemName,required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(ResponsiveWidget.isCustomSize(context)){
      return VertticalMenuItem(itemName: itemName, onTap: onTap,);
    }else{
      return HorizontalMenuItem(itemName: itemName, onTap: onTap,);
    }
  }
}