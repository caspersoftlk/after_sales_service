import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/helpers/reponsiveness.dart';
import 'package:flutter/material.dart';

class JobInfoCard extends StatelessWidget {
  const JobInfoCard({Key? key}) : super(key: key);

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

                Wrap(
                  spacing: 10,
                  children: [
                    Text("JOB ID : 01",style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 8),
                    Text("STS : PENDING",style: TextStyle(fontSize: 14)),
                    if(!ResponsiveWidget.isSmallScreen(context))
                      const SizedBox(width: 8),
                    if(!ResponsiveWidget.isSmallScreen(context))
                      Text("TECH : DR.WOLF",style: TextStyle(fontSize: 14)),
                    if(!ResponsiveWidget.isSmallScreen(context))
                      const SizedBox(width: 8),
                    if(!ResponsiveWidget.isSmallScreen(context))
                      Text("TYPE : P/R",style: TextStyle(fontSize: 14))
                  ],
                ),
                if(ResponsiveWidget.isSmallScreen(context))
                  const SizedBox(height: 2),
                if(ResponsiveWidget.isSmallScreen(context))
                  Text("TECH : DR.WOLF",style: TextStyle(fontSize: 14)),
                if(ResponsiveWidget.isSmallScreen(context))
                  const SizedBox(height: 2),
                if(ResponsiveWidget.isSmallScreen(context))
                  Text("TYPE : P/R",style: TextStyle(fontSize: 14)),
                const SizedBox(height: 10,),
                Text("Test Customer Name",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
