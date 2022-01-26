class TransactionDoc {
  int? documentID;
  String? recDate;
  String? locationID;
  String? productCode;
  String? serialNo;
  double? amount;
  String? receipt;
  String? customerName;
  String? customerCode;
  String? billingMobile;
  String? billingAddress1;
  String? productName;
  String? model;
  String? description;
  int? durationInMonths;
  int? repairSequence;
  String? invWarrantyDetailsID;
  String? barCode;

  TransactionDoc(
      {this.documentID,
        this.recDate,
        this.locationID,
        this.productCode,
        this.serialNo,
        this.amount,
        this.receipt,
        this.customerName,
        this.customerCode,
        this.billingMobile,
        this.billingAddress1,
        this.productName,
        this.model,
        this.description,
        this.durationInMonths,
        this.repairSequence,
        this.invWarrantyDetailsID,
        this.barCode});

  TransactionDoc.fromJson(Map<String, dynamic> json) {
    documentID = json['DocumentID'];
    recDate = json['RecDate'];
    locationID = json['LocationID'];
    productCode = json['ProductCode'];
    serialNo = json['SerialNo'];
    amount = json['Amount'];
    receipt = json['Receipt'];
    customerName = json['CustomerName'];
    customerCode = json['CustomerCode'];
    billingMobile = json['BillingMobile'];
    billingAddress1 = json['BillingAddress1'];
    productName = json['ProductName'];
    model = json['Model'];
    description = json['Description'];
    durationInMonths = json['DurationInMonths'];
    repairSequence = json['RepairSequence'];
    invWarrantyDetailsID = json['InvWarrantyDetailsID'];
    barCode = json['BarCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentID'] = this.documentID;
    data['RecDate'] = this.recDate;
    data['LocationID'] = this.locationID;
    data['ProductCode'] = this.productCode;
    data['SerialNo'] = this.serialNo;
    data['Amount'] = this.amount;
    data['Receipt'] = this.receipt;
    data['CustomerName'] = this.customerName;
    data['CustomerCode'] = this.customerCode;
    data['BillingMobile'] = this.billingMobile;
    data['BillingAddress1'] = this.billingAddress1;
    data['ProductName'] = this.productName;
    data['Model'] = this.model;
    data['Description'] = this.description;
    data['DurationInMonths'] = this.durationInMonths;
    data['RepairSequence'] = this.repairSequence;
    data['InvWarrantyDetailsID'] = this.invWarrantyDetailsID;
    data['BarCode'] = this.barCode;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'DocumentID': this.documentID,
      'RecDate': this.recDate,
      'LocationID': this.locationID,
      'productCode': this.productCode,
      'serialNo': this.serialNo,
      'amount': this.amount,
      'receipt': this.receipt,
      'customerName': this.customerName,
      'customerCode': this.customerCode,
      'billingMobile': this.billingMobile,
      'billingAddress1': this.billingAddress1,
      'productName': this.productName,
      'model': this.model,
      'description': this.description,
      'durationInMonths': this.durationInMonths,
      'repairSequence': this.repairSequence,
      'invWarrantyDetailsID': this.invWarrantyDetailsID,
      'barCode': this.barCode,
    };
  }

  factory TransactionDoc.fromMap(Map<String, dynamic> map) {
    return TransactionDoc(
      documentID: map['documentID'] as int,
      recDate: map['recDate'] as String,
      locationID: map['locationID'] as String,
      productCode: map['productCode'] as String,
      serialNo: map['serialNo'] as String,
      amount: map['amount'] as double,
      receipt: map['receipt'] as String,
      customerName: map['customerName'] as String,
      customerCode: map['customerCode'] as String,
      billingMobile: map['billingMobile'] as String,
      billingAddress1: map['billingAddress1'] as String,
      productName: map['productName'] as String,
      model: map['model'] as String,
      description: map['description'] as String,
      durationInMonths: map['durationInMonths'] as int,
      repairSequence: map['repairSequence'] as int,
      invWarrantyDetailsID: map['invWarrantyDetailsID'] as String,
      barCode: map['barCode'] as String,
    );
  }
}