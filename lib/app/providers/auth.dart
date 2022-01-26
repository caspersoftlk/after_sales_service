// ignore_for_file: constant_identifier_names
import 'package:after_sales_service_module/app/constants/controllers.dart';
import 'package:after_sales_service_module/app/constants/server.dart';
import 'package:after_sales_service_module/app/models/response.dart';
import 'package:after_sales_service_module/app/models/user.dart';
import 'package:after_sales_service_module/app/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
}

class AuthProvider with ChangeNotifier {
  late UserModal? _userModal;
  late DateTime _mainDate = DateTime.now();
  late DateTime _mainTime = DateTime(2021,1,1,18,59);
  Status _status = Status.Uninitialized;
  UserModal? get userModel => _userModal;
  Status get status => _status;
  DateTime get mainDate => _mainDate;
  DateTime get mainTime => _mainTime;

  late bool _refresh = false;
  bool get refresh => _refresh;

  void setRefresh(bool s) {
    _refresh = s;
    notifyListeners();
  }

  void setStatus(Status s) {
    _status = s;
    notifyListeners();
  }

  void setMainDate(DateTime s) {
    _mainDate = s;
    notifyListeners();
  }

  void setMainTime(DateTime s) {
    _mainTime = s;
    notifyListeners();
  }

  AuthProvider.init() {
    Get.put(APIControllerServices());
    apiSetUp();
  }

  void apiSetUp() {
    defInitializeUserModel();
  }

  Future<String?> login(
      {required String userName, required String password}) async {
    try {
      UserModal user = UserModal(uid: 0, userName: userName, password: password, fName: "fName", lName: "lName", userRole: "0", userRoleName: "userRoleName",locationID: "",locationName: "",permitedMenus: []);
      var res = await apiService.send(user.toMap(),LOGIN_URL);
      if (res!.statusCode == 200) {
        K_Response response = K_Response.fromJson(res.body);

        if(response.rescode == 0){
          _userModal = UserModal.fromMap(response.data);
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("userName", userName);
          preferences.setString("pass", password);
          return "valid";
        }
       else {
          return response.message;
        }
      } else {
        return "Server side Error";
      }
    } catch (e) {
      e.printError();
      return "Error login : " + e.toString();
    }
  }

  Future<String?> newUser(
      {required String userName, required String password, required String fName, required String lName, required String userRole, required String link}) async {
    try {
      UserModal user = UserModal(uid: 0, userName: userName, password: password, fName: fName, lName: lName, userRole: userRole, userRoleName: "userRoleName",locationID: "",locationName: "",permitedMenus: []);
      var res = await apiService.send(user.toMap(),link);
      if (res!.statusCode == 200) {
        K_Response response = K_Response.fromJson(res.body);

        if(response.rescode == 0){
          return "valid";
        }
        else {
          return response.message;
        }
      } else {
        return "Server side Error";
      }
    } catch (e) {
      e.printError();
      return "Error login : " + e.toString();
    }
  }

  Future<String?> deleteUser(
      {required String userName}) async {
    try {
      UserModal user = UserModal(uid: 0, userName: userName, password: "password", fName: "fName", lName: "lName", userRole: "1", userRoleName: "userRoleName",locationID: "",locationName: "",permitedMenus: []);
      var res = await apiService.send(user.toMap(),GET_DELETE_USER_URL);
      if (res!.statusCode == 200) {
        K_Response response = K_Response.fromJson(res.body);

        if(response.rescode == 0){
          return "valid";
        }
        else {
          return response.message;
        }
      } else {
        return "Server side Error";
      }
    } catch (e) {
      e.printError();
      return "Error login : " + e.toString();
    }
  }

  Future<String?> updateUser(
      {required String userName, required String password, required String fName, required String lName, required String userRole}) async {
    try {
      UserModal user = UserModal(uid: 0, userName: userName, password: password, fName: fName, lName: lName, userRole: userRole, userRoleName: "userRoleName",locationID: "",locationName: "",permitedMenus: []);
      var res = await apiService.send(user.toMap(),GET_NEW_USER_URL);
      if (res!.statusCode == 200) {
        K_Response response = K_Response.fromJson(res.body);

        if(response.rescode == 0){
          return "valid";
        }
        else {
          return response.message;
        }
      } else {
        return "Server side Error";
      }
    } catch (e) {
      e.printError();
      return "Error login : " + e.toString();
    }
  }

  Future<bool> defInitializeUserModel() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? _userId = preferences.getString('uid');
    String? pass = preferences.getString('pass');

    if (_userId == null) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }

    String? res = await login(userName: _userId, password: pass!);
    res.printInfo();
    if (res == "Valid User") {
      setStatus(
          Status.Authenticated);
    }else{
      preferences.remove("uid");
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
    return true;
  }

  Future signOut() async {
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

}
