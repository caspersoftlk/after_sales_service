import 'package:after_sales_service_module/app/models/response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SMSService extends GetxController{
  static SMSService instance = Get.find();

  Future<String?> send(String num,String text) async{
    try {
      Map<String,String> map = {
        "username":"esmsusr_1oo4",
        "password":"1jvtgsj",
        "from":"GS Sports",
        "to":num,
        "text":"",
        "mesageType":"1",
      };

      var url = Uri.http("http://smeapps.mobitel.lk:8585", "EnterpriseSMSV3/esmsproxyURL.php");

      print(url.toString());
      var res = await http.post(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          },
          body: map);
      print("response : ${res.body}");
      return res.body;
    } catch (e) {
      print(e);
      return null;
    }
  }
}