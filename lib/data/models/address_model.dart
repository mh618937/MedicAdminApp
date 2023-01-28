class AddressModel {
  String? recievername;
  String? address;
  String? phoneNumber;
  String? city;
  String? pincode;
  bool? isprimary = false;
  String? sId;
  String? addedon;
  String? userid;

  int? iV;

  AddressModel({
    this.recievername,
    this.address,
    this.phoneNumber,
    this.city,
    this.pincode,
    this.isprimary,
    this.userid,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    recievername = json['recievername'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    pincode = json['pincode'];
    isprimary = json['isprimary'];
    sId = json['_id'];
    addedon = json['addedon'];
    userid = json['userid'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recievername'] = recievername;
    data['address'] = address;
    data['phoneNumber'] = phoneNumber;
    data['city'] = city;
    data['pincode'] = pincode;

    data['userid'] = userid;

    return data;
  }
}
