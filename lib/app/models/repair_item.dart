class RepairItem {
  RepairItem({
      this.id, 
      this.jobId, 
      this.partId, 
      this.partQty, 
      this.costPrice, 
      this.sellingPrice, 
      this.discountAmt, 
      this.grossAmt, 
      this.netAmt, 
      this.remarks, 
      this.isVoid,
      this.isClaimable,});

  RepairItem.fromJson(dynamic json) {
    id = json['id'];
    jobId = json['jobId'];
    partId = json['partId'];
    partQty = json['partQty'];
    costPrice = json['costPrice'];
    sellingPrice = json['sellingPrice'];
    discountAmt = json['discountAmt'];
    grossAmt = json['grossAmt'];
    netAmt = json['netAmt'];
    remarks = json['remarks'];
    isVoid = json['isVoid'];
    isClaimable = json['isClaimable'];
  }
  int? id;
  int? jobId;
  int? partId;
  double? partQty;
  double? costPrice;
  double? sellingPrice;
  double? discountAmt;
  double? grossAmt;
  double? netAmt;
  String? remarks;
  int? isClaimable;
  int? isVoid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['jobId'] = jobId;
    map['partId'] = partId;
    map['partQty'] = partQty;
    map['costPrice'] = costPrice;
    map['sellingPrice'] = sellingPrice;
    map['discountAmt'] = discountAmt;
    map['grossAmt'] = grossAmt;
    map['netAmt'] = netAmt;
    map['remarks'] = remarks;
    map['isClaimable'] = isClaimable;
    map['isVoid'] = isVoid;
    return map;
  }

}