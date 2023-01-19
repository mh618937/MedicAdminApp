import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:medicadmin/data/models/style_model.dart';

import 'package:medicadmin/screens/screens_on_homepage/upload_product.dart';
import 'package:medicadmin/services/adminprovider.dart';
import 'package:medicadmin/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../../services/products_orders_provider.dart';

class ListedProduct extends StatefulWidget {
  const ListedProduct({
    super.key,
  });

  @override
  State<ListedProduct> createState() => _ListedProductState();
}

class _ListedProductState extends State<ListedProduct> {
  @override
  Widget build(BuildContext context) {
    ProductOrdersProvider provider =
        Provider.of<ProductOrdersProvider>(context);
    if (provider.productsloading) {
      provider.getProduct(adminid: usertoken!.uid);
    }
    return provider.productsloading == false
        ? provider.productList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: provider.productList.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 244, 234, 207),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onLongPress: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              "Delete?",
                                              textAlign: TextAlign.center,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      provider.deleteProduct(
                                                          productid: provider
                                                              .productList[
                                                                  index]
                                                              .productid!);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.redAccent),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              193,
                                                              184,
                                                              184)),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ));
                            },
                            // onTap: () => Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ProductDetails(
                            //             product: provider.productList[index]))),
                            contentPadding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            title: Stack(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Product Name - "),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      provider.productList[index].title
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            subtitle: Column(
                              children: [
                                Stack(
                                  children: [
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Product Category - "),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(provider
                                          .productList[index].category!.title
                                          .toString()),
                                    )
                                  ],
                                ),
                                Stack(children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Product Verities - "),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.01,
                                        15,
                                        0,
                                        0),
                                    child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: provider
                                                .productList[index]
                                                .styles!
                                                .length,
                                            itemBuilder: (context, i) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () async {
                                                          await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                        content:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            const Text(
                                                                              "Delete?",
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                TextButton(
                                                                                    onPressed: () {
                                                                                      provider.updateProductWithDeleteStyle(product: provider.productList[index], styleid: provider.productList[index].styles![i].styleid!);
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: const Text(
                                                                                      "Yes",
                                                                                      style: TextStyle(color: Colors.redAccent),
                                                                                    )),
                                                                                TextButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: const Text(
                                                                                      "No",
                                                                                      style: TextStyle(color: Color.fromARGB(255, 193, 184, 184)),
                                                                                    ))
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ));
                                                        },
                                                        icon: const Icon(
                                                          Icons.delete,
                                                          color:
                                                              Colors.redAccent,
                                                        )),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${i + 1}. ${provider.productList[index].styles![i].title.toString()}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Text(
                                                            "    Price : ${provider.productList[index].styles![i].price.toString()} ",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Text(
                                                            "    Quantity : ${provider.productList[index].styles![i].quantity.toString()}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        const Text("inStock"),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        FlutterSwitch(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.14,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.03,
                                                          valueFontSize:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.01,
                                                          toggleSize: 10.0,
                                                          value: provider
                                                              .productList[
                                                                  index]
                                                              .styles![i]
                                                              .inStock!,
                                                          borderRadius: 15.0,
                                                          padding: 5.0,
                                                          activeText: "YES",
                                                          activeTextColor:
                                                              Colors.white,
                                                          activeColor:
                                                              const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  2,
                                                                  240,
                                                                  180),
                                                          activeIcon:
                                                              const Icon(
                                                            Icons
                                                                .done_outline_rounded,
                                                            color: Colors
                                                                .greenAccent,
                                                          ),
                                                          inactiveText: "NO",
                                                          inactiveTextColor:
                                                              const Color
                                                                      .fromARGB(
                                                                  221,
                                                                  53,
                                                                  29,
                                                                  21),
                                                          showOnOff: true,
                                                          onToggle: (val) {
                                                            setState(() {
                                                              var style = {
                                                                "styleid": provider
                                                                    .productList[
                                                                        index]
                                                                    .styles![i]
                                                                    .styleid,
                                                                "title": provider
                                                                    .productList[
                                                                        index]
                                                                    .styles![i]
                                                                    .title,
                                                                "price": provider
                                                                    .productList[
                                                                        index]
                                                                    .styles![i]
                                                                    .price,
                                                                "quantity": provider
                                                                    .productList[
                                                                        index]
                                                                    .styles![i]
                                                                    .quantity,
                                                                "images": provider
                                                                    .productList[
                                                                        index]
                                                                    .styles![i]
                                                                    .images,
                                                                "inStock": val,
                                                              };
                                                              provider.updateStyle(
                                                                  style: Styles
                                                                      .fromJson(
                                                                          style),
                                                                  images: []);
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            })),
                                  ),
                                ]),
                                Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                      child: const Text(
                                        "Add Veriety",
                                        style: TextStyle(
                                            color: Colors.greenAccent),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UploadProduct(
                                                      router: 3,
                                                      product: provider
                                                          .productList[index],
                                                    )));
                                      }),
                                ),
                                Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: CupertinoButton(
                                          child: const Text(
                                            "Update Verieties",
                                            style: TextStyle(
                                                color: Colors.greenAccent),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UploadProduct(
                                                          router: 2,
                                                          product: provider
                                                                  .productList[
                                                              index],
                                                        )));
                                          }),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CupertinoButton(
                                          child: const Text(
                                            "Update Product",
                                            style: TextStyle(
                                                color: Colors.greenAccent),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UploadProduct(
                                                          router: 1,
                                                          product: provider
                                                                  .productList[
                                                              index],
                                                        )));
                                          }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
            : const Center(
                child: Text("Add Product Now + "),
              )
        : const LoadingWidget();
  }
}
