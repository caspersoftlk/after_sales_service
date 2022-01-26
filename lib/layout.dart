import 'package:flutter/material.dart';
import 'package:after_sales_service_module/app/helpers/local_navigator.dart';
import 'package:after_sales_service_module/app/helpers/reponsiveness.dart';
import 'package:after_sales_service_module/app/widgets/large_screen.dart';
import 'package:after_sales_service_module/app/widgets/side_menu.dart';
import 'package:provider/provider.dart';

import 'app/providers/auth.dart';
import 'app/widgets/top_nav.dart';



class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of(context);
    return Scaffold(
      key: scaffoldKey,
      appBar:  topNavigationBar(context, scaffoldKey,auth.userModel!.lName),
      drawer: const Drawer(
        child: SideMenu(),
      ),
      body: ResponsiveWidget(
        largeScreen: const LargeScreen(),
      smallScreen: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: localNavigator(auth),
      )
      ),
    );
  }
}
