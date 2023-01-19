class AdminModel {
  String? sId;
  String? adminuserid;
  String? name;
  String? medicalstorename;
  String? storeaddress;
  List<dynamic>? notificationIds;
  int? iV;

  AdminModel(
      {this.sId,
      this.adminuserid,
      this.name,
      this.medicalstorename,
      this.storeaddress,
      this.notificationIds,
      this.iV});

  AdminModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    adminuserid = json['adminuserid'];
    name = json['name'];
    medicalstorename = json['medicalstorename'];
    storeaddress = json['storeaddress'];
    notificationIds = json['notificationIds'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['adminuserid'] = adminuserid;
    data['name'] = name;
    data['medicalstorename'] = medicalstorename;
    data['storeaddress'] = storeaddress;
    data['notificationIds'] = notificationIds;
    data['__v'] = iV;
    return data;
  }
}
