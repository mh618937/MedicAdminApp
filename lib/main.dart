import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medicadmin/firebase_options.dart';
import 'package:medicadmin/homepage_handler.dart';
import 'package:medicadmin/services/adminprovider.dart';
import 'package:medicadmin/services/products_orders_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProviderAdminServices>(
              create: (context) => ProviderAdminServices()),
          ChangeNotifierProvider<ProductOrdersProvider>(
              create: (context) => ProductOrdersProvider())
        ],
        child: MaterialApp(
          title: 'Urdu For Board Study App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const FirstHandler(),
        ));
  }
}
