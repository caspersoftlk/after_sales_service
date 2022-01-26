import 'package:flutter/material.dart';
import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/controllers/menu_controller.dart';
import 'package:after_sales_service_module/app/controllers/navigation_controller.dart';

import 'package:after_sales_service_module/app/pages/404/error.dart';
import 'package:after_sales_service_module/app/pages/authentication/authentication.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'app/controllers/app_screen_controller.dart';
import 'app/providers/app.dart';
import 'app/providers/auth.dart';
import 'app/routing/routes.dart';
import 'layout.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthProvider.init());
  Get.put(AppProvider());
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(MultiProvider(providers: [ChangeNotifierProvider.value(value: AppProvider()),
    ChangeNotifierProvider.value(value: AuthProvider.init()),],
  child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme).apply(
            bodyColor: Colors.black
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            }
        ),
        primarySwatch: Colors.blue,
      ),
      unknownRoute: GetPage(name: '/not-found', page: () => const PageNotFound(), transition: Transition.fadeIn),
      home: const AppScreenController(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//      // initialRoute: authenticationPageRoute,
//       unknownRoute: GetPage(name: '/not-found', page: () => PageNotFound(), transition: Transition.fadeIn),
//       getPages: [
//         GetPage(name: rootRoute, page: () {
//           return SiteLayout();
//         }),
//         GetPage(name: authenticationPageRoute, page: () => AuthenticationPage()),
//       ],
//       debugShowCheckedModeBanner: false,
//       title: 'Dashboard',
//       theme: ThemeData(
//         scaffoldBackgroundColor: light,
//         textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme).apply(
//             bodyColor: Colors.black
//         ),
//         pageTransitionsTheme: const PageTransitionsTheme(
//             builders: {
//               TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
//               TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
//             }
//         ),
//         primarySwatch: Colors.blue,
//       ),
//       // home: AuthenticationPage(),
//     );
//   }

