class MongoUser {
  MongoUser({
    required this.name,
    required this.fireuseruid,
    required this.recievername,
    required this.phoneNumber,
    required this.city,
    required this.pincode,
    required this.address,
  });
  String? sId;
  String? name;
  String? address;
  String? fireuseruid;
  String? type;
  String? email;
  String? recievername;
  String? phoneNumber;
  String? city;
  String? pincode;

  int? V;
  String? addedon;

  MongoUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    fireuseruid = json['fireuseruid'];
    address = json['address'];
    type = json['type'];
    email = json['email'];
    recievername = json['recievername'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    pincode = json['pincode'];

    V = json['__v'];
    addedon = json['addedon'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['name'] = name;
    _data['fireuseruid'] = fireuseruid;
    _data['address'] = address;

    _data['recievername'] = recievername;
    _data['phoneNumber'] = phoneNumber;
    _data['city'] = city;
    _data['pincode'] = pincode;

    return _data;
  }
}
