import 'package:after_sales_service_module/app/constants/controllers.dart';
import 'package:after_sales_service_module/app/constants/server.dart';
import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/helpers/reponsiveness.dart';
import 'package:after_sales_service_module/app/models/response.dart';
import 'package:after_sales_service_module/app/models/typex.dart';
import 'package:after_sales_service_module/app/pages/drivers/widgets/drivers_table.dart';
import 'package:after_sales_service_module/app/widgets/custom_text.dart';
import 'package:after_sales_service_module/app/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriversPage extends StatefulWidget {
  const DriversPage({ Key? key }) : super(key: key);

  @override
  State<DriversPage> createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {

  TextEditingController _userName = TextEditingController();
  TextEditingController _userId = TextEditingController();
  TextEditingController _fName = TextEditingController();
  TextEditingController _lName = TextEditingController();
  var selectedRole = Typex(id: 0, name: "", description: "Select Role");

  @override
  Widget build(BuildContext context) {
         return Column(
         children: [
          Obx(() => Row(
             children: [
               Container(
                 margin: EdgeInsets.only(top:
                 ResponsiveWidget.isSmallScreen(context) ? 70 : 6),
                 child: CustomText(text: menuController.activeItem.value, size: 24, weight: FontWeight.bold,)),
             ],
           ),),

           ListView(
             children: [
               Row(
                 mainAxisSize: MainAxisSize.max,
                 children: [
                   Expanded(
                     flex: 4,
                     child: Container(
                       padding: EdgeInsets.only(right: 16),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: [
                           Row(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               Expanded(
                                 flex: 3,
                                 child: MyInputField(
                                   controller: _userName,
                                   hint: "Enter User Name",
                                   title: "User Name",
                                 ),
                               ),
                               SizedBox(width: 8,),
                               Expanded(
                                 flex: 1,
                                 child: MyInputField(
                                   active: false,
                                   controller: _userId,
                                   hint: "User ID",
                                   title: "User ID",
                                 ),
                               ),
                             ],
                           ),Row(
                             children: [
                               Expanded(
                                 child: MyInputField(
                                   controller: _fName,
                                   hint: "Enter First Name",
                                   title: "First Name",
                                 ),
                               ),SizedBox(width: 8,),
                               Expanded(
                                 child: MyInputField(
                                   controller: _lName,
                                   hint: "Enter Last Name",
                                   title: "Last Name",
                                 ),
                               ),
                             ],
                           ),

                           SizedBox(height: 8,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.delete_forever), label: Text("Delete"),style: ElevatedButton.styleFrom(primary: Colors.redAccent),),
                               ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.save), label: Text("Save")),
                             ],
                           )
                         ],
                       ),
                     ),
                   ),
                   if(!ResponsiveWidget.isSmallScreen(context))
                   Expanded(
                     flex: ResponsiveWidget.isMediumScreen(context)?2:2,
                     child: Container(
                       decoration: BoxDecoration(color: Colors.amber),
                       height: 100,
                     ),
                   )
                 ],
               ),
             ],
           ),

           ],
         );
  }
}