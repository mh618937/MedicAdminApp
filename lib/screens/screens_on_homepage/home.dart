import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medicadmin/screens/screens_on_homepage/subscreens_on_home/listed_product.dart';
import 'package:medicadmin/screens/screens_on_homepage/subscreens_on_home/oreders.dart';
import 'package:medicadmin/screens/screens_on_homepage/subscreens_on_home/prescription_order.dart';
import 'package:medicadmin/services/adminprovider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  int currenttabindex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: AppBar(
            elevation: 0,
            // excludeHeaderSemantics: true,
            backgroundColor: Colors.greenAccent,
            title: adminModel != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      adminModel!.medicalstorename.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : const Text("My Medical Store"),
            centerTitle: true,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  controller: _tabController,

                  // onTap: (index) {
                  //   setState(() {
                  //     currenttabindex = index;
                  //     log(index.toString());
                  //   });
                  // },
                  isScrollable: false,
                  indicatorColor: const Color.fromARGB(255, 50, 23, 85),
                  tabs: [
                    Tab(
                      // text: 'Orders',
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: double.infinity,
                        // elevation: 10,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 20, 92, 42),
                        ),
                        // shadowColor: const Color.fromARGB(255, 255, 255, 255),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          "Orders",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 167, 227, 235),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Tab(
                      // text: 'Orders',

                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        // padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        // shadowColor: const Color.fromARGB(255, 255, 255, 255),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 20, 92, 42),
                        ),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          "Prescriptions",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 167, 227, 235),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Tab(
                      // text: 'Orders',
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: double.infinity,
                        // shadowColor: const Color.fromARGB(255, 255, 255, 255),
                        // elevation: 10,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 20, 92, 42),
                        ),
                        //     borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          "Products",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 167, 227, 235),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [Orders(), PrescriptionOrder(), ListedProduct()],
        ),
      ),
    );
  }
}
