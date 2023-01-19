import 'package:flutter/material.dart';
import 'package:medicadmin/screens/screens_on_homepage/home.dart';
import 'package:medicadmin/screens/screens_on_homepage/profile.dart';
import 'package:medicadmin/screens/screens_on_homepage/upload_product.dart';

import '../services/messaging/messaging_services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MessagingServiceFCM messagingService = MessagingServiceFCM();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  static const List<Widget> _pages = <Widget>[
    Home(),
    // UploadProduct(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: SizedBox(
        height: 40,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UploadProduct(
                          router: 0,
                        )));
          },
          child: const Icon(
            Icons.add_rounded,
            size: 30,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.amber,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.greenAccent,
        onTap: (index) {
          _onItemTapped(index);
        },
        elevation: 5,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.upload),
          //   label: 'Add',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
