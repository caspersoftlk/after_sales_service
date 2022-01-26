import 'package:after_sales_service_module/app/pages/job/inquiry/inquiry.dart';
import 'package:after_sales_service_module/app/pages/job/job_overview.dart';
import 'package:after_sales_service_module/app/pages/job/repair/repair_note.dart';
import 'package:after_sales_service_module/app/pages/job/ticket/free_service_overview.dart';
import 'package:after_sales_service_module/app/pages/overview/overview.dart';
import 'package:after_sales_service_module/app/pages/technician/accept_tickets/accept_tickets.dart';
import 'package:after_sales_service_module/app/pages/users/user_layout.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverviewPage());
    case userManagementPageRoute:
      return _getPageRoute(UserManagement());
    case wrPageRoute:
      return _getPageRoute(WarrantyRepair());
    case fs2PageRoute:
      return _getPageRoute(AcceptTickets());
    case jobPageRoute:
      return _getPageRoute(JobOverview());
    case fsPageRoute:
      return _getPageRoute(FreeServiceOverView());
    case repairNotePageRoute:
      return _getPageRoute(RepairNote());
    default:
      return _getPageRoute(OverviewPage());

  }
}

PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}