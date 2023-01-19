import 'package:medicadmin/data/models/style_model.dart';

import 'category_model.dart';

class Product {
  String? sId;
  String? productid;
  String? title;
  String? description;
  Category? category;
  List<Styles>? styles;
  String? addedon;
  int? iV;

  Product(
      {this.sId,
      this.productid,
      this.title,
      this.description,
      this.category,
      this.styles,
      this.addedon,
      this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productid = json['productid'];
    title = json['title'];
    description = json['description'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['styles'] != null) {
      styles = <Styles>[];
      json['styles'].forEach((v) {
        styles!.add(Styles.fromJson(v));
      });
    }
    addedon = json['addedon'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['productid'] = productid;
    data['title'] = title;
    data['description'] = description;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (styles != null) {
      data['styles'] = styles!.map((v) => v.toJson()).toList();
    }
    data['addedon'] = addedon;

    return data;
  }
}
