import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicadmin/data/models/product_model.dart';
import 'package:medicadmin/data/models/style_model.dart';
import 'package:medicadmin/services/adminprovider.dart';
import 'package:medicadmin/services/products_orders_provider.dart';
import 'package:medicadmin/utils/utilities.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadProduct extends StatefulWidget {
  const UploadProduct({super.key, required this.router, this.product});
  final int router;
  final Product? product;

  @override
  State<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  TextEditingController categoryTitleController = TextEditingController();
  TextEditingController productTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController styleTitleController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  Uuid uui = const Uuid();
  String? categoryid;
  String title = "Select";
  List<File> images = [];
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  setcontroller({required int index}) {
    if (widget.router == 2) {
      styleTitleController.text =
          widget.product!.styles![index].title.toString();
      quantityController.text =
          widget.product!.styles![index].quantity.toString();
      priceController.text = widget.product!.styles![index].price.toString();
    }
    if (widget.router == 1) {
      productTitleController.text = widget.product!.title.toString();
      title = widget.product!.category!.title.toString();
      categoryid = widget.product!.category!.sId.toString();
      descriptionController.text = widget.product!.description.toString();
    }
    setState(() {});
  }

  int indx = 0;
  int? router;
  @override
  void initState() {
    router = widget.router;
    Provider.of<ProductOrdersProvider>(context, listen: false)
        .fetchCategories();
    setcontroller(index: indx);
    if (widget.router == 2) {
      selectedStyle = widget.product!.styles![indx].title.toString();
    }
    super.initState();
  }

  List<Map<String, dynamic>> styles = [];
  int stater = 1;
  String? selectedStyle;
  @override
  void dispose() {
    categoryTitleController.dispose();
    priceController.dispose();
    quantityController.dispose();
    productTitleController.dispose();
    styleTitleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductOrdersProvider>(context, listen: true);
    // bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;
    // log(" key $isKeyboardOpen");
    // log(categoryid.toString());
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.greenAccent,
              flexibleSpace: Container(),
              title: widget.router == 0
                  ? const Text("Add Product")
                  : widget.router == 1
                      ? const Text("Update Product")
                      : widget.router == 2
                          ? const Text("Update Veriety")
                          : const Text("Add Veriety"),
              centerTitle: true,
            )),
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.miniEndDocked,
        // floatingActionButton: Container(
        //     child: ElevatedButton(
        //         //color: Colors.green,
        //         child: const Text("+ Veriety"),
        //         onPressed: () {
        //           setState(() {
        //             styler += 1;
        //           });
        //         })),
        body: SingleChildScrollView(
          child: stater == 1
              ? Form(
                  key: formkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      widget.router == 2 || widget.router == 3
                          ? Text("Product - ${widget.product!.title}")
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.router == 3
                          ? Center(
                              child: Text(
                                  "Veriety No. - ${widget.product!.styles!.length + 1}"),
                            )
                          : const SizedBox(),
                      widget.router == 2
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Stack(
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Select Veriety - ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(10),
                                      child: DropdownButton(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          isDense: true,
                                          hint: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(selectedStyle!),
                                          ),
                                          //dropdownColor: Colors.amber,
                                          items:
                                              widget.product!.styles!.map((e) {
                                            return DropdownMenuItem(
                                                value: e.title,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  //width: double.infinity,

                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors
                                                          .green.shade200),
                                                  child: Text(
                                                    e.title!,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ));
                                          }).toList(),
                                          onChanged: ((value) {
                                            setState(() {
                                              for (int i = 0;
                                                  i <
                                                      widget.product!.styles!
                                                          .length;
                                                  i++) {
                                                if (widget.product!.styles![i]
                                                        .title ==
                                                    value) {
                                                  indx = i;
                                                  setcontroller(index: indx);
                                                }
                                              }
                                              selectedStyle = value!;
                                            });
                                          })),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      widget.router == 2
                          ? widget.product!.styles![indx].images != null
                              ? CarouselSlider(
                                  items: widget.product!.styles![indx].images!
                                      .map((i) {
                                    return Builder(
                                        builder: (context) => Image.network(
                                              i,
                                              fit: BoxFit.cover,
                                              height: 200,
                                            ));
                                  }).toList(),
                                  options: CarouselOptions(
                                      viewportFraction: 1, height: 200),
                                )
                              : GestureDetector(
                                  onTap: () => selectImages(),
                                  child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      borderPadding: const EdgeInsets.all(15),
                                      radius: const Radius.circular(15),
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        width: double.infinity,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            // color: Colors.amberAccent,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.folder_open),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Add Product Images",
                                              style: TextStyle(
                                                  color: Colors.black45),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      )),
                                )
                          : const SizedBox(),
                      widget.router == 0 || widget.router == 3
                          ? images.isNotEmpty
                              ? CarouselSlider(
                                  items: images.map((i) {
                                    return Builder(
                                        builder: (context) => Image.file(
                                              i,
                                              fit: BoxFit.cover,
                                              height: 200,
                                            ));
                                  }).toList(),
                                  options: CarouselOptions(
                                      viewportFraction: 1, height: 200),
                                )
                              : GestureDetector(
                                  onTap: () => selectImages(),
                                  child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      borderPadding: const EdgeInsets.all(15),
                                      radius: const Radius.circular(15),
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        width: double.infinity,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            // color: Colors.amberAccent,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.folder_open),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Add Product Images",
                                              style: TextStyle(
                                                  color: Colors.black45),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      )),
                                )
                          : const SizedBox(),
                      widget.router == 0 || widget.router == 1
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: TextFormField(
                                controller: productTitleController,
                                decoration: InputDecoration(
                                    label: const Text("Product Name"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                validator: (value) {
                                  if (value!.length < 3 || value.isEmpty) {
                                    return "Please Enter Product Name";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            )
                          : const SizedBox(),
                      //dropdown

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: provider.categoryListLoading
                            ? const SizedBox(
                                height: 20, child: CircularProgressIndicator())
                            : (widget.router == 0 || widget.router == 1)
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Stack(
                                      children: [
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Select Category",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: DottedBorder(
                                            borderType: BorderType.RRect,
                                            radius: const Radius.circular(10),
                                            child: DropdownButton(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                isDense: true,
                                                hint: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(title),
                                                ),
                                                //dropdownColor: Colors.amber,
                                                items: provider.categoryList!
                                                    .map((e) {
                                                  return DropdownMenuItem(
                                                      value: e.title,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        //width: double.infinity,

                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: Colors.green
                                                                .shade200),
                                                        child: Text(
                                                          e.title!,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ));
                                                }).toList(),
                                                onChanged: ((value) {
                                                  for (int i = 0;
                                                      i <
                                                          provider.categoryList!
                                                              .length;
                                                      i++) {
                                                    if (provider
                                                            .categoryList![i]
                                                            .title ==
                                                        value) {
                                                      setState(() {
                                                        title = value!;
                                                        categoryid = provider
                                                            .categoryList![i]
                                                            .sId;
                                                        log(categoryid!);
                                                      });
                                                    }
                                                  }
                                                })),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                      ),
                      //verietyname
                      widget.router == 1
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: TextFormField(
                                controller: styleTitleController,
                                decoration: InputDecoration(
                                    label: const Text("Product Veriety Name"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                validator: (value) {
                                  if (value!.length < 3 || value.isEmpty) {
                                    return "Please Enter Product Veriety Name";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),

                      const SizedBox(
                        height: 10,
                      ),
                      //quantity
                      widget.router == 1
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: quantityController,
                                decoration: InputDecoration(
                                    label:
                                        const Text("Quantity of This Veriety"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Quantity of This Product You Have";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.router == 1
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: priceController,
                                decoration: InputDecoration(
                                    label: const Text("Price of This Veriety"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Product Price";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                      widget.router == 0 || widget.router == 1
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: TextFormField(
                                maxLines: 7,
                                controller: descriptionController,
                                decoration: InputDecoration(
                                    label: const Text("Description"),
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                validator: (value) {
                                  if (value!.length < 3 || value.isEmpty) {
                                    return "Please Write a Description";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      CupertinoButton(
                          color: Colors.greenAccent,
                          child: const Text("Submit"),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              if (images.isEmpty &&
                                      widget.router != 2 &&
                                      widget.router != 1 ||
                                  images.isEmpty && widget.router == 0) {
                                showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                          content: Text(
                                            "Please Add Images",
                                            textAlign: TextAlign.center,
                                          ),
                                        ));
                              } else if (title == "Select" &&
                                  (widget.router == 0 || widget.router == 1)) {
                                showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                          content: Text(
                                              "Please select Category",
                                              textAlign: TextAlign.center),
                                        ));
                              } else {
                                Map<String, dynamic> style = {};
                                Map<String, dynamic> updatestyle = {};
                                if (widget.router == 3 || widget.router == 0) {
                                  //Product product = widget.product!;
                                  style = {
                                    "styleid": uui.v1(),
                                    "title": styleTitleController.text.trim(),
                                    "price":
                                        int.parse(priceController.text.trim()),
                                    "quantity": int.parse(
                                        quantityController.text.trim()),
                                    "images": [],
                                    "inStock": true,
                                  };
                                }
                                if (widget.router == 2) {
                                  Product product = widget.product!;
                                  updatestyle = {
                                    "styleid": product.styles![indx].styleid,
                                    "title": styleTitleController.text.trim(),
                                    "price":
                                        int.parse(priceController.text.trim()),
                                    "quantity": int.parse(
                                        quantityController.text.trim()),
                                    "images": product.styles![indx].images,
                                    "inStock": true,
                                  };
                                }
                                styles = [style];

                                //add product
                                if (widget.router == 0) {
                                  provider.uploadProduct(
                                      title: productTitleController.text.trim(),
                                      categoryid: categoryid!,
                                      description:
                                          descriptionController.text.trim(),
                                      adminId: usertoken!.uid,
                                      images: images,
                                      styles: styles);
                                }
                                //update product
                                if (widget.router == 1) {
                                  Product product = widget.product!;
                                  //log(widget.router.toString());
                                  provider.updateProduct(
                                      productid: product.productid!,
                                      categoryid: categoryid!,
                                      productname:
                                          productTitleController.text.trim(),
                                      description:
                                          descriptionController.text.trim());
                                }
                                // update style
                                if (widget.router == 2) {
                                  //log(widget.router.toString());
                                  provider.updateStyle(
                                      style: Styles.fromJson(updatestyle),
                                      images: images);
                                }

                                ///add style in a product
                                if (widget.router == 3) {
                                  Product product = widget.product!;
                                  //log(widget.router.toString());
                                  provider.updateProductwithaddStyle(
                                      product: product,
                                      images: images,
                                      newstyle: Styles.fromJson(style));
                                }
                                setState(() {
                                  stater = 2;
                                });
                              }
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ))
              : !provider.productUploaded
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: const Center(
                            child: Icon(
                              Icons.done_outlined,
                              color: Colors.green,
                              size: 200,
                            ),
                          ),
                        ),
                        CupertinoButton(
                            color: Colors.greenAccent,
                            child: const Text("Done"),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
        ));
  }
}
