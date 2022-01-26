import 'package:after_sales_service_module/app/constants/string_ref.dart';
import 'package:flutter/material.dart';
import 'package:after_sales_service_module/app/pages/overview/widgets/info_card.dart';


class OverviewCardsLargeScreen extends StatelessWidget {
  const OverviewCardsLargeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;

    return  Row(
              children: [
                InfoCard(
                  title: string_FreeService,
                  value: string_FreeService_des,
                  onTap: () {},
                  topColor: Colors.orange,
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: string_WarrantyRepair,
                  value: string_WarrantyRepair_des,
                  topColor: Colors.lightGreen,
                  onTap: () {},
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: string_PaidRepair,
                  value: string_PaidRepair_des,
                  topColor: Colors.redAccent,
                  onTap: () {},
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "12",
                  value: "Running Jobs",
                  onTap: () {},
                ),
              ],
            );
  }
}