import 'dart:async';
import 'dart:convert';

import 'package:after_sales_service_module/app/constants/controllers.dart';
import 'package:after_sales_service_module/app/constants/server.dart';
import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/helpers/reponsiveness.dart';
import 'package:after_sales_service_module/app/models/response.dart';
import 'package:after_sales_service_module/app/models/service_order.dart';
import 'package:after_sales_service_module/app/models/type_z.dart';
import 'package:after_sales_service_module/app/pages/job/widgets/tick_info_card_free_service.dart';
import 'package:after_sales_service_module/app/providers/auth.dart';
import 'package:after_sales_service_module/app/widgets/custom_text.dart';
import 'package:after_sales_service_module/app/widgets/pageTitileCard.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AcceptTickets extends StatefulWidget {
  const AcceptTickets({Key? key}) : super(key: key);

  @override
  _AcceptTicketsState createState() => _AcceptTicketsState();
}

class _AcceptTicketsState extends State<AcceptTickets> {
  var userListBuilder;
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of(context);
    userListBuilder = getServiceList(auth);

    onSearchTextChanged(String text, AuthProvider auth) async {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        setState(() {
          userListBuilder = getServiceList(auth);
        });
      });
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const PageTitleCard(title: "SERVICE ticket", icon: Icons.hardware),
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
        getServiceList(auth)
      ]))
    ]);
  }

  getServiceList(AuthProvider auth) {
    return FutureBuilder<String?>(
        future: apiService.get(GET_AUTO_CREATED_SERVICE_TICKS_URL +
            "/" +
            (_searchController.text.isEmpty ? "@" : _searchController.text) +
            "/${auth.userModel!.userName}/TICKET"),
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
              final TextEditingController searchController =
                  TextEditingController();
              widgetList.add(
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Slidable(
                    key: const ValueKey(0),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          icon: Icons.done_all_sharp,
                          label: "Accept & Create Job",
                          backgroundColor: darkGreen,
                          onPressed: (context) async {
                            element.jId = 1;
                            element.updateUser = auth.userModel!.userName;
                            element.technicalInspection = "N/A";
                            element.cat = "JOB";
                            Map<String, String> stringQueryParameters = element
                                .toJson()
                                .map((key, value) =>
                                    MapEntry(key, value.toString()));
                            var res = await apiService.send(
                                stringQueryParameters,
                                GET_ACCEPT_SERVICE_JOB_URL);
                            if (res!.statusCode == 200) {
                              var _response = K_Response.fromJson(res.body);
                              if (_response.rescode == 0) {
                                Get.snackbar("Success!",
                                    "JOB Card Created Successfully.\n JOB NO : ${_response.data.toString().padLeft(6, '0')}",
                                    snackStyle: SnackStyle.GROUNDED,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.white,
                                    borderRadius: 4,
                                    margin: const EdgeInsets.all(10),
                                    icon: const Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ));
                                setState(() {
                                });
                              } else {
                                Get.snackbar(
                                    "Something Went Wrong!", _response.message!,
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
                            } else {
                              Get.snackbar("Something Went Wrong!",
                                  "Server Size Error..",
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
                        ),
                        Expanded(
                          child: SizedBox.expand(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: yellow,
                                  border: Border(
                                      bottom:
                                          BorderSide(width: 2, color: blue))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownSearch<TypeZ>(
                                  isFilteredOnline: true,
                                  showClearButton: true,
                                  showSearchBox: true,
                                  autoFocusSearchBox: true,
                                  searchBoxController: searchController,
                                  dropdownSearchDecoration:
                                      const InputDecoration(
                                          border: InputBorder.none),
                                  dropDownButton: Container(),
                                  dropdownBuilder:
                                      (context, selectedItem, itemAsString) {
                                    if (selectedItem == null) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.person_add, size: 25),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "Handover",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      );
                                    }
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          selectedItem.description!.trim(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    );
                                  },
                                  popupItemBuilder:
                                      (context, item, isSelected) {
                                    return Container(
                                      padding: const EdgeInsets.only(
                                          top: 18,
                                          bottom: 18,
                                          left: 18,
                                          right: 8),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 2, color: blue)),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.description!.trim(),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.person,
                                                      size: 18,
                                                    ),
                                                    const SizedBox(width: 2),
                                                    Text(item.name!,
                                                        style: const TextStyle(
                                                            fontSize: 12)),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                        "(" +
                                                            (item.id
                                                                .toString()) +
                                                            ")",
                                                        style: const TextStyle(
                                                            fontSize: 12))
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
                                        GET_TECH_LIST_URL +
                                            (filter.isEmpty ? "@" : filter));
                                    print(res);
                                    Iterable l = json.decode(res!);
                                    var posts = List<TypeZ>.from(l
                                        .map((model) => TypeZ.fromJson(model)));
                                    return posts;
                                  },
                                  onChanged: (value) async {
                                    element.techId = value!.id;
                                    element.techLastName = value.description;
                                    element.techName = value.name;
                                    element.isHandover = true;
                                    Map<String, String> stringQueryParameters =
                                        element.toJson().map((key, value) =>
                                            MapEntry(key, value.toString()));
                                    var res = await apiService.save(
                                        stringQueryParameters,
                                        GET_UPDATE_SERVICE_TICKS_URL);
                                    if (res == "s") {
                                      setState(() {});
                                      Get.snackbar("Success!",
                                          "Technician Handover successful",
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
                                      Get.snackbar("Something Went Wrong!", res,
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
                                ),
                              ),
                            ),
                          ),
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
                                width: ResponsiveWidget.isSmallScreen(context)?300:500,
                                child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      PageTitleCard(title: "JOB TYPE : ${element.jobType}", icon: Icons.arrow_right),
                                      PageTitleCard(title: "INV No : ${element.invNo}", icon: Icons.arrow_right),

                                      PageTitleCard(title: "Customer : ${element.invCustomerName}", icon: Icons.arrow_right),
                                      PageTitleCard(title: "Customer Mobile : ${element.invCustomerMobile}", icon: Icons.arrow_right),
                                      PageTitleCard(title: "Customer Address : ${element.invCustomerAddress}", icon: Icons.arrow_right),
                                      PageTitleCard(title: "Product Name : ${element.invProductName}", icon: Icons.arrow_right),
                                      PageTitleCard(title: "Product Serial : ${element.invProductSerial}", icon: Icons.arrow_right),
                                      PageTitleCard(title: "Product Model : ${element.invProductModel}", icon: Icons.arrow_right),
                                      PageTitleCard(title: "inquiry : ${element.isWarrantyExpired!?"Not Applicable":"Applicable"}", icon: Icons.arrow_right),
                                      PageTitleCard(title: "Inspection : ${element.inspection}", icon: Icons.arrow_right),
                                      PageTitleCard(title: "Remarks : ${element.remark}", icon: Icons.arrow_right),
                                      PageTitleCard(title: "Technician : ${element.techLastName}", icon: Icons.arrow_right),
                                      PageTitleCard(title: "Last Update : ${element.updateDate}", icon: Icons.arrow_right),
                                      OutlinedButton(onPressed: (){Get.back();}, child: const Text("Close"))
                                    ]
                                ),
                              );
                            }
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Ticket Details'),
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
