import 'package:intl/intl.dart';

const String string_FreeService = "Free Service";
const String string_FreeService_des = "Description";
const String string_WarrantyRepair = "inquiry Repair";
const String string_WarrantyRepair_des = "Description";
const String string_PaidRepair = "Paid Repair";
const String string_PaidRepair_des = "Description";

final dateformat = DateFormat('dd/MM/yyyy');
//DateFormat("dd/MM/yyyy hh:mm:ss a").format(DateFormat("M/d/yyyy hh:mm:ss a").parse(element.freeServiceDate!,false))
formatStringDateTime(date) => DateFormat("dd/MM/yyyy hh:mm:ss a").format(DateFormat("M/d/yyyy hh:mm:ss a").parse(date,false));
formatStringDateTimeReverse(date) => DateFormat("M/d/yyyy hh:mm:ss a").format(DateFormat("dd/MM/yyyy hh:mm:ss a").parse(date,false));
formatStringDate(date) => DateFormat("dd/MM/yyyy").format(DateFormat("M/d/yyyy").parse(date,false));