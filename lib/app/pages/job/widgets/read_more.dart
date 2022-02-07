import 'package:after_sales_service_module/app/constants/controllers.dart';
import 'package:after_sales_service_module/app/constants/server.dart';
import 'package:after_sales_service_module/app/constants/string_ref.dart';
import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/helpers/reponsiveness.dart';
import 'package:after_sales_service_module/app/models/service_order.dart';
import 'package:after_sales_service_module/app/widgets/pageTitileCard.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReadMoreJob extends StatelessWidget {
  final ServiceOrder element;
  final VoidCallback state;

  ReadMoreJob({Key? key, required this.element, required this.state}) : super(key: key);

  TextEditingController serviceDateTime =
  TextEditingController();
  @override
  Widget build(BuildContext context) {
    serviceDateTime.text = formatStringDateTime(element.freeServiceDate!);
    return SizedBox(
      width: ResponsiveWidget.isSmallScreen(context)
          ? 300
          : 500,
      child: ListView(shrinkWrap: true, children: [
        PageTitleCard(
            title: "JOB TYPE : ${element.jobType}",
            icon: Icons.arrow_right),
        PageTitleCard(
            title: "INV No : ${element.invNo}",
            icon: Icons.arrow_right),
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
          icon: Icons.arrow_right,
          color: red,
        ),
        PageTitleCard(
          title:
          "Is Claimable : ${!element.isClaimableOrNot!}",
          icon: Icons.arrow_right,
          color: red,
        ),
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
            "Tech Inspection : ${element.technicalInspection}",
            icon: Icons.arrow_right),
        Row(
          children: [
            PageTitleCard(
              title: "Service Date Time : ",
              icon: Icons.arrow_right,
              color: blue,
            ),
            Expanded(
              child: DateTimeField(
                resetIcon: null,
                readOnly: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),suffixIcon: Icon(Icons.date_range)),
                controller: serviceDateTime,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: blue),
                format: DateFormat("dd/MM/yyyy hh:mm:ss a"),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateFormat("dd/MM/yyyy hh:mm:ss a").parse(element.freeServiceDate!,false),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateFormat("dd/MM/yyyy hh:mm:ss a").parse(element.freeServiceDate!,false)),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
            )
          ],
        ),
        PageTitleCard(
            title:
            "Last Update : ${formatStringDate(element.updateDate)}",
            icon: Icons.arrow_right),
        const SizedBox(height: 16,),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Close")),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: OutlinedButton(
                  onPressed: () async {
                    element.freeServiceDate = formatStringDateTimeReverse(serviceDateTime.text);
                    if(element.techId == -1){
                      element.techId = -1;
                      element.techLastName = "n/a";
                      element.techName = "n/a";
                      element.technicalInspection = "n/a";
                    }
                    if(element.technicalInspection!.isEmpty){
                      element.technicalInspection = "n/a";
                    }
                    Map<String, String>
                    stringQueryParameters =
                    element.toJson().map((key,
                        value) =>
                        MapEntry(key,
                            value.toString()));
                    var res = await apiService.save(
                        stringQueryParameters,
                        GET_UPDATE_SERVICE_TICKS_URL);
                    if (res == "s") {
                      state.call();
                      Get.snackbar("Success!",
                          "Service Date Updated successfully",
                          snackStyle:
                          SnackStyle.GROUNDED,
                          snackPosition:
                          SnackPosition.BOTTOM,
                          backgroundColor:
                          Colors.white,
                          borderRadius: 4,
                          margin:
                          const EdgeInsets.all(
                              10),
                          icon: const Icon(
                            Icons.done,
                            color: Colors.green,
                          ));
                    } else {
                      Get.snackbar(
                          "Something Went Wrong!",
                          res,
                          snackStyle:
                          SnackStyle.GROUNDED,
                          snackPosition:
                          SnackPosition.BOTTOM,
                          backgroundColor: red,
                          borderRadius: 4,
                          margin:
                          const EdgeInsets.all(
                              10),
                          icon: const Icon(
                            Icons.warning,
                            color: Colors.white,
                          ));
                    }
                  },
                  child: const Text("Update")),
            ),
          ],
        )
      ]),
    );
  }
}
