import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Styles {
  String? sId;
  String? styleid;
  String? title;
  int? price;
  int? quantity;
  List<dynamic>? images;
  bool? inStock;
  //List<Null>? ratings;
  int? iV;

  Styles(
      {this.sId,
      this.styleid,
      this.title,
      this.price,
      this.quantity,
      this.images,
      this.inStock,
      //this.ratings,
      this.iV});

  Styles.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    styleid = json['styleid'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
    images = json['images'].cast<String>();
    inStock = json['inStock'];
    // if (json['ratings'] != null) {
    //   ratings = <Null>[];
    //   json['ratings'].forEach((v) {
    //     ratings!.add(new Null.fromJson(v));
    //   });
    // }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['styleid'] = styleid;
    data['title'] = title;
    data['price'] = price;
    data['quantity'] = quantity;
    data['images'] = images;
    data['inStock'] = inStock;
    // if (ratings != null) {
    //   data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    // }

    return data;
  }
}
