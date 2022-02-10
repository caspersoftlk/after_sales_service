import 'dart:async';
import 'dart:convert';

import 'package:after_sales_service_module/app/constants/controllers.dart';
import 'package:after_sales_service_module/app/constants/server.dart';
import 'package:after_sales_service_module/app/constants/string_ref.dart';
import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/helpers/local_navigator.dart';
import 'package:after_sales_service_module/app/helpers/reponsiveness.dart';
import 'package:after_sales_service_module/app/models/service_order.dart';
import 'package:after_sales_service_module/app/models/transaction_doc.dart';
import 'package:after_sales_service_module/app/pages/job/widgets/JobCard.dart';
import 'package:after_sales_service_module/app/pages/job/widgets/read_more.dart';
import 'package:after_sales_service_module/app/pages/job/widgets/tick_info_card_free_service.dart';
import 'package:after_sales_service_module/app/providers/auth.dart';
import 'package:after_sales_service_module/app/routing/routes.dart';
import 'package:after_sales_service_module/app/widgets/custom_container.dart';
import 'package:after_sales_service_module/app/widgets/custom_text.dart';
import 'package:after_sales_service_module/app/widgets/custome_icon_button.dart';
import 'package:after_sales_service_module/app/widgets/pageTitileCard.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

ServiceOrder serviceElement = ServiceOrder(cat: "cat");
class JobOverview extends StatefulWidget {
  const JobOverview({Key? key}) : super(key: key);

  @override
  _FreeServiceOverViewState createState() => _FreeServiceOverViewState();
}

class _FreeServiceOverViewState extends State<JobOverview> {
  var userListBuilder;
  final _searchController = TextEditingController();
  Timer? _debounce;
  var isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of(context);
    userListBuilder = getFreeServiceList(auth);

    onSearchTextChanged(String text, AuthProvider auth) async {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        setState(() {
          userListBuilder = getFreeServiceList(auth);
        });
      });
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const PageTitleCard(title: "SERVICE ORDERS (JOBS)", icon: Icons.hardware),
      Expanded(
          child: ListView(children: [
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
                onChanged: (text) => onSearchTextChanged(text, auth),
                autofocus: false,
                cursorColor:
                    Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                controller: _searchController,
                style: subTitleStyle,
                decoration: const InputDecoration(
                  hintText: "Search User",
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0)),
                ),
              )),
              const Icon(Icons.search)
            ],
          ),
        ),
        getFreeServiceList(auth)
      ]))
    ]);
  }

  getFreeServiceList(AuthProvider auth) {
    String userPara =
        auth.userModel!.userRole == "tech" ? auth.userModel!.userName : "@";
    return FutureBuilder<String?>(
        future: apiService.get(GET_AUTO_CREATED_SERVICE_TICKS_URL +
            "/" +
            (_searchController.text.isEmpty ? "@" : _searchController.text) +
            "/$userPara/JOB"),
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
            String mapList = snapshot.data!;
            Iterable l = json.decode(mapList);
            List<ServiceOrder> posts = List<ServiceOrder>.from(
                l.map((model) => ServiceOrder.fromJson(model)));
            List<Widget> widgetList = [];
            for (var element in posts) {
              final TextEditingController _jobInspect =
                  TextEditingController(text: element.technicalInspection);
              final TextEditingController _jobRemarks =
                  TextEditingController(text: element.remark);
              RxInt isPhysicalDamage = (element.isPhysicalDamage! ? 1 : 0).obs;
              RxInt isClaimable = (element.isWarrantyExpired! ? 0 : -1).obs;

              _damageTypePallet() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nature or the damage/issue",
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: List<Widget>.generate(2, (int index) {
                        return GestureDetector(
                            onTap: () {
                              isPhysicalDamage.value = index;
                              print(isPhysicalDamage.value);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                children: [
                                  Obx(() => CircleAvatar(
                                        radius: 14,
                                        backgroundColor:
                                            index == 0 ? blue : yellow,
                                        child: isPhysicalDamage.value == index
                                            ? const Icon(
                                                Icons.done,
                                                color: Colors.white,
                                                size: 16,
                                              )
                                            : Container(),
                                      )),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(index == 0
                                      ? "Software/Internal"
                                      : "Physical Damage")
                                ],
                              ),
                            ));
                      }),
                    )
                  ],
                );
              }

              _claimApplyPallet() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "inquiry Eligibility?",
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: List<Widget>.generate(2, (int index) {
                        return GestureDetector(
                            onTap: isClaimable.value == 1
                                ? () {
                                    isClaimable.value = index;
                                  }
                                : () {},
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                children: [
                                  Obx(() => CircleAvatar(
                                        radius: 14,
                                        backgroundColor:
                                            index == 0 ? red : darkGreen,
                                        child: isClaimable.value == index
                                            ? const Icon(
                                                Icons.done,
                                                color: Colors.white,
                                                size: 16,
                                              )
                                            : Container(),
                                      )),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(index == 1
                                      ? "CLAIMABLE"
                                      : "NOT CLAIMABLE")
                                ],
                              ),
                            ));
                      }),
                    )
                  ],
                );
              }

              Widget setupAlertContainer(AuthProvider auth) {
                return SizedBox(
                  width: ResponsiveWidget.isSmallScreen(context) ? 300 : 500,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Inspection",
                          style: titleStyle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: _jobInspect,
                          minLines: 6,
                          // any number you need (It works as the rows for the textarea)
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                              hintText: "Technical inspection",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4))),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Remarks",
                          style: titleStyle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: _jobRemarks,
                          minLines: 3,
                          // any number you need (It works as the rows for the textarea)
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: TextStyle(color: red),
                          decoration: InputDecoration(
                              hintText: "Remarks",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4))),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _damageTypePallet(),
                        const SizedBox(
                          height: 16,
                        ),
                        _claimApplyPallet(),
                        const SizedBox(
                          height: 16,
                        ),
                        isLoading.value
                            ? const LinearProgressIndicator()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomIconButton(
                                      text: "Cancel",
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: Icons.delete_forever,
                                      color: yellow),
                                  CustomIconButton(
                                    onPressed: () async {
                                      if (isClaimable.value == -1) {
                                        Get.snackbar(
                                            "Cannot Save Service Order",
                                            "Please Select the warranty eligibility",
                                            snackStyle: SnackStyle.GROUNDED,
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: blue,
                                            borderRadius: 4,
                                            margin: const EdgeInsets.all(10),
                                            icon: const Icon(
                                              Icons.warning,
                                              color: Colors.white,
                                            ));
                                        return;
                                      }
                                      if (isPhysicalDamage.value == -1) {
                                        Get.snackbar(
                                            "Cannot Save Service Order",
                                            "Please Select the Damage type",
                                            snackStyle: SnackStyle.GROUNDED,
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: blue,
                                            borderRadius: 4,
                                            margin: const EdgeInsets.all(10),
                                            icon: const Icon(
                                              Icons.warning,
                                              color: Colors.white,
                                            ));
                                        return;
                                      }
                                      if (_jobInspect.text.isEmpty) {
                                        Get.snackbar(
                                            "Cannot Save Service Order",
                                            "Please Enter Inspection",
                                            snackStyle: SnackStyle.GROUNDED,
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: blue,
                                            borderRadius: 4,
                                            margin: const EdgeInsets.all(10),
                                            icon: const Icon(
                                              Icons.warning,
                                              color: Colors.white,
                                            ));
                                        return;
                                      }
                                      element.updateUser =
                                          auth.userModel!.userName;
                                      element.jId = 2; //Visited
                                      element.isPhysicalDamage =
                                          isPhysicalDamage.value == 1;
                                      element.isClaimableOrNot =
                                          isClaimable.value == 1;
                                      element.remark = _jobRemarks.text;
                                      element.technicalInspection =
                                          _jobInspect.text;

                                      //Update Record
                                      Map<String, String>
                                          stringQueryParameters =
                                          element.toJson().map((key, value) =>
                                              MapEntry(key, value.toString()));
                                      var res = await apiService.save(
                                          stringQueryParameters,
                                          GET_UPDATE_SERVICE_JOB_URL);
                                      if (res == "s") {
                                        Get.back();
                                        setState(() {});
                                        Get.snackbar("Success!",
                                            "Technical Details Saved!",
                                            snackStyle: SnackStyle.GROUNDED,
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.white,
                                            borderRadius: 4,
                                            margin: const EdgeInsets.all(10),
                                            icon: const Icon(
                                              Icons.done,
                                              color: Colors.green,
                                            ));
                                      } else {
                                        Get.snackbar(
                                            "Something Went Wrong!", res,
                                            snackStyle: SnackStyle.GROUNDED,
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: red,
                                            borderRadius: 4,
                                            margin: const EdgeInsets.all(10),
                                            icon: const Icon(
                                              Icons.warning,
                                              color: Colors.white,
                                            ));
                                      }
                                    },
                                    icon: Icons.save,
                                    text: "Save and Mark as Visited",
                                    color: blue,
                                  ),
                                ],
                              )
                      ]),
                );
              }

              widgetList.add(JobCard(techInspect: (context) async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Technical Inspection'),
                        content: setupAlertContainer(auth),
                      );
                    });
              }, readMore: (context) {
                TextEditingController serviceDateTime =
                TextEditingController();

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('  Details'),
                        content: ReadMoreJob(element: element, state: ()=> setState(() {
                        })),
                      );
                    });
              }, repairNote: (context) async {
                serviceElement = element;
                navigationController.navigateTo(repairNotePageRoute);
              }, element: element));
            }

            return ListView(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: widgetList);
          }
        });
  }
}
