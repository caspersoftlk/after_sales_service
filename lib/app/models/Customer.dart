class Customer {
  String? customerCode;
  String? customerName;
  String? billingAddress1;
  String? billingAddress2;
  String? billingAddress3;
  String? billingTelephone;
  String? billingMobile;

  Customer(
      {this.customerCode,
        this.customerName,
        this.billingAddress1,
        this.billingAddress2,
        this.billingAddress3,
        this.billingTelephone,
        this.billingMobile});

  Customer.fromJson(Map<String, dynamic> json) {
    customerCode = json['CustomerCode'];
    customerName = json['CustomerName'];
    billingAddress1 = json['BillingAddress1'];
    billingAddress2 = json['BillingAddress2'];
    billingAddress3 = json['BillingAddress3'];
    billingTelephone = json['BillingTelephone'];
    billingMobile = json['BillingMobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerCode'] = this.customerCode;
    data['CustomerName'] = this.customerName;
    data['BillingAddress1'] = this.billingAddress1;
    data['BillingAddress2'] = this.billingAddress2;
    data['BillingAddress3'] = this.billingAddress3;
    data['BillingTelephone'] = this.billingTelephone;
    data['BillingMobile'] = this.billingMobile;
    return data;
  }
}