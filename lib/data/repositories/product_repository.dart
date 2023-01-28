import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:medicadmin/data/models/category_model.dart';
import 'package:medicadmin/data/models/product_model.dart';
import 'package:medicadmin/data/models/style_model.dart';
import 'package:medicadmin/data/repositories/api/api.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

import '../models/prescription_model.dart';

class ProductRepository {
  var uuid = const Uuid();
  Api api = Api();
  void fetchProduct({required String adminId}) async {
    api.sendRequest.get("/api/product");
  }

  Future<Response> addProduct({
    required String title,
    required String categoryid,
    required String description,
    required String adminId,
    required List<Map<String, dynamic>> styles,
  }) async {
    log(styles.toString());
    Response? res;
    var data = {
      "title": title,
      "adminid": adminId,
      "category": categoryid,
      "description": description,
      "styles": styles
    };
    try {
      res = await api.sendRequest.post("/api/product/", data: data);
      //log(res.data.toString());

      // product = Product.fromJson(res.data["data"]);
    } catch (e) {
      throw e.toString();
    }
    return res;
  }

  //get product by admin
  Future<List<Product>> getProduct({required String adminid}) async {
    List<Product> productList = [];
    var data = {"adminid": adminid};
    try {
      Response res =
          await api.sendRequest.post("/api/product/getbyadminid", data: data);
      List<dynamic> resList = res.data["data"];
      productList = resList.map((e) => Product.fromJson(e)).toList();
      // product = Product.fromJson(res.data["data"]);
    } catch (e) {
      throw e.toString();
    }
    return productList;
  }

  //category
  Future<Category?> addCategory({required String title}) async {
    Category? category;
    var data = {"categoryid": uuid.v1(), "title": title};
    try {
      Response res = await api.sendRequest.post("/api/category/", data: data);
      if (res.data["data"] != null) {
        category = Category.fromJson(res.data["data"]);
      }
    } catch (e) {
      throw e.toString();
    }
    return category;
  }

  Future<List<Category>?> fetchCategory() async {
    List<Category>? categoryList;
    try {
      Response res = await api.sendRequest.get("/api/category/");
      //  log(res.data.toString());
      if (res.data["data"] != null) {
        List<dynamic> categoryMaps = res.data["data"];
        categoryList = categoryMaps.map((e) => Category.fromJson(e)).toList();
      }
    } catch (e) {
      throw e.toString();
    }
    return categoryList;
  }

  //uploading images
  //path finder
  Future<List<MultipartFile>> pathFinder(List<File> images) async {
    List<MultipartFile> paths = [];

    for (int i = 0; i < images.length; i++) {
      var path = await MultipartFile.fromFile(images[i].path);
      paths.add(path);
    }
    return paths;
  }

  //uploader
  Future<List<dynamic>> uploadImages({required List<File> images}) async {
    List<dynamic> urls = [];
    var paths = await pathFinder(images);
    FormData formData = FormData.fromMap({"images": paths});

    try {
      var res =
          await api.sendRequest.post("/api/file/multiple", data: formData);
      log(res.data.toString());
      urls = res.data["data"];
    } catch (e) {
      throw e.toString();
    }
    return urls;
  }

  //update producta
  Future<Response> updateProduct({required Map<String, dynamic> data}) async {
    log(data.toString());
    Response? res;
    try {
      res = await api.sendRequest.put("/api/product", data: data);
      log(res.data.toString());
    } catch (e) {
      throw e.toString();
    }
    return res;
  }

  //add style
  Future<Styles> addStyle({required Styles style}) async {
    var data = style.toJson();
    Styles s;
    try {
      Response res =
          await api.sendRequest.post("/api/product/addstyle", data: data);
      s = Styles.fromJson(res.data["data"]);
    } catch (e) {
      throw e.toString();
    }
    return s;
  }

  //update style
  Future<Styles> updateStyle({required Styles style}) async {
    var data = style.toJson();
    Styles s;
    try {
      Response res =
          await api.sendRequest.post("/api/product/updatestyle", data: data);
      s = Styles.fromJson(res.data["data"]);
    } catch (e) {
      throw e.toString();
    }
    return s;
  }

  //deleteStyle
  Future<Styles> deleteStyle({required String styleid}) async {
    var data = {"styleid": styleid};
    Styles style;
    try {
      Response res =
          await api.sendRequest.post("/api/product/deletestyle", data: data);
      style = Styles.fromJson(res.data["data"]);
    } catch (e) {
      throw e.toString();
    }
    return style;
  }

  //delete product
  Future<bool> deleteProduct({required String productid}) async {
    var data = {"productid": productid};
    bool success = false;
    try {
      Response res = await api.sendRequest.delete("/api/product/", data: data);
      success = res.data["success"];
    } catch (e) {
      throw e.toString();
    }
    return success;
  }

  //fetch orders
  //fetch order
  Future<Response> fetchOrder(String adminid) async {
    Response res;

    try {
      res = await api.sendRequest.get("/api/order/getbyadmin/$adminid");
      // Map<String, dynamic>? cartraw = res.data["data"];
      //log(cartraw.toString());
      //cart = cartraw != null ? CartModel.fromJson(cartraw) : null;
    } catch (e) {
      throw e.toString();
    }
    return res;
  }

  //order status update
  Future<Response> orderupdate(String orderid, int staus) async {
    var data = {"orderid": orderid, "status": staus};
    Response res;
    try {
      res = await api.sendRequest.put("/api/order/updatestatus", data: data);
    } catch (e) {
      throw (e.toString());
    }
    return res;
  }

  //get prescription i
  Future<List<PrescrModel>> getAllPrescription() async {
    List<PrescrModel> list;

    try {
      Response res =
          await api.sendRequest.get("/api/user/fetchprescriptionbyadmin");
      List data = res.data["data"];
      log(data.toString());
      list = data.map((e) => PrescrModel.fromJson(e)).toList();
    } catch (e) {
      throw e.toString();
    }

    return list;
  }

  Future<PrescrModel> updatePrescription(PrescrModel prescrModel) async {
    try {
      Response res = await api.sendRequest
          .post("/api/user/updateprescription", data: prescrModel.toJson());
      var data = res.data["data"];
      log(data.toString());
      prescrModel = PrescrModel.fromJson(data);
    } catch (e) {
      throw e.toString();
    }

    return prescrModel;
  }
}
