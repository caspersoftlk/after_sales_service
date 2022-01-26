import 'package:after_sales_service_module/app/pages/authentication/authentication.dart';
import 'package:after_sales_service_module/app/pages/extra_screens/loading.dart';
import 'package:after_sales_service_module/app/providers/auth.dart';
import 'package:after_sales_service_module/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppScreenController extends StatelessWidget {
  const AppScreenController({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    try {

      switch (authProvider.status) {
        case Status.Uninitialized:
          return const Loading();
        case Status.Authenticated:
          return SiteLayout();
        case Status.Unauthenticated:
        case Status.Authenticating:
          return AuthenticationPage();
        default:
          return AuthenticationPage();
      }
    } catch (e) {
      return const Loading();
    }
    // if (authProvider.status == Status.Unauthenticated ||
    //     authProvider.status == Status.Authenticating)
    //   return AuthenticationPage(child: LoginWithEmailAndPassword());
    // else
    //   return AuthenticationPage(child: SignUpWithEmailAndPassword());
  }
}
