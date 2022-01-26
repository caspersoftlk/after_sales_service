import 'Customer.dart';

class Invoice {
  String? locationID;
  String? locationCode;
  String? locationName;
  String? zno;
  String? documentID;
  String? documentNo;
  String? documentDate;
  Customer? customer;
  double? grossAmount;
  double? discountPercentage;
  double? discountAmount;
  double? netAmount;
  String? productID;
  String? productCode;
  String? productName;
  String? barCode;
  double? qty;
  double? sellingPrice;
  double? costPrice;
  bool? isDelete;
  String? serialNo;
  String? remark;

  Invoice(
      {this.locationID,
        this.locationCode,
        this.locationName,
        this.zno,
        this.documentID,
        this.documentNo,
        this.documentDate,
        this.customer,
        this.grossAmount,
        this.discountPercentage,
        this.discountAmount,
        this.netAmount,
        this.productID,
        this.productCode,
        this.productName,
        this.barCode,
        this.qty,
        this.sellingPrice,
        this.costPrice,
        this.isDelete,
        this.serialNo,
        this.remark});

  Invoice.fromJson(Map<String, dynamic> json) {
    locationID = json['LocationID'];
    locationCode = json['LocationCode'];
    locationName = json['LocationName'];
    zno = json['Zno'];
    documentID = json['DocumentID'];
    documentNo = json['DocumentNo'];
    documentDate = json['DocumentDate'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    grossAmount = json['GrossAmount'];
    discountPercentage = json['DiscountPercentage'];
    discountAmount = json['DiscountAmount'];
    netAmount = json['NetAmount'];
    productID = json['ProductID'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    barCode = json['BarCode'];
    qty = json['Qty'];
    sellingPrice = json['SellingPrice'];
    costPrice = json['CostPrice'];
    isDelete = json['IsDelete'];
    serialNo = json['SerialNo'];
    remark = json['Remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LocationID'] = this.locationID;
    data['LocationCode'] = this.locationCode;
    data['LocationName'] = this.locationName;
    data['Zno'] = this.zno;
    data['DocumentID'] = this.documentID;
    data['DocumentNo'] = this.documentNo;
    data['DocumentDate'] = this.documentDate;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['GrossAmount'] = this.grossAmount;
    data['DiscountPercentage'] = this.discountPercentage;
    data['DiscountAmount'] = this.discountAmount;
    data['NetAmount'] = this.netAmount;
    data['ProductID'] = this.productID;
    data['ProductCode'] = this.productCode;
    data['ProductName'] = this.productName;
    data['BarCode'] = this.barCode;
    data['Qty'] = this.qty;
    data['SellingPrice'] = this.sellingPrice;
    data['CostPrice'] = this.costPrice;
    data['IsDelete'] = this.isDelete;
    data['SerialNo'] = this.serialNo;
    data['Remark'] = this.remark;
    return data;
  }
}