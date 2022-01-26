import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppProvider with ChangeNotifier {
  bool isLoading = false;
  bool showpassword = false;
  bool isAlertShowing = false;

  changeLoading() {
    isLoading = isLoading ? false : true;
    notifyListeners();
  }

  changeShowPassword() {
    showpassword = showpassword ? false : true;
    notifyListeners();
  }
}
