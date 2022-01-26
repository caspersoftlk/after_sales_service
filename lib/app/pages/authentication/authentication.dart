import 'package:after_sales_service_module/app/constants/controllers.dart';
import 'package:after_sales_service_module/app/constants/server.dart';
import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/models/response.dart';
import 'package:after_sales_service_module/app/models/typex.dart';
import 'package:after_sales_service_module/app/providers/app.dart';
import 'package:after_sales_service_module/app/providers/auth.dart';
import 'package:after_sales_service_module/app/routing/routes.dart';
import 'package:after_sales_service_module/app/widgets/custom_text.dart';
import 'package:after_sales_service_module/app/widgets/input_field.dart';
import 'package:after_sales_service_module/layout.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthenticationPage extends StatefulWidget {
  AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {



  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
        () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of(context);
    AppProvider app = Provider.of(context);
    TextEditingController _email = TextEditingController(text: "casper");
    TextEditingController _password = TextEditingController(text: "123");

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 325,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset("assets/icons/logo.png",height: 75,width: 75,),
                    Expanded(child: Container()),
                  ],
                ),
                Row(
                  children: [
                    Text("Login",
                        style: GoogleFonts.roboto(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CustomText(
                      text: "GS Health Service Module",
                      color: lightGrey,
                    ),
                  ],
                ),
                FutureBuilder<K_Response?>(
                  future: apiService.receive(
                      K_Response(message: "", data: "").toMap(), GET_LOCATION_URL), // a previously-obtained Future<String> or null
                  builder: (BuildContext context, AsyncSnapshot<K_Response?> snapshot) {
                    List<Widget> children;
                    if (snapshot.hasData) {
                      List<dynamic> dynamicList = snapshot.data!.data;

                      children = <Widget>[
                        MyInputField(
                          title: "",
                          widget: DropdownButton(
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: Colors.grey),
                            iconSize: 32,
                            elevation: 4,
                            style: subTitleStyle,
                            underline: Container(
                              height: 0,
                            ),
                            onChanged: (dynamic newValue) {
                              setState(() {
                                selectedLocation = newValue!;
                              });
                            },
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            items: dynamicList
                                .map<DropdownMenuItem<dynamic>>((dynamic value) {
                                  print(value);
                              return DropdownMenuItem<dynamic>(
                                value: Typex.fromMap(value),
                                child: Text(Typex.fromMap(value).description),
                              );
                            }).toList(),
                          ),
                          hint: selectedLocation.description,
                        )
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
                        SizedBox(
                          child: LinearProgressIndicator(),
                        ),
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
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                      labelText: "User Name",
                      hintText: "user",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "123",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (value) {}),
                        const CustomText(
                          text: "Remeber Me",
                        ),
                      ],
                    ),
                    CustomText(text: "Forgot password?", color: active)
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    if(selectedLocation.name == ""){
                      Get.snackbar("Location can not be empty", "Please select the location!",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: context.theme.backgroundColor,
                          borderRadius: 4,
                          margin: const EdgeInsets.all(10),
                          icon: const Icon(
                            Icons.warning,
                            color: Colors.redAccent,
                          ));
                      return;
                    }
                    app.changeLoading();
                    String? res = await auth.login(
                        userName: _email.text, password: _password.text);
                    app.changeLoading();
                    if (res == "valid") {
                      auth.setStatus(Status.Authenticated);
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
                  child: app.isLoading
                      ? LinearProgressIndicator()
                      : Container(
                          decoration: BoxDecoration(
                              color: active,
                              borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const CustomText(
                            text: "Login",
                            color: Colors.white,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(text: "Do not have admin credentials? "),
                  TextSpan(
                      text: "Request Credentials! ",
                      style: TextStyle(color: active))
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
