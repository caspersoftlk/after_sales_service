import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/models/service_order.dart';
import 'package:after_sales_service_module/app/pages/job/widgets/tick_info_card_free_service.dart';
import 'package:after_sales_service_module/app/providers/auth.dart';
import 'package:after_sales_service_module/app/widgets/custome_icon_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class JobCard extends StatelessWidget {
  final SlidableActionCallback techInspect;
  final SlidableActionCallback readMore;
  final SlidableActionCallback repairNote;
  final ServiceOrder element;
  const  JobCard({Key? key, required this.techInspect, required this.readMore, required this.repairNote, required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Slidable(
        closeOnScroll: true,
        dragStartBehavior: DragStartBehavior.start,
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              icon: Icons.volunteer_activism,
              label: "Tech Inspect",
              backgroundColor: darkGreen,
              onPressed: techInspect,
              foregroundColor: Colors.white,
            ),
            SlidableAction(
              icon: Icons.handyman,
              label: "Repair Note",
              foregroundColor: Colors.white,
              backgroundColor: red,
              onPressed: repairNote,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              icon: Icons.info,
              label: "Read More",
              backgroundColor: blue,
              foregroundColor: Colors.white,
              onPressed: readMore,
            )
          ],
        ),
        child: TicketCardInfo(
          serviceOrder: element,
          openMenu: (){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Options'),
                    content: SizedBox(width: 100, height: 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomIconButton(text: "More Details", onPressed: (){
                                Get.back();
                                readMore.call(context);
                              }, icon: Icons.read_more, color: blue),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomIconButton(text: "Repair Note", onPressed: (){
                                Get.back();
                                repairNote.call(context);
                              }, icon: Icons.hardware, color: red),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomIconButton(text: "Technical Inspect", onPressed: (){
                                Get.back();
                                techInspect.call(context);
                              }, icon: Icons.rate_review, color: darkGreen),
                            ),
                          ],
                        ),

                      ],
                    )),
                  );
                });
          },
        ),
      ),
    );
  }
}
