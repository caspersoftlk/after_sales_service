import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/widgets/pageTitileCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RunningJobList extends StatelessWidget {
  const RunningJobList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        PageTitleCard(title: "Active Jobs", icon: Icons.assignment_outlined),

      ]
    );
  }
}
