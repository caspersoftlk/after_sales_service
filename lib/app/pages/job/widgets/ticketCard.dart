import 'dart:convert';

import 'package:after_sales_service_module/app/constants/controllers.dart';
import 'package:after_sales_service_module/app/constants/server.dart';
import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/models/service_order.dart';
import 'package:after_sales_service_module/app/models/type_z.dart';
import 'package:after_sales_service_module/app/pages/job/widgets/read_more.dart';
import 'package:after_sales_service_module/app/pages/job/widgets/tick_info_card_free_service.dart';
import 'package:after_sales_service_module/app/widgets/custome_icon_button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class TicketCard extends StatelessWidget {
  final ServiceOrder element;
  final VoidCallback setState;
  final SlidableActionCallback removeTech;
  TicketCard({Key? key, required this.element, required this.setState, required this.removeTech}) : super(key: key);

  final TextEditingController searchController =
  TextEditingController();

  searchTech(){
    return Expanded(
      child: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
              color: darkGreen,
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
                    children: [
                      const Icon(Icons.person_add,
                          size: 25, color: Colors.white),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        element.techId! == -1
                            ? "Assign Tech"
                            : "Change Tech",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
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
                                    style:
                                    const TextStyle(
                                        fontSize:
                                        12)),
                                const SizedBox(width: 8),
                                Text(
                                    "(" +
                                        (item.id
                                            .toString()) +
                                        ")",
                                    style:
                                    const TextStyle(
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
                Iterable l = json.decode(res!);
                var posts = List<TypeZ>.from(l.map(
                        (model) => TypeZ.fromJson(model)));
                return posts;
              },
              onChanged: (value) async {
                element.techId = value!.id;
                element.techLastName = value.description;
                element.techName = value.name;
                element.technicalInspection = "N/A";
                Map<String, String>
                stringQueryParameters =
                element.toJson().map((key, value) =>
                    MapEntry(key, value.toString()));
                var res = await apiService.save(
                    stringQueryParameters,
                    GET_UPDATE_SERVICE_TICKS_URL);
                if (res == "s") {
                  setState.call();
                  Get.snackbar("Success!",
                      "Technician Assign successfully",
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
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            searchTech(),
            SlidableAction(
              icon: Icons.remove_circle,
              label: "Remove Tech",
              backgroundColor: red,
              onPressed: removeTech,
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Ticket Details'),
                        content: ReadMoreJob(element: element,state: () => setState.call()),
                      );
                    });
              },
            )
          ],
        ),
        child: TicketCardInfo(
          openMenu: (){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Options'),
                    content: SizedBox(width: 100, height: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            searchTech(),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomIconButton(text: "Remove Tech", onPressed: (){
                                    Get.back();
                                    removeTech.call(context);
                                  }, icon: Icons.highlight_remove_sharp, color: red),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomIconButton(text: "Ticket Details", onPressed: (){
                                    Get.back();
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Ticket Details'),
                                            content: ReadMoreJob(element: element,state: () => setState.call()),
                                          );
                                        });
                                  }, icon: Icons.read_more, color: blue),
                                ),
                              ],
                            ),

                          ],
                        )),
                  );
                });
          },
          serviceOrder: element,
        ),
      ),
    );
  }
}
