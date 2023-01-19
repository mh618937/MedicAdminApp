import 'product_model.dart';
import 'style_model.dart';

class Items {
  String? sId;
  String? cartid;
  Product? product;
  Styles? style;
  int? quantity;
  String? cartitemid;
  String? addedon;

  Items({
    this.sId,
    this.cartid,
    this.product,
    this.style,
    this.quantity,
    this.cartitemid,
    this.addedon,
  });

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cartid = json['cartid'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    style = json['style'] != null ? Styles.fromJson(json['style']) : null;
    quantity = json['quantity'];
    cartitemid = json['cartitemid'];
    addedon = json['addedon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['cartid'] = cartid;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (style != null) {
      data['style'] = style!.toJson();
    }
    data['quantity'] = quantity;
    data['cartitemid'] = cartitemid;
    data['addedon'] = addedon;

    return data;
  }
}
