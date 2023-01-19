import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicadmin/data/models/mongo_user.dart';
import 'package:medicadmin/services/adminprovider.dart';
import 'package:medicadmin/services/messaging/messaging_services.dart';
import 'package:medicadmin/services/products_orders_provider.dart';
import 'package:provider/provider.dart';

import '../../../services/invoice_service/invoice_api.dart';
import '../../../services/invoice_service/pdf_api.dart';
import '../../order_details.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  MessagingServiceFCM messagingService = MessagingServiceFCM();
  int breaker = 1;
  @override
  void initState() {
    messagingService.requestPermission();
    breaker = 1;
    // Provider.of<ProviderAdminServices>(context,listen: false).notificIdsCheck(Provider.of<ProviderAdminServices>(context,listen: false).)
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductOrdersProvider provider =
        Provider.of<ProductOrdersProvider>(context);

    if (adminModel != null && breaker == 1) {
      provider.fetchOrder(adminModel!.adminuserid!);
      provider.resetOrderloaded();
      breaker += 1;
    }
    Future<void> refresher() async {
      setState(() {
        breaker = 1;
      });
    }

    return RefreshIndicator(
      onRefresh: () {
        return refresher();
      },
      child: Scaffold(
          body: SafeArea(
              child: provider.orderloaded
                  ? ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: provider.orders.length,
                            itemBuilder: (context, index) => Container(
                                  color:
                                      const Color.fromARGB(255, 219, 218, 218),
                                  margin: const EdgeInsets.only(top: 5),
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderDetails(
                                                          orderModel: provider
                                                              .orders[index])));
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: 80,
                                                  width: 80,
                                                  child: CachedNetworkImage(
                                                    imageUrl: provider
                                                        .orders[index]
                                                        .items![0]
                                                        .style!
                                                        .images![0],
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder: (context,
                                                            url) =>
                                                        const LinearProgressIndicator(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.5,
                                                                child: Text(
                                                                  provider
                                                                      .orders[
                                                                          index]
                                                                      .items![0]
                                                                      .product!
                                                                      .title
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      const TextStyle(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.5,
                                                                child: Text(
                                                                  provider
                                                                      .orders[
                                                                          index]
                                                                      .items![0]
                                                                      .style!
                                                                      .title
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      const TextStyle(),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          provider
                                                                      .orders[
                                                                          index]
                                                                      .items!
                                                                      .length >
                                                                  1
                                                              ? Text(
                                                                  "& ${provider.orders[index].items!.length - 1} more",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          27,
                                                                          26,
                                                                          26)),
                                                                )
                                                              : const SizedBox()
                                                        ],
                                                      ),

                                                      // Text(
                                                      //   provider
                                                      //       .orders[index].status
                                                      //       .toString(),
                                                      //   style: const TextStyle(
                                                      //       fontWeight:
                                                      //           FontWeight.bold,
                                                      //       fontSize: 18),
                                                      // ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 10),
                                                        decoration: BoxDecoration(
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                245,
                                                                245,
                                                                245),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .black12),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          2.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Text(
                                                                      "Order Id              "),
                                                                  Text(
                                                                    "${provider.orders[index].sId}",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          2.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Text(
                                                                      "Ordered at         "),
                                                                  Text(DateTime.parse(provider
                                                                          .orders[
                                                                              index]
                                                                          .addedon!)
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          16))
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          2.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Text(
                                                                      "Order Value       "),
                                                                  Text(
                                                                      "₹ ${provider.orders[index].totalordervalue}")
                                                                ],
                                                              ),
                                                            ),
                                                            // Padding(
                                                            //   padding:
                                                            //       const EdgeInsets
                                                            //               .symmetric(
                                                            //           vertical: 2.0),
                                                            //   child: Row(
                                                            //     mainAxisAlignment:
                                                            //         MainAxisAlignment
                                                            //             .start,
                                                            //     children: [
                                                            //       const Text(
                                                            //           "Current status-  "),
                                                            //       Text(
                                                            //         provider.status(
                                                            //             provider.orders[
                                                            //                 index]),
                                                            //         style:
                                                            //             const TextStyle(
                                                            //           fontSize: 12,
                                                            //         ),
                                                            //       )
                                                            //     ],
                                                            //   ),
                                                            // )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () async {
                                            //final invoice = Invoice()
                                            final pdfFile =
                                                await PdfInvoiceApi.generate(
                                                    provider.orders[index]);
                                            log(pdfFile.path);
                                            PdfApi.openFile(pdfFile);
                                            // showCuperDialog(
                                            //     context: context,
                                            //     user: provider
                                            //         .orders[index].user!);
                                          },
                                          child: const Text("Generate Invoice"))
                                    ],
                                  ),
                                ))
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ))),
    );
  }
}
