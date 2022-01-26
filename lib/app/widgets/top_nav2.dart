import 'package:flutter/material.dart';
import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/helpers/reponsiveness.dart';
import 'package:get/get.dart';

import 'custom_text.dart';

AppBar topNavigationBar2(BuildContext context, String name,String menuName) => AppBar(
      leading: IconButton(
              icon: const Icon(Icons.arrow_back,color: dark),
              onPressed: () {
                Get.back();
              }),
      title: Container(
        child: Row(
          children: [ CustomText(
                  text: menuName,
                  color: lightGrey,
                  size: 20,
                  weight: FontWeight.bold,
                ),
            Expanded(child: Container()),
            Container(
              width: 1,
              height: 22,
              color: lightGrey,
            ),
            const SizedBox(
              width: 24,
            ),
            CustomText(
              text: name,
              color: lightGrey,
            ),
            const SizedBox(
              width: 16,
            ),
            Container(
              decoration: BoxDecoration(
                  color: active.withOpacity(.5),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundColor: light,
                  child: Icon(Icons.person_outline, color: dark,),
                ),
              ),
            )
          ],
        ),
      ),
      iconTheme: IconThemeData(color: dark),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
