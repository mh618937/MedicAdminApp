import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../services/adminprovider.dart';
import '../../../services/products_orders_provider.dart';
import '../../prs_order_details.dart';

class PrescriptionOrder extends StatefulWidget {
  const PrescriptionOrder({super.key});

  @override
  State<PrescriptionOrder> createState() => _PrescriptionOrderState();
}

class _PrescriptionOrderState extends State<PrescriptionOrder> {
  int breaker = 1;
  Future<void> refresher() async {
    setState(() {
      breaker = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductOrdersProvider provider =
        Provider.of<ProductOrdersProvider>(context);
    if (breaker == 1) {
      provider.getAllprescription();
      provider.resetOrderloaded();
      breaker += 1;
    }
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refresher,
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: provider.prescriptions.length,
                  itemBuilder: (context, index) => Container(
                        color: const Color.fromARGB(255, 219, 218, 218),
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PrsOrderdetails(
                                        prescription:
                                            provider.prescriptions[index])));
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
                                          .prescriptions[index].imageurls![0],
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const LinearProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Row(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment
                                        //           .start,
                                        //   children: [
                                        //     Column(
                                        //       children: [
                                        //         SizedBox(
                                        //           width: MediaQuery.of(context)
                                        //                   .size
                                        //                   .width *
                                        //               0.5,
                                        //           child: Text(
                                        //             provider
                                        //                 .prescriptions[
                                        //                     index]
                                        //                 .items![
                                        //                     0]
                                        //                 .product!
                                        //                 .title
                                        //                 .toString(),
                                        //             overflow:
                                        //                 TextOverflow
                                        //                     .ellipsis,
                                        //             style:
                                        //                 const TextStyle(),
                                        //           ),
                                        //         ),
                                        //         SizedBox(
                                        //           width: MediaQuery.of(context)
                                        //                   .size
                                        //                   .width *
                                        //               0.5,
                                        //           child: Text(
                                        //             provider
                                        //                 .orders[
                                        //                     index]
                                        //                 .items![
                                        //                     0]
                                        //                 .style!
                                        //                 .title
                                        //                 .toString(),
                                        //             overflow:
                                        //                 TextOverflow
                                        //                     .ellipsis,
                                        //             style:
                                        //                 const TextStyle(),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     provider
                                        //                 .orders[
                                        //                     index]
                                        //                 .items!
                                        //                 .length >
                                        //             1
                                        //         ? Text(
                                        //             "& ${provider.orders[index].items!.length - 1} more",
                                        //             style: const TextStyle(
                                        //                 fontSize:
                                        //                     12,
                                        //                 color: Color.fromARGB(
                                        //                     255,
                                        //                     27,
                                        //                     26,
                                        //                     26)),
                                        //           )
                                        //         : const SizedBox()
                                        //   ],
                                        // ),

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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 245, 245, 245),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black12),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                        "Order Id-              "),
                                                    Text(
                                                      "${provider.prescriptions[index].sId}",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                        "Ordered at-         "),
                                                    Text(DateTime.parse(provider
                                                            .prescriptions[
                                                                index]
                                                            .addedon!)
                                                        .toString()
                                                        .substring(0, 16))
                                                  ],
                                                ),
                                              ),
                                              // Padding(
                                              //   padding:
                                              //       const EdgeInsets.symmetric(
                                              //           vertical: 2.0),
                                              //   child: Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment.start,
                                              //     children: [
                                              //       // const Text(
                                              //       //     "Order Value-       "),
                                              //       // Text(
                                              //       //     "₹ ${provider.orders[index].totalordervalue}")
                                              //     ],
                                              //   ),
                                              // ),
                                              // Padding(
                                              //   padding: const EdgeInsets.symmetric(
                                              //       vertical: 2.0),
                                              //   child: Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment.start,
                                              //     children: [
                                              //       const Text("Current status-  "),
                                              //       Text(
                                              //         provider.prsStatus(provider
                                              //             .prescriptions[index]),
                                              //         style: const TextStyle(
                                              //           fontSize: 11,
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
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
