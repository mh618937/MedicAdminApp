import 'cart_item_model.dart';
import 'mongo_user.dart';

class OrderModel {
  String? sId;
  MongoUser? user;
  List<Items>? items;
  String? adminid;
  int? totalordervalue;
  int? status;
  String? orderid;
  String? addedon;
  int? iV;

  OrderModel(
      {this.sId,
      this.user,
      this.items,
      this.status,
      this.orderid,
      this.adminid,
      this.totalordervalue,
      this.addedon,
      this.iV});

  OrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? MongoUser.fromJson(json['user']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    adminid = json["adminid"];
    totalordervalue = json["totalordervalue"];
    status = json['status'];
    orderid = json['orderid'];
    addedon = json['addedon'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data["adminid"] = adminid;
    data["totalordervalue"] = totalordervalue;
    data['status'] = status;
    data['orderid'] = orderid;
    data['addedon'] = addedon;
    data['__v'] = iV;
    return data;
  }
}
