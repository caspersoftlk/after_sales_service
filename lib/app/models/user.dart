import 'dart:convert';

import 'package:after_sales_service_module/app/models/permited_menu.dart';

class UserModal{

  final int uid;
  final String userName;
  final String password;
  final String fName;
  final String lName;
  final String userRole;
  final String userRoleName;
  final String locationID;
  final String locationName;
  final List<dynamic> permitedMenus;


  String toJson() => json.encode(toMap());

  factory UserModal.fromJson(String source) =>
      UserModal.fromMap(json.decode(source));

//<editor-fold desc="Data Methods">

  const UserModal({
    required this.uid,
    required this.userName,
    required this.password,
    required this.fName,
    required this.lName,
    required this.userRole,
    required this.userRoleName,
    required this.locationID,
    required this.locationName,
    required this.permitedMenus,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModal &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          userName == other.userName &&
          password == other.password &&
          fName == other.fName &&
          lName == other.lName &&
          userRole == other.userRole &&
          userRoleName == other.userRoleName &&
          locationID == other.locationID &&
          locationName == other.locationName &&
          permitedMenus == other.permitedMenus);

  @override
  int get hashCode =>
      uid.hashCode ^
      userName.hashCode ^
      password.hashCode ^
      fName.hashCode ^
      lName.hashCode ^
      userRole.hashCode ^
      userRoleName.hashCode ^
      locationID.hashCode ^
      locationName.hashCode ^
      permitedMenus.hashCode;

  @override
  String toString() {
    return 'UserModal{' +
        ' uid: $uid,' +
        ' userName: $userName,' +
        ' password: $password,' +
        ' fName: $fName,' +
        ' lName: $lName,' +
        ' userRole: $userRole,' +
        ' userRoleName: $userRoleName,' +
        ' locationID: $locationID,' +
        ' locationName: $locationName,' +
        ' permitedMenus: $permitedMenus,' +
        '}';
  }

  UserModal copyWith({
    int? uid,
    String? userName,
    String? password,
    String? fName,
    String? lName,
    String? userRole,
    String? userRoleName,
    String? locationID,
    String? locationName,
    List<String>? permitedMenus,
  }) {
    return UserModal(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      fName: fName ?? this.fName,
      lName: lName ?? this.lName,
      userRole: userRole ?? this.userRole,
      userRoleName: userRoleName ?? this.userRoleName,
      locationID: locationID ?? this.locationID,
      locationName: locationName ?? this.locationName,
      permitedMenus: permitedMenus ?? this.permitedMenus,
    );
  }

  Map<String, String> toMap() {
    return {
      'uid': this.uid.toString(),
      'userName': this.userName,
      'password': this.password,
      'fName': this.fName,
      'lName': this.lName,
      'userRole': this.userRole,
      'userRoleName': this.userRoleName,
      'locationID': this.locationID,
      'locationName': this.locationName,
      'permitedMenus': this.permitedMenus.toString(),
    };
  }

  factory UserModal.fromMap(Map<String, dynamic> map) {
    return UserModal(
      uid: map['uid'] as int,
      userName: map['userName'] as String,
      password: map['password'] as String,
      fName: map['fName'] as String,
      lName: map['lName'] as String,
      userRole: map['userRole'] as String,
      userRoleName: map['userRoleName'] as String,
      locationID: map['locationID'] as String,
      locationName: map['locationName'] as String,
      permitedMenus: map['permitedMenus'] as List<dynamic>,
    );
  }

//</editor-fold>
}