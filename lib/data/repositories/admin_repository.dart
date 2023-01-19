import 'package:dio/dio.dart';
import 'package:medicadmin/data/models/admin_model.dart';
import 'package:medicadmin/data/repositories/api/api.dart';

class AdminRepository {
  Api api = Api();
  Future<AdminModel?> fetchAdmin({required String uid}) async {
    // log("fetching admin");
    AdminModel? adminModel;
    var data = {"adminuserid": uid};
    try {
      // log("inside try");
      Response res = await api.sendRequest.post(
        "/api/admin/getadmin",
        data: data,
      );
      // log(res.data["data"].toString());
      if (res.data["data"] != null) {
        adminModel = AdminModel.fromJson(res.data["data"]);
        // log(adminModel.name!.toString());
      }
      return adminModel;
    } catch (e) {
      // log("error : $e");
      throw e.toString();
    }
  }

  Future<AdminModel> createAdmin(
      {required String adminid,
      required String name,
      required String medicalstorename,
      required String storeaddress}) async {
    // log("creating admin");
    // log(adminid);
    var data = {
      "adminuserid": adminid,
      "name": name,
      "medicalstorename": medicalstorename,
      "storeaddress": storeaddress
    };

    try {
      //log("inside try");
      Response res =
          await api.sendRequest.post("/api/admin/createadmin", data: data);
      // log(res.toString());
      //notification check

      var adminModel = AdminModel.fromJson(res.data);
      return adminModel;
    } catch (e) {
      //log("error : $e");
      throw e.toString();
    }
  }

  Future<AdminModel> updateAdmin(
      {required String adminid,
      required String name,
      required String medicalstorename,
      required List<dynamic> notificationids,
      required String storeaddress}) async {
    // log("creating admin");
    // log(adminid);
    var data = {
      "adminuserid": adminid,
      "name": name,
      "medicalstorename": medicalstorename,
      "storeaddress": storeaddress,
      "notificationIds": notificationids
    };

    try {
      //log("inside try");
      Response res =
          await api.sendRequest.put("/api/admin/updateadmin", data: data);
      // log(res.toString());
      var adminModel = AdminModel.fromJson(res.data);
      return adminModel;
    } catch (e) {
      //log("error : $e");
      throw e.toString();
    }
  }
}
