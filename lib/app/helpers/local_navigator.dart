import 'package:after_sales_service_module/app/constants/controllers.dart';
import 'package:after_sales_service_module/app/providers/auth.dart';
import 'package:after_sales_service_module/app/routing/router.dart';
import 'package:after_sales_service_module/app/routing/routes.dart';
import 'package:flutter/cupertino.dart';

Navigator localNavigator(AuthProvider auth) =>   Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: auth.userModel!.userRole == "tech"? fs2PageRoute : overviewPageRoute,
    );



