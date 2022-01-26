class ServiceOrder {
  ServiceOrder({
      this.id, 
      this.jobType, 
      this.isInvoicedBase, 
      this.isOverThePhone, 
      this.isWarrantyExpired, 
      this.isPhysicalDamage, 
      this.inspection, 
      this.techName, 
      this.techLastName, 
      this.techId, 
      this.jId, 
      this.jName, 
      this.jDes, 
      this.technicalInspection, 
      this.remark, 
      this.isClaimableOrNot, 
      this.location, 
      this.invNo, 
      this.invDate, 
      this.documentId, 
      this.invCustomerCode, 
      this.invCustomerName, 
      this.invCustomerMobile, 
      this.invCustomerAddress, 
      this.invProductCode, 
      this.invProductName, 
      this.invProductModel, 
      this.invProductSerial, 
      this.createUser, 
      this.createDate, 
      this.updateUser, 
      this.updateDate, 
      this.jobRefId,
      this.freeServiceDate,this.isHandover, required this.cat});

  ServiceOrder.fromJson(dynamic json) {
    id = json['id'];
    jobType = json['jobType'];
    isInvoicedBase = json['isInvoicedBase'];
    isOverThePhone = json['isOverThePhone'];
    isWarrantyExpired = json['isWarrantyExpired'];
    isPhysicalDamage = json['isPhysicalDamage'];
    inspection = json['Inspection'];
    techName = json['techName'];
    techLastName = json['techLastName'];
    techId = json['techId'];
    jId = json['jId'];
    jName = json['jName'];
    jDes = json['jDes'];
    technicalInspection = json['technicalInspection'];
    remark = json['remark'];
    isClaimableOrNot = json['isClaimableOrNot'];
    location = json['location'];
    invNo = json['invNo'];
    invDate = json['invDate'];
    documentId = json['documentId'];
    invCustomerCode = json['invCustomerCode'];
    invCustomerName = json['invCustomerName'];
    invCustomerMobile = json['invCustomerMobile'];
    invCustomerAddress = json['invCustomerAddress'];
    invProductCode = json['invProductCode'];
    invProductName = json['invProductName'];
    invProductModel = json['invProductModel'];
    invProductSerial = json['invProductSerial'];
    createUser = json['createUser'];
    createDate = json['createDate'];
    updateUser = json['updateUser'];
    updateDate = json['updateDate'];
    freeServiceDate = json['freeServiceDate'];
    isHandover = json['isHandover'];
    jobRefId = json['jobRefId'];
    cat = json['cat'];
  }
  int? id;
  int? jobRefId;
  String? jobType;
  bool? isInvoicedBase;
  bool? isOverThePhone;
  bool? isWarrantyExpired;
  bool? isPhysicalDamage;
  bool? isHandover;
  String? inspection;
  String? techName;
  String? techLastName;
  int? techId;
  int? jId;
  String? jName;
  String? jDes;
  String? technicalInspection;
  String? remark;
  bool? isClaimableOrNot;
  String? location;
  String? invNo;
  String? invDate;
  int? documentId;
  String? invCustomerCode;
  String? invCustomerName;
  String? invCustomerMobile;
  String? invCustomerAddress;
  String? invProductCode;
  String? invProductName;
  String? invProductModel;
  String? invProductSerial;
  String? createUser;
  String? createDate;
  String? updateUser;
  String? updateDate;
  String? freeServiceDate;
  String? cat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['jobType'] = jobType;
    map['isInvoicedBase'] = isInvoicedBase;
    map['isOverThePhone'] = isOverThePhone;
    map['isWarrantyExpired'] = isWarrantyExpired;
    map['isPhysicalDamage'] = isPhysicalDamage;
    map['Inspection'] = inspection;
    map['techName'] = techName;
    map['techLastName'] = techLastName;
    map['techId'] = techId;
    map['jId'] = jId;
    map['jName'] = jName;
    map['jDes'] = jDes;
    map['technicalInspection'] = technicalInspection;
    map['remark'] = remark;
    map['isClaimableOrNot'] = isClaimableOrNot;
    map['location'] = location;
    map['invNo'] = invNo;
    map['invDate'] = invDate;
    map['documentId'] = documentId;
    map['invCustomerCode'] = invCustomerCode;
    map['invCustomerName'] = invCustomerName;
    map['invCustomerMobile'] = invCustomerMobile;
    map['invCustomerAddress'] = invCustomerAddress;
    map['invProductCode'] = invProductCode;
    map['invProductName'] = invProductName;
    map['invProductModel'] = invProductModel;
    map['invProductSerial'] = invProductSerial;
    map['createUser'] = createUser;
    map['createDate'] = createDate;
    map['updateUser'] = updateUser;
    map['updateDate'] = updateDate;
    map['freeServiceDate'] = freeServiceDate;
    map['isHandover'] = isHandover;
    map['jobRefId'] = jobRefId;
    map['cat'] = cat;
    return map;
  }

}