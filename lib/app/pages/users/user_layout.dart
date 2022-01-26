import 'package:after_sales_service_module/app/constants/controllers.dart';
import 'package:after_sales_service_module/app/constants/server.dart';
import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/models/response.dart';
import 'package:after_sales_service_module/app/models/typex.dart';
import 'package:after_sales_service_module/app/models/user.dart';
import 'package:after_sales_service_module/app/pages/users/widgets/card.dart';
import 'package:after_sales_service_module/app/providers/auth.dart';
import 'package:after_sales_service_module/app/widgets/custom_text.dart';
import 'package:after_sales_service_module/app/widgets/custome_icon_button.dart';
import 'package:after_sales_service_module/app/widgets/input_field.dart';
import 'package:after_sales_service_module/app/widgets/pageTitileCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({Key? key}) : super(key: key);

  @override
  _UserManagementState createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  final _userName = TextEditingController().obs;
  final _fName = TextEditingController().obs;
  final _lName = TextEditingController().obs;
  final _password = TextEditingController().obs;
  final _searchController = TextEditingController().obs;

  final selectedRole =
      const Typex(id: -1, name: "", description: "Select Role").obs;

  var isLoading = false.obs;
  var userListBuilder;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of(context);
    userListBuilder = getUserList(auth);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageTitleCard(title: "User Management", icon: Icons.person),
        Expanded(
            child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => MyInputField(
                        controller: _userName.value,
                        hint: "Enter User Name",
                        title: "User Name",
                      )),
                  Row(
                    children: [
                      Expanded(
                          child: Obx(
                        () => MyInputField(
                          controller: _fName.value,
                          hint: "Enter First Name",
                          title: "First Name",
                        ),
                      )),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Obx(
                        () => MyInputField(
                          controller: _lName.value,
                          hint: "Enter Last Name",
                          title: "Last Name",
                        ),
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() => MyInputField(
                              controller: _password.value,
                              hint: "Enter Password",
                              title: "Password",
                            )),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: FutureBuilder<K_Response?>(
                          future: apiService.receive(
                              K_Response(message: "", data: "").toMap(),
                              GET_USER_ROLE_URL),
                          // a previously-obtained Future<String> or null
                          builder: (BuildContext context,
                              AsyncSnapshot<K_Response?> snapshot) {
                            List<Widget> children;
                            if (snapshot.hasData) {
                              List<dynamic> dynamicList = snapshot.data!.data;

                              children = <Widget>[
                                Obx(() => MyInputField(
                                      title: "User Role",
                                      widget: DropdownButton(
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey),
                                        iconSize: 32,
                                        elevation: 4,
                                        style: subTitleStyle,
                                        underline: Container(
                                          height: 0,
                                        ),
                                        onChanged: (dynamic newValue) {
                                          Typex val = newValue;
                                          selectedRole.value = val;
                                        },
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        items: dynamicList
                                            .map<DropdownMenuItem<dynamic>>(
                                                (dynamic value) {
                                          return DropdownMenuItem<dynamic>(
                                            value: Typex.fromMap(value),
                                            child: Text(Typex.fromMap(value)
                                                .description),
                                          );
                                        }).toList(),
                                      ),
                                      hint: selectedRole.value.description,
                                    ))
                              ];
                            } else if (snapshot.hasError) {
                              children = <Widget>[
                                const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 60,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Text('Error: ${snapshot.error}'),
                                )
                              ];
                            } else {
                              children = const <Widget>[
                                LinearProgressIndicator(),
                                Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Text('Awaiting result...'),
                                )
                              ];
                            }
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: children,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  isLoading.value
                      ? const LinearProgressIndicator()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIconButton(
                                text: "Clear",
                                onPressed: () {
                                  validateForm(auth, context);
                                },
                                icon: Icons.delete_forever,
                                color: yellow),
                            CustomIconButton(
                              onPressed: () {
                                validateForm(auth, context);
                              },
                              icon:Icons.save,
                              text: "Save",
                              color:  blue,
                            ),
                          ],
                        )
                ],
              ),
            ), //User Form
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        height: 52,
                        padding: const EdgeInsets.only(left: 14),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            )),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              onChanged: (text) =>
                                  onSearchTextChanged(text, auth),
                              autofocus: false,
                              cursorColor: Get.isDarkMode
                                  ? Colors.grey[100]
                                  : Colors.grey[700],
                              controller: _searchController.value,
                              style: subTitleStyle,
                              decoration: const InputDecoration(
                                hintText: "Search User",
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0)),
                              ),
                            )),
                            const Icon(Icons.search)
                          ],
                        ),
                      )
                    ],
                  ),
                  userListBuilder,
                ],
              ),
            ), //User List
          ],
        ))
      ],
    );
  }

  onSearchTextChanged(String text, AuthProvider auth) async {
    setState(() {
      userListBuilder = getUserList(auth);
    });
  }

  clearForm() {
    _fName.value.clear();
    _lName.value.clear();
    _password.value.clear();
    //_userId.value.clear();
    _userName.value.clear();
    selectedRole.value = Typex(id: -1, name: "", description: "Select RoleX");
  }

  setForm(UserModal user) {
    _fName.value.text = user.fName;
    _lName.value.text = user.lName;
    _password.value.text = user.password;
    //_userId.value.text = user.uid.toString();
    _userName.value.text = user.userName;
    selectedRole.value =
        Typex(id: 1, name: user.userRole, description: user.userRoleName);
  }

  validateForm(AuthProvider auth, BuildContext context) async {
    if (selectedRole.value.id == -1) {
      Get.snackbar("Required", "Please select user role",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: context.theme.backgroundColor,
          icon: const Icon(
            Icons.warning,
            color: Colors.redAccent,
          ));
      return;
    }
    if (_userName.value.text.isNotEmpty &&
        _fName.value.text.isNotEmpty &&
        _lName.value.text.isNotEmpty &&
        _password.value.text.isNotEmpty) {
      isLoading.value = true;

      String? res = await auth.newUser(
          userName: _userName.value.text,
          password: _password.value.text,
          fName: _fName.value.text,
          lName: _lName.value.text,
          userRole: selectedRole.value.name,
          link: GET_NEW_USER_URL);
      isLoading.value = false;
      if (res == "valid") {
        setState(() {
          userListBuilder = getUserList(auth);
        });
        Get.snackbar("Success", "User Create Successfully!",
            snackPosition: SnackPosition.TOP,
            backgroundColor: context.theme.backgroundColor,
            borderRadius: 4,
            margin: const EdgeInsets.all(10),
            icon: const Icon(
              Icons.done,
              color: Colors.blue,
            ));
      } else {
        if ((res ?? "").contains("PRIMARY KEY constraint")) {
          //Show Update Dialog
          Widget cancelButton = TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
          );
          Widget continueButton = TextButton(
            child: const Text("Update"),
            onPressed: () async {
              isLoading.value = true;

              String? res = await auth.newUser(
                  userName: _userName.value.text,
                  password: _password.value.text,
                  fName: _fName.value.text,
                  lName: _lName.value.text,
                  userRole: selectedRole.value.name,
                  link: GET_UPDATE_USER_URL);
              isLoading.value = false;
              if (res == "valid") {
                setState(() {
                  userListBuilder = getUserList(auth);
                });
                Navigator.of(context, rootNavigator: true).pop('dialog');
                Get.snackbar("Success", "User Create Successfully!",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: context.theme.backgroundColor,
                    borderRadius: 4,
                    margin: const EdgeInsets.all(10),
                    icon: const Icon(
                      Icons.done,
                      color: Colors.blue,
                    ));
              }
            },
          );

          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
            title: const Text("Existing User"),
            content: const Text("Would you like to Update this user records?"),
            actions: [
              cancelButton,
              continueButton,
            ],
          );

          // show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        } else {
          Get.snackbar("Something Wrong..!", res ?? "",
              snackPosition: SnackPosition.TOP,
              backgroundColor: context.theme.backgroundColor,
              borderRadius: 4,
              margin: const EdgeInsets.all(10),
              icon: const Icon(
                Icons.warning,
                color: Colors.redAccent,
              ));
        }
      }
    } else {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: context.theme.backgroundColor,
          icon: const Icon(
            Icons.warning,
            color: Colors.redAccent,
          ));
      return;
    }
  }

  getUserList(AuthProvider auth) {
    return FutureBuilder<K_Response?>(
      future: apiService.receive(
          K_Response(
                  data: "x",
                  message: _searchController.value.text.isEmpty
                      ? "*"
                      : _searchController.value.text,
                  rescode: 0)
              .toMap(),
          GET_GET_USER_LIST_URL),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CustomText(text: snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: const [
              SizedBox(
                height: 20,
              ),
              CustomText(text: "Loading.."),
              SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(),
            ],
          );
        } else {
          // Map<String, dynamic> map = jsonDecode(snapshot.data!.body);
          // return ReOrderItems(map: map["list"]);
          List<dynamic> mapList = snapshot.data!.data;
          if (mapList.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fact_check_outlined,
                  size: 100,
                  color: Get.isDarkMode ? lightGrey : Colors.grey,
                ),
                Text(
                  "No Users",
                  style: subHeadlineStyle,
                ),
              ],
            );
          }
          //Row(children: strings.map((item) => new Text(item)).toList());

          return ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: mapList.map((e) {
              Map<String, dynamic> mapObj = e;
              UserModal t = UserModal.fromMap(mapObj);

              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Slidable(
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          String? res =
                              await auth.deleteUser(userName: t.userName);
                          isLoading.value = false;
                          if (res == "valid") {
                            setState(() {
                              userListBuilder = getUserList(auth);
                            });
                            Get.snackbar("Success", "User Delete Successfully!",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: context.theme.backgroundColor,
                                borderRadius: 4,
                                margin: const EdgeInsets.all(10),
                                icon: const Icon(
                                  Icons.done,
                                  color: Colors.blue,
                                ));
                          } else {
                            Get.snackbar("Something Wrong..!", res ?? "",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: context.theme.backgroundColor,
                                borderRadius: 4,
                                margin: const EdgeInsets.all(10),
                                icon: const Icon(
                                  Icons.warning,
                                  color: Colors.redAccent,
                                ));
                          }
                        },
                        backgroundColor: red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          setForm(t);
                        },
                        backgroundColor: blue,
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Edit',
                      ),
                    ],
                  ),
                  child: UserCard(
                    user: t,
                  ),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
