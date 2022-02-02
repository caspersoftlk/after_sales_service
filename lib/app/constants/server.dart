import 'package:after_sales_service_module/app/models/typex.dart';

const BASE_URL = '192.168.8.154';
var LOCATION = "LOCATION";

const LOGIN_URL = '/SumathiServiceModule/signIn';
const GET_LOCATION_URL = '/SumathiServiceModule/getLocation';
const GET_USER_ROLE_URL = '/SumathiServiceModule/getUserRoles';
const GET_NEW_USER_URL = '/SumathiServiceModule/newUser';
const GET_UPDATE_USER_URL = '/SumathiServiceModule/updateUser';
const GET_DELETE_USER_URL = '/SumathiServiceModule/deleteUser';
const GET_GET_USER_LIST_URL = '/SumathiServiceModule/getUserList';
const GET_TECH_LIST_URL = "/SumathiServiceModule/getTechnician/";
const GET_AUTO_CREATED_SERVICE_TICKS_URL = "/SumathiServiceModule/getAutoServiceOrders";
const GET_UPDATE_SERVICE_TICKS_URL = "/SumathiServiceModule/updateServiceTicket";
const GET_UPDATE_SERVICE_JOB_URL = "/SumathiServiceModule/updateServiceJob";
const GET_INSERT_SERVICE_TICKS_URL = "/SumathiServiceModule/insertServiceTicket";
const GET_ACCEPT_SERVICE_JOB_URL = "/SumathiServiceModule/acceptServiceTicket";
const GET_PRODUCT_WITH_STOCK_URL = "/SumathiServiceModule/getProducts/";
const GET_REPAIR_NOTE_ITEMS_URL = "/SumathiServiceModule/getRepairItem//";
const GET_SAVE_PRODUCT_REPAIR_NOTE_URL = "/SumathiServiceModule/insertRepairItem";

//POS
const GET_POS_INVOICES_URL = "/SumathiServiceModule/pos/getTransList/";


var selectedLocation = Typex(id: 0, name: "", description: "Select Location");

addHeaders() {
  Map<String, String> map = {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
    "Access-Control-Allow-Origin": "*"
  };
  return map;
}
