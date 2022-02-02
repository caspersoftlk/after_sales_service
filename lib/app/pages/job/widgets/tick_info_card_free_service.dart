import 'package:after_sales_service_module/app/constants/string_ref.dart';
import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/helpers/reponsiveness.dart';
import 'package:after_sales_service_module/app/models/service_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TicketCardInfo extends StatelessWidget {
  final ServiceOrder serviceOrder;

  const TicketCardInfo({Key? key, required this.serviceOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 8),
      decoration: BoxDecoration(
          color: serviceOrder.techId == -1 ? redBack :Colors.white,
          border: Border(bottom: BorderSide(width: 2, color: red))),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              serviceOrder.jobType=="AGST"?Icon(Icons.wifi_protected_setup,size: 70,color: lightGrey,):Icon(Icons.phone_in_talk_sharp,size: 70,color: lightGrey,),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 12,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.anchor_sharp,color: dark,),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              "JNO "+serviceOrder.id.toString().padLeft(6,"0"),
                              style: const TextStyle(fontSize: 14,color: dark),)
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.date_range,color: dark,),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                                dateformat.format(DateFormat("M/d/yyyy")
                                    .parse(serviceOrder.freeServiceDate!)),
                              style: const TextStyle(fontSize: 14,color: dark),)
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.receipt,color: dark),
                            const SizedBox(
                              width: 2,
                            ),
                            Text("INV "+
                              serviceOrder.invNo!,
                              style: const TextStyle(fontSize: 14,color: dark),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.hardware, color: dark,),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                                serviceOrder.techId == -1
                                    ? "Not assign"
                                    : serviceOrder.techLastName! +(serviceOrder.isHandover!?" (Handover)":""),
                                style: TextStyle(fontSize: 14,color: serviceOrder.isHandover!?red:dark)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      spacing: 10,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              serviceOrder.invCustomerName!,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.phone_android),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              serviceOrder.invCustomerMobile!,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_pin),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          serviceOrder.invCustomerAddress!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      spacing: 10,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.view_in_ar),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              serviceOrder.invProductName!,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
