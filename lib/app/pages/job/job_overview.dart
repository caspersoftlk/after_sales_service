import 'dart:async';
import 'dart:convert';

import 'package:after_sales_service_module/app/constants/controllers.dart';
import 'package:after_sales_service_module/app/constants/server.dart';
import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/helpers/local_navigator.dart';
import 'package:after_sales_service_module/app/helpers/reponsiveness.dart';
import 'package:after_sales_service_module/app/models/service_order.dart';
import 'package:after_sales_service_module/app/models/transaction_doc.dart';
import 'package:after_sales_service_module/app/pages/job/widgets/tick_info_card_free_service.dart';
import 'package:after_sales_service_module/app/providers/auth.dart';
import 'package:after_sales_service_module/app/routing/routes.dart';
import 'package:after_sales_service_module/app/widgets/custom_container.dart';
import 'package:after_sales_service_module/app/widgets/custom_text.dart';
import 'package:after_sales_service_module/app/widgets/custome_icon_button.dart';
import 'package:after_sales_service_module/app/widgets/pageTitileCard.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
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

              Widget setupAlertContainerRepNote(AuthProvider auth) {
                final TextEditingController searchController =
                    TextEditingController();
                Map<String, dynamic>? selectedItem;
                var _productCode = TextEditingController().obs;
                var _productName = TextEditingController().obs;
                var _productAvlQty = TextEditingController().obs;
                var _productSelPrice = TextEditingController().obs;
                var _productSelRqQty = TextEditingController().obs;
                var _productRemark = TextEditingController().obs;
                return SizedBox(
                    width: ResponsiveWidget.isSmallScreen(context) ? 300 : 500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownSearch<Map<String, dynamic>>(
                          isFilteredOnline: true,
                          showClearButton: true,
                          showSearchBox: true,
                          autoFocusSearchBox: true,
                          searchBoxController: searchController,
                          label: "Search Item",
                          dropdownBuilder:
                              (context, selectedItem, itemAsString) {
                            if (selectedItem == null) {
                              return Row(
                                children: const [
                                  Icon(Icons.search, size: 18, color: dark),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Find Spare Parts",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: dark),
                                  ),
                                ],
                              );
                            }
                            return Row(
                              children: [
                                const Icon(
                                  Icons.view_in_ar,
                                  size: 18,
                                  color: dark,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  (selectedItem["productCode"] ?? "").trim() +
                                      " : " +
                                      (selectedItem["productName"] ?? ""),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: dark),
                                ),
                              ],
                            );
                          },
                          popupItemBuilder: (context, item, isSelected) {
                            return Container(
                              padding: const EdgeInsets.only(
                                  top: 18, bottom: 18, left: 18, right: 8),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(width: 2, color: blue)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.view_in_ar,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 2),
                                            Text(item["productName"] ?? "N/F",
                                                style: const TextStyle(
                                                    fontSize: 12)),
                                            Text(
                                              " (" +
                                                  (item["productCode"] + ")" ??
                                                      ""),
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Wrap(
                                          spacing: 10,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.all_inbox_rounded,
                                                  size: 18,
                                                ),
                                                const SizedBox(width: 2),
                                                Text(item["stock"] ?? "N/F",
                                                    style: const TextStyle(
                                                        fontSize: 12)),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.money,
                                                  size: 18,
                                                ),
                                                const SizedBox(width: 2),
                                                Text(
                                                    item["sellingPrice"] ??
                                                        "N/F",
                                                    style: const TextStyle(
                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          onFind: (String filter) async {
                            var res = await apiService.get(
                                GET_PRODUCT_WITH_STOCK_URL +
                                    (filter.isEmpty ? "@" : filter) +
                                    "/3");
                            List<dynamic> l = json.decode(res!);
                            List<Map<String, dynamic>> lamap = l
                                .map((dynamic e) => e as Map<String, dynamic>)
                                .toList();
                            return lamap;
                          },
                          onChanged: (val) {
                            selectedItem = val;
                            _productCode.value.text =
                                selectedItem!["productCode"];
                            _productName.value.text =
                                selectedItem!["productName"];
                            _productSelPrice.value.text =
                            selectedItem!["sellingPrice"];
                            _productAvlQty.value.text =
                            selectedItem!["stock"];
                            _productSelRqQty.value.text ="1";
                            _productRemark.value.text ="";
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Obx(() => TextField(
                                    readOnly: true,
                                    controller: _productCode.value,
                                    decoration: InputDecoration(
                                        labelText: "Product Code",
                                        hintText: "Code",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4))),
                                  )),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 2,
                              child: Obx(() => TextField(
                                    readOnly: true,
                                    controller: _productName.value,
                                    decoration: InputDecoration(
                                        labelText: "Product Name",
                                        hintText: "Description",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4))),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Obx(() => TextField(
                                readOnly: true,
                                controller: _productAvlQty.value,
                                decoration: InputDecoration(
                                    labelText: "Stock",
                                    hintText: "Avl. Stock",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(4))),
                              )),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 2,
                              child: Obx(() => TextField(
                                readOnly: true,
                                controller: _productSelPrice.value,
                                decoration: InputDecoration(
                                    labelText: "Selling Price",
                                    hintText: "Selling Price",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(4))),
                              )),
                            ),
                          ],
                        )
                      ],
                    ));
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

              widgetList.add(
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Slidable(
                    key: const ValueKey(0),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          icon: Icons.volunteer_activism,
                          label: "Tech Inspect",
                          backgroundColor: blue,
                          onPressed: (context) async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Technical Inspection'),
                                    content: setupAlertContainer(auth),
                                  );
                                });
                          },
                        ),
                        SlidableAction(
                          icon: Icons.handyman,
                          label: "Repair Note",
                          backgroundColor: darkGreen,
                          onPressed: (context) async {
                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return AlertDialog(
                            //         title: const Text('Repair Note'),
                            //         content: setupAlertContainerRepNote(auth),
                            //       );
                            //     });
                            serviceElement = element;
                            navigationController.navigateTo(repairNotePageRoute);
                          },
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          icon: Icons.info,
                          label: "Read More",
                          backgroundColor: yellow,
                          foregroundColor: Colors.white,
                          onPressed: (context) {
                            Widget setupAlertDialoadContainer() {
                              return SizedBox(
                                width: ResponsiveWidget.isSmallScreen(context)
                                    ? 300
                                    : 500,
                                child: ListView(shrinkWrap: true, children: [
                                  PageTitleCard(
                                      title: "JOB TYPE : ${element.jobType}",
                                      icon: Icons.send),
                                  PageTitleCard(
                                      title: "INV No : ${element.invNo}",
                                      icon: Icons.send),
                                  PageTitleCard(
                                      title: "STATUS : ${element.jName}",
                                      icon: Icons.handyman),
                                  PageTitleCard(
                                      title:
                                          "Customer : ${element.invCustomerName}",
                                      icon: Icons.arrow_right),
                                  PageTitleCard(
                                      title:
                                          "Customer Mobile : ${element.invCustomerMobile}",
                                      icon: Icons.arrow_right),
                                  PageTitleCard(
                                      title:
                                          "Customer Address : ${element.invCustomerAddress}",
                                      icon: Icons.arrow_right),
                                  PageTitleCard(
                                      title:
                                          "Product Name : ${element.invProductName}",
                                      icon: Icons.arrow_right),
                                  PageTitleCard(
                                      title:
                                          "Product Serial : ${element.invProductSerial}",
                                      icon: Icons.arrow_right),
                                  PageTitleCard(
                                      title:
                                          "Product Model : ${element.invProductModel}",
                                      icon: Icons.arrow_right),
                                  PageTitleCard(
                                      title:
                                          "Is WarrantyExpired : ${element.isWarrantyExpired}",
                                      icon: Icons.arrow_right),
                                  PageTitleCard(
                                      title:
                                          "Inspection : ${element.inspection}",
                                      icon: Icons.arrow_right),
                                  PageTitleCard(
                                      title: "Remarks : ${element.remark}",
                                      icon: Icons.arrow_right),
                                  PageTitleCard(
                                      title:
                                          "Technician : ${element.techLastName}",
                                      icon: Icons.arrow_right),
                                  PageTitleCard(
                                      title:
                                          "Last Update : ${element.updateDate}",
                                      icon: Icons.arrow_right),
                                  OutlinedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("Close"))
                                ]),
                              );
                            }

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('  Details'),
                                    content: setupAlertDialoadContainer(),
                                  );
                                });
                          },
                        )
                      ],
                    ),
                    child: TicketCardInfo(
                      serviceOrder: element,
                    ),
                  ),
                ),
              );
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
