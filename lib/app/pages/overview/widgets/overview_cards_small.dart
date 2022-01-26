import 'package:after_sales_service_module/app/constants/string_ref.dart';
import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:flutter/material.dart';
import 'info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      height: 280,
      child: Column(
        children: [
          InfoCardSmall(
            title: string_FreeService,
            value: "",
            color: darkGreen,
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: string_WarrantyRepair,
            value: "",
            color: blue,
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: string_PaidRepair,
            value: "",
            color: red,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
