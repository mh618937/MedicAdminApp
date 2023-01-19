class NotificationIdModel {
  String? token;
  int? index;

  NotificationIdModel({this.token, this.index});

  NotificationIdModel.fromMap(Map<String, dynamic> map) {
    map["token"] = token;
    map['index'] = index;
  }

  Map<String, dynamic> toMap() {
    return {"token": token, "index": index};
  }
}
