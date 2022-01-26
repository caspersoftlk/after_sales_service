import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final bool? active;
  final bool? isNumber;
  const MyInputField({Key? key, required this.title, required this.hint, this.controller, this.widget, this.active, this.isNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool readOnly;
    if(widget==null && active!= null){
      if(active!){
        readOnly = false;
      }else{
        readOnly = true;
      }
    }else if(widget!=null){
      readOnly = true;
    }else{
      readOnly = false;
    }

    return Container(
      margin: const EdgeInsets.only(top:16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: titleStyle,),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            height: 52,
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              )
            ),
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  keyboardType: isNumber!=null?TextInputType.number:TextInputType.text,
                  readOnly: readOnly,
                  autofocus: false,
                  cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                  controller: controller,
                  style: subTitleStyle,
                  decoration: InputDecoration(

                    hintText: hint,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0
                      )
                    ),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0
                        )
                    ),
                  ),
                )),
                if(active==null)
                widget==null?Container():Container(child: widget,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
