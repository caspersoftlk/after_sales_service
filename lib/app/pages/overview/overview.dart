import 'package:after_sales_service_module/app/pages/job/widgets/running_jobs.dart';
import 'package:flutter/material.dart';
import 'package:after_sales_service_module/app/helpers/reponsiveness.dart';
import 'package:after_sales_service_module/app/constants/controllers.dart';
import 'package:after_sales_service_module/app/pages/overview/widgets/available_drivers_table.dart';
import 'package:after_sales_service_module/app/pages/overview/widgets/overview_cards_large.dart';
import 'package:after_sales_service_module/app/pages/overview/widgets/overview_cards_medium.dart';
import 'package:after_sales_service_module/app/pages/overview/widgets/overview_cards_small.dart';
import 'package:after_sales_service_module/app/pages/overview/widgets/revenue_section_large.dart';
import 'package:after_sales_service_module/app/widgets/custom_text.dart';
import 'package:get/get.dart';

import 'widgets/revenue_section_small.dart';

class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Expanded(
            child: ListView(
          children: [
            if (ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context))
              if (ResponsiveWidget.isCustomSize(context))
                OverviewCardsMediumScreen()
              else
                OverviewCardsLargeScreen()
            else
              OverviewCardsSmallScreen(),
            SizedBox(height: 14,),
            RunningJobList()
          ],
        ))
      ],
    );
  }
}
