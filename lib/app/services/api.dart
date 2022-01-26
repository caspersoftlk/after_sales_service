import 'dart:convert';

import 'package:after_sales_service_module/app/constants/server.dart';
import 'package:after_sales_service_module/app/models/response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class APIControllerServices extends GetxController {
  static APIControllerServices instance = Get.find();


  Future<http.Response?> send(body, function) async {
    try {
      var url = Uri.http(BASE_URL, function);
      print("send request : ${json.encode(body)}");
      print(url.toString());
      var res = await http.post(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          },
          body: body);
      print("response : ${res.body}");
      return res;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> get(String function) async {
    try {
      var url = Uri.http(BASE_URL, function);
      print(url.toString());
      var res = await http.get(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          });
      if (res.statusCode == 200) {
        return res.body;
      } else {
        return "Server side Error";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> save(Map<String,String>? task,String? url) async {
    try {
      late K_Response _response;
      var res = await send(task!, url);
      if (res!.statusCode == 200) {
        _response = K_Response.fromJson(res.body);
        if (_response.rescode == 0) {
          return "s";
        } else {
          return _response.message ?? "Error";
        }
      } else {
        return "Server side Error";
      }
    } catch (e) {
      e.printError();
      return e.toString();
    }
  }

  Future<K_Response?> receive(Map<String,String> task,String? url) async {
    try {
      var res = await send(task, url);
      if (res!.statusCode == 200) {
        return K_Response.fromJson(res.body);
      } else {
        return null;
      }
    } catch (e) {
      e.printError();
      return null;
    }
  }
}
