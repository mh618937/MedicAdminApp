import 'package:medicadmin/data/models/mongo_user.dart';

class PrescrModel {
  String? userid;
  List<String>? imageurls;
  int? status;
  Map? address;
  MongoUser? user;
  String? sId;
  int? paymenttype;
  bool? paymentstatus;
  String? paymentid;
  int? deliverycharge;
  int? netamount;
  String? prescriptionid;
  String? note;
  bool? codenabled;
  String? addedon;
  int? iV;

  PrescrModel(
      {this.userid,
      this.imageurls,
      this.status,
      this.address,
      this.user,
      this.netamount,
      this.deliverycharge,
      this.codenabled,
      this.prescriptionid,
      this.note});

  PrescrModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    imageurls = json['imageurls'].cast<String>();
    status = json['status'];
    address = json['address'];
    paymenttype = json['paymenttype'];
    paymentstatus = json['paymentstatus'];
    codenabled = json["codenabled"];
    paymentid = json['paymentid'];
    deliverycharge = json["deliverycharge"];
    netamount = json["netamount"];
    user = json['user'] != null ? MongoUser.fromJson(json['user']) : null;
    sId = json['_id'];
    note = json["note"];
    prescriptionid = json['prescriptionid'];
    addedon = json['addedon'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['imageurls'] = imageurls;
    data['status'] = status;
    if (user != null) {
      data['user'] = user!.sId;
    }
    data["netamount"] = netamount;
    data["codenabled"] = codenabled;
    data["deliverycharge"] = deliverycharge;
    data['address'] = address;
    data["note"] = note;
    data["prescriptionid"] = prescriptionid;
    // data['user'] = user;

    return data;
  }
}
