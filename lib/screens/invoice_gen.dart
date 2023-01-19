import 'package:flutter/material.dart';
import 'package:medicadmin/data/models/order_model.dart';

class Userdetails extends StatelessWidget {
  const Userdetails({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      )),
    );
  }
}
