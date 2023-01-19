import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medicadmin/screens/homepage.dart';
import 'package:medicadmin/widgets/admin_form_widget.dart';
import 'package:medicadmin/widgets/login_widget.dart';
import 'package:medicadmin/services/adminprovider.dart';
import 'package:provider/provider.dart';

import 'services/products_orders_provider.dart';
import 'widgets/loading_widget.dart';

class FirstHandler extends StatefulWidget {
  const FirstHandler({super.key});

  @override
  State<FirstHandler> createState() => _FirstHandlerState();
}

class _FirstHandlerState extends State<FirstHandler> {
  @override
  void initState() {
    Provider.of<ProviderAdminServices>(context, listen: false).checklogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ProviderServices provider = Provider.of<ProviderServices>(context);
    // log(provider.alreadyExist.toString());
    return Consumer<ProviderAdminServices>(builder: (context, provider, child) {
      return Scaffold(
          body: provider.isloading
              ? const LoadingWidget()
              : provider.isloggedin
                  ? provider.alreadyExist
                      ? const MyHomePage()
                      : const AdminForm()
                  : const LoginPage());
    });
  }
}
