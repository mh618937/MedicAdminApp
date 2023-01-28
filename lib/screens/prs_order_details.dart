import 'package:cached_network_image/cached_network_image.dart';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:medicadmin/services/products_orders_provider.dart';
import 'package:medicadmin/utils/utilities.dart';
import 'package:provider/provider.dart';

import '../data/models/address_model.dart';
import '../data/models/prescription_model.dart';
import '../widgets/image_viewer.dart';

class PrsOrderdetails extends StatefulWidget {
  const PrsOrderdetails({super.key, required this.prescription});
  final PrescrModel prescription;

  @override
  State<PrsOrderdetails> createState() => _PrsOrderdetailsState();
}

class _PrsOrderdetailsState extends State<PrsOrderdetails> {
  late TextEditingController amountController;
  late TextEditingController deliverychargeController;
  late AddressModel address;
  int currentStep = 0;
  @override
  void initState() {
    if (widget.prescription.netamount != null) {
      amountController =
          TextEditingController(text: widget.prescription.netamount.toString());
    } else {
      amountController = TextEditingController();
    }
    if (widget.prescription.deliverycharge != null) {
      deliverychargeController = TextEditingController(
          text: widget.prescription.deliverycharge.toString());
    } else {
      deliverychargeController = TextEditingController();
    }
    address = AddressModel.fromJson(
        widget.prescription.address! as Map<String, dynamic>);
    currentStep = widget.prescription.status!;
    super.initState();
  }

  @override
  void dispose() {
    deliverychargeController.dispose();
    amountController.dispose();
    super.dispose();
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
            style: TextStyle(
                color: Color.fromARGB(255, 7, 139, 111), fontSize: 16),
          ),
          backgroundColor: const Color.fromARGB(255, 218, 227, 231),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SizedBox(
              //   height: 10,
              // ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "To be deliver at -",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 104, 100, 100),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.16,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 228, 227, 223),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          address.recievername!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          address.phoneNumber!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 104, 100, 100),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          address.address!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 104, 100, 100),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          address.city!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 104, 100, 100),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          address.pincode!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 104, 100, 100),
                              fontWeight: FontWeight.bold),
                        ),
                        // GestureDetector(
                        //     onTap: () {},
                        //     child: const Text(
                        //       "Edit",
                        //       textAlign:
                        //           TextAlign.end,
                        //       style: TextStyle(
                        //           color: Colors
                        //               .blueAccent),
                        //     )),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Prescription",
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.3,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: GestureDetector(
                            onTap: () {
                              CustomImageProvider customImageProvider =
                                  CustomImageProvider(
                                      imageUrls: widget.prescription.imageurls
                                          as List<String>,
                                      initialIndex: 0);
                              showImageViewerPager(context, customImageProvider,
                                  onPageChanged: (page) {
                                // print("Page changed to $page");
                              }, onViewerDismissed: (page) {
                                // print("Dismissed while on page $page");
                              });
                            },
                            child: CachedNetworkImage(
                              imageUrl: widget.prescription.imageurls![0],
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
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: const Text(
                              "Your Instruction",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              // softWrap: true,
                              //textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              widget.prescription.note!,
                              style: const TextStyle(fontSize: 12),
                              // softWrap: true,
                              //textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: MediaQuery.of(context).size.width * 0.32),
                child: TextFormField(
                  textAlign: TextAlign.start,
                  controller: amountController,
                  maxLines: 1,
                  //maxLength: maxlength,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: const Text(
                        "Total Medicine Cost",
                        style: TextStyle(fontSize: 14),
                      ),
                      prefix: const Text("₹ "),
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.only(left: 10, top: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: MediaQuery.of(context).size.width * 0.32),
                child: TextFormField(
                  textAlign: TextAlign.start,
                  controller: deliverychargeController,
                  maxLines: 1,
                  //maxLength: maxlength,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: const Text(
                        "Delivery Charge",
                        style: TextStyle(fontSize: 14),
                      ),
                      prefix: const Text("₹ "),
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.only(left: 10, top: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("COD Enable"),
                    const SizedBox(
                      width: 20,
                    ),
                    FlutterSwitch(
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: MediaQuery.of(context).size.height * 0.03,
                      valueFontSize: MediaQuery.of(context).size.height * 0.01,
                      toggleSize: 10.0,
                      value: widget.prescription.codenabled!,
                      borderRadius: 15.0,
                      padding: 5.0,
                      activeText: "YES",
                      activeTextColor: Colors.white,
                      activeColor: const Color.fromARGB(255, 2, 240, 180),
                      activeIcon: const Icon(
                        Icons.done_outline_rounded,
                        color: Colors.greenAccent,
                      ),
                      inactiveText: "NO",
                      inactiveTextColor: const Color.fromARGB(221, 53, 29, 21),
                      showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          widget.prescription.codenabled = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              widget.prescription.paymentstatus!
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 1),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Payment_status"),
                                widget.prescription.paymenttype == 1
                                    ? const Text("COD requested")
                                    : const Text("Completed")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Payment_id"),
                                Text(widget.prescription.paymentid!)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Order_id"),
                                Text(widget.prescription.sId!)
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       widget.prescription.status! < 3 &&
              //               widget.prescription.status! >= 0
              //           ? TextButton(
              //               onPressed: () {},
              //               //   provider
              //               //       .updateOrderStatus(
              //               //           widget.prescription.!, -1)
              //               //       .then((value) {
              //               //     setState(() {
              //               //       widget.orderModel.status = -1;
              //               //     });
              //               //   });
              //               // },
              //               child: const Text("Cancel Order"))
              //           : const SizedBox(),
              //       widget.prescription.status == 3
              //           ? TextButton(
              //               onPressed: () {
              //                 // provider
              //                 //     .updateOrderStatus(
              //                 //         widget.orderModel.orderid!, -2)
              //                 //     .then((value) {
              //                 //   setState(() {
              //                 //     widget.orderModel.status = -2;
              //                 //   });
              //                 // });
              //               },
              //               child: const Text("Return"))
              //           : const SizedBox()
              //     ],
              //   ),
              // ),
              currentStep >= 0
                  ? Theme(
                      data: ThemeData(
                        //primaryColor: const Color.fromARGB(255, 247, 214, 67),
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: Colors.green,
                              background: Colors.red,
                              secondary: Colors.green,
                            ),
                      ),
                      child: Stepper(
                          physics: NeverScrollableScrollPhysics(),
                          currentStep: currentStep,
                          controlsBuilder: (context, details) {
                            return currentStep <= 2
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MaterialButton(
                                        color: const Color.fromARGB(
                                            255, 148, 250, 100),
                                        onPressed: amountController.text
                                                        .trim() !=
                                                    "" &&
                                                deliverychargeController.text
                                                        .trim() !=
                                                    ""
                                            ? () {
                                                setState(() {
                                                  widget.prescription.status =
                                                      widget.prescription
                                                              .status! +
                                                          1;
                                                  widget.prescription
                                                          .netamount =
                                                      int.parse(amountController
                                                          .text
                                                          .trim());
                                                  widget.prescription
                                                          .deliverycharge =
                                                      int.parse(
                                                          deliverychargeController
                                                              .text
                                                              .trim());
                                                });
                                                provider
                                                    .updateprescription(
                                                        widget.prescription)
                                                    .then((res) {
                                                  provider.getAllprescription();
                                                  setState(() {
                                                    currentStep += 1;
                                                  });
                                                });
                                              }
                                            : () {
                                                showMessage(
                                                    context: context,
                                                    message:
                                                        "Please Provide total Cost & Delivery Charge");
                                              },
                                        child: const Text("yes"),
                                      ),
                                      currentStep == 0
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: MaterialButton(
                                                color: const Color.fromARGB(
                                                    255, 148, 250, 100),
                                                onPressed: () {
                                                  setState(() {
                                                    widget.prescription.status =
                                                        widget.prescription
                                                                .status! -
                                                            1;
                                                    widget.prescription
                                                            .netamount =
                                                        int.parse(
                                                            amountController
                                                                .text
                                                                .trim());
                                                    widget.prescription
                                                            .deliverycharge =
                                                        int.parse(
                                                            deliverychargeController
                                                                .text
                                                                .trim());
                                                  });
                                                  provider
                                                      .updateprescription(
                                                          widget.prescription)
                                                      .then((res) {
                                                    provider
                                                        .getAllprescription();
                                                    setState(() {
                                                      currentStep -= 1;
                                                    });
                                                  });
                                                },
                                                child: const Text("no"),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  )
                                : const SizedBox();
                          },
                          steps: [
                            Step(
                                title: Row(
                                  children: [
                                    const Text("Accept order"),
                                  ],
                                ),
                                content: const Text(
                                  "Product Available ?.",
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
                  : SizedBox(
                      child: Text("Order not Accepted."),
                    )
            ],
          ),
        ));
  }
}
