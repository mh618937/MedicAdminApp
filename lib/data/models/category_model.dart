class Category {
  String? sId;
  String? categoryid;
  String? title;
  String? addedon;
  int? iV;

  Category({this.sId, this.categoryid, this.title, this.addedon, this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryid = json['categoryid'];
    title = json['title'];
    addedon = json['addedon'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['categoryid'] = categoryid;
    data['title'] = title;
    data['addedon'] = addedon;

    return data;
  }
}
