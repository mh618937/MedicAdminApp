import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PrescriptionOrder extends StatefulWidget {
  const PrescriptionOrder({super.key});

  @override
  State<PrescriptionOrder> createState() => _PrescriptionOrderState();
}

class _PrescriptionOrderState extends State<PrescriptionOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Prescription page")),
    );
  }
}
