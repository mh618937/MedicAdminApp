import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medicadmin/services/adminprovider.dart';
import 'package:medicadmin/services/products_orders_provider.dart';
import 'package:provider/provider.dart';

import '../data/models/cart_item_model.dart';
import '../data/models/order_model.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  int alltotal() {
    int subtotal = 0;
    for (int i = 0; i < widget.orderModel.items!.length; i++) {
      subtotal = subtotal +
          int.parse(widget.orderModel.items![i].quantity.toString()) *
              int.parse(widget.orderModel.items![i].style!.price.toString());
    }
    return subtotal;
  }

  int verietyTotal({required Items item}) {
    return item.quantity! * item.style!.price!;
  }

  @override
  void initState() {
    currentStep = widget.orderModel.status!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductOrdersProvider provider = Provider.of<ProductOrdersProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
          //leading: const SizedBox(),
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Order Details",
            //textAlign: TextAlign.left,
            // style: GoogleFonts.robotoSlab(
            //     color: const Color.fromARGB(255, 7, 139, 111), fontSize: 16),
          ),
          backgroundColor: Colors.greenAccent),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 233, 255, 207),
                border: Border.all(width: 1, color: Colors.green),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: const Text(
                              "Products",
                              style: TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.08,
                            child: Text(
                              "Qty".toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.15,
                          //   child: const Text(
                          //     "  Qty",
                          //     overflow: TextOverflow.ellipsis,
                          //     style: TextStyle(fontSize: 16),
                          //   ),
                          // ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.22,
                            child: const Text(
                              "   Amount",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.orderModel.items!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => ProductDetails(
                        //               product: widget
                        //                   .orderModel.items![index].product!)));
                        // },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 2),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.56,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CachedNetworkImage(
                                              imageUrl: widget
                                                  .orderModel
                                                  .items![index]
                                                  .style!
                                                  .images![0],
                                              imageBuilder:
                                                  (context, imageProvider) =>
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
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  child: Text(
                                                    "${widget.orderModel.items![index].product!.title} ",
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  child: Text(
                                                    widget
                                                        .orderModel
                                                        .items![index]
                                                        .style!
                                                        .title
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                    ),

                                    const Text(
                                      "X    ",
                                      style: TextStyle(fontSize: 8),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                      child: Text(
                                        widget.orderModel.items![index].quantity
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Text(
                                        "₹ ${verietyTotal(item: widget.orderModel.items![index])}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width:
                                    //       MediaQuery.of(context).size.width *
                                    //           0.2,
                                    //   child: Text(
                                    //     provider
                                    //         .verietyTotal(
                                    //             item: widget.items[index])
                                    //         .toString(),
                                    //     overflow: TextOverflow.ellipsis,
                                    //     style: const TextStyle(fontSize: 16),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    right: MediaQuery.of(context).size.width * 0.06,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Subtotal   "),
                      Text("₹ ${alltotal()}"),
                    ],
                  ),
                )
              ],
            ),
          ),
          Theme(
            data: ThemeData(
              //primaryColor: const Color.fromARGB(255, 247, 214, 67),
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: Colors.green,
                    background: Colors.red,
                    secondary: Colors.green,
                  ),
            ),
            child: Stepper(
                currentStep: currentStep,
                controlsBuilder: (context, details) {
                  return currentStep <= 2
                      ? MaterialButton(
                          color: const Color.fromARGB(255, 148, 250, 100),
                          onPressed: () {
                            provider
                                .updateOrderStatus(
                                    widget.orderModel.orderid!, currentStep + 1)
                                .then((res) {
                              provider.fetchOrder(adminModel!.adminuserid!);
                              setState(() {
                                currentStep += 1;
                              });
                            });
                          },
                          child: const Text("yes"),
                        )
                      : const SizedBox();
                },
                steps: [
                  Step(
                      title: const Text("Accept order"),
                      content: const Text(
                        "Accept ?.",
                        textAlign: TextAlign.start,
                      ),
                      isActive: currentStep >= 0,
                      state: currentStep >= 0
                          ? StepState.complete
                          : StepState.indexed),
                  // Step(
                  //     title: const Text("Ready for dispatch"),
                  //     content: const Text(
                  //       "Your order is ready for dispatch.",
                  //       textAlign: TextAlign.start,
                  //     ),
                  //     isActive: currentStep >= 1,
                  //     state: currentStep >= 1
                  //         ? StepState.complete
                  //         : StepState.indexed),
                  Step(
                      title: const Text("Dispatched"),
                      content: const Text(
                        "Dispatched ?",
                        textAlign: TextAlign.start,
                      ),
                      isActive: currentStep >= 1,
                      state: currentStep >= 1
                          ? StepState.complete
                          : StepState.indexed),
                  Step(
                      title: const Text("On the way"),
                      content: const Text(
                        "Order Successfully delivered ?",
                        textAlign: TextAlign.start,
                      ),
                      isActive: currentStep >= 2,
                      state: currentStep >= 2
                          ? StepState.complete
                          : StepState.indexed),
                  Step(
                      title: const Text("Delivered"),
                      content: const Text(
                        "Order Successfully delivered.",
                        textAlign: TextAlign.start,
                      ),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed),
                ]),
          )
        ]),
      ),
    );
  }

  // switchStepsType() {
  //   setState(() => stepperType == StepperType.vertical
  //       ? stepperType = StepperType.horizontal
  //       : stepperType = StepperType.vertical);
  // }

  // tapped(int step) {
  //   setState(() => _currentStep = step);
  // }

  // continued() {
  //   _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  // }

  // cancel() {
  //   _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  // }
}
