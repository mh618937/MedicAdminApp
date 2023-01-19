import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicadmin/data/models/category_model.dart';
import 'package:medicadmin/data/models/style_model.dart';
import 'package:medicadmin/data/repositories/product_repository.dart';

import '../data/models/order_model.dart';
import '../data/models/product_model.dart';

class ProductOrdersProvider with ChangeNotifier {
//category related
  ProductRepository productRepository = ProductRepository();
  List<Category>? categoryList;
  void addCategory({required String title}) async {
    await productRepository.addCategory(title: title);
  }

  bool categoryListLoading = true;
  void fetchCategories() async {
    categoryList = await productRepository.fetchCategory();
    // log("category of index 1 :" + categoryList![1].title.toString());
    categoryListLoading = false;
    notifyListeners();
  }

  bool urlrecieved = false;
  Future<List<dynamic>> uploadImages({required List<File> images}) async {
    List<dynamic> imageurls = [];
    imageurls.clear();
    imageurls = await productRepository.uploadImages(images: images);
    return imageurls;
  }

  //add product
  bool productUploaded = false;
  void uploadProduct(
      {required String title,
      required String categoryid,
      required String description,
      required String adminId,
      required List<Map<String, dynamic>> styles,
      required List<File> images}) async {
    await uploadImages(images: images).then((value) {
      styles[0]["images"] = value;
    }).then((value) {
      productRepository.addProduct(
          title: title,
          categoryid: categoryid,
          description: description,
          adminId: adminId,
          styles: styles);
      productsloading = true;
      productUploaded = true;
      notifyListeners();
    });
  }

  //get product by admin
  List<Product> productList = [];
  bool productsloading = true;
  getProduct({required String adminid}) async {
    productList.clear();
    productList = await productRepository.getProduct(adminid: adminid);
    productsloading = false;

    notifyListeners();
  }

//add style
  Future<Styles> addStyle(
      {required Styles style, required List<File> images}) async {
    Styles s;
    style.images = await uploadImages(images: images);
    s = await productRepository.addStyle(style: style);
    return s;
  }

//update style
  Future<Styles> updateStyle(
      {required Styles style, required List<File> images}) async {
    Styles s;
    if (images.isNotEmpty) {
      style.images = await uploadImages(images: images);
    }
    s = await productRepository.updateStyle(style: style);
    productUploaded = true;
    productsloading = true;
    notifyListeners();
    return s;
  }

//delete Style
  Future<Styles> deleteStyle({required String styleid}) async {
    Styles s;
    s = await productRepository.deleteStyle(styleid: styleid);
    return s;
  }
//product update

  updateProductwithaddStyle({
    required Product product,
    required Styles newstyle,
    List<File>? images,
  }) async {
    List<String> styleIdsList = [];
    for (int i = 0; i < product.styles!.length; i++) {
      styleIdsList.add(product.styles![i].sId!);
    }
    if (images != null) {
      await addStyle(style: newstyle, images: images)
          .then((value) => styleIdsList.add(value.sId!))
          .then((value) {
        var data = {"productid": product.productid, "styles": styleIdsList};
        productRepository.updateProduct(data: data);
        productUploaded = true;
        productsloading = true;
        notifyListeners();
      });
    }
  }

  //updateProductwithdeleStyle
  updateProductWithDeleteStyle(
      {required Product product, required String styleid}) async {
    List<String> styleSids = [];
    for (int i = 0; i < product.styles!.length; i++) {
      if (product.styles![i].styleid != styleid) {
        styleSids.add(product.styles![i].sId!);
      }
    }
    await deleteStyle(styleid: styleid).then((value) {
      var data = {"productid": product.productid, "styles": styleSids};
      productRepository.updateProduct(data: data);
      productUploaded = true;
      productsloading = true;
      notifyListeners();
    });
  }

  //update product name
  updateProduct(
      {required String productid,
      required String categoryid,
      required String productname,
      required String description}) async {
    var data = {
      "productid": productid,
      "category": categoryid,
      "title": productname,
      "description": description
    };
    await productRepository.updateProduct(data: data).then((value) {
      productUploaded = true;
      productsloading = true;
      notifyListeners();
    });
  }

  //delete product
  deleteProduct({required String productid}) async {
    await productRepository.deleteProduct(productid: productid).then((value) {
      productUploaded = true;
      productsloading = true;
      notifyListeners();
    });
  }

  //fetch orders
  List<OrderModel> orders = [];
  bool orderloaded = false;
  fetchOrder(
    String usersId,
  ) async {
    orders.clear();
    Response res;
    res = await productRepository.fetchOrder(usersId);
    List data = res.data["data"];
    orders = data.map((e) => OrderModel.fromJson(e)).toList();
    orders.sort((a, b) =>
        DateTime.parse(b.addedon!).compareTo(DateTime.parse(a.addedon!)));
    log("orderlength ${orders.length}");
    orderloaded = true;
    notifyListeners();
  }

  void resetOrderloaded() {
    orderloaded = false;
  }

  //update order status
  Future<Response> updateOrderStatus(String orderid, int status) async {
    Response res;
    res = await productRepository.orderupdate(orderid, status);
    return res;
  }
}
