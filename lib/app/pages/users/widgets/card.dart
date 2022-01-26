import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/models/user.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UserModal user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18,bottom: 18,left: 18,right: 8),
      decoration: BoxDecoration(
          color: Colors.white,
        border:Border(bottom: BorderSide(width: 2,color: blue))
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.fName+" "+user.lName,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const Icon(Icons.person,size: 18,),
                    const SizedBox(width: 2),
                    Text(user.userName,style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Text("-",style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Text(user.userRoleName,style: TextStyle(fontSize: 16))
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
