import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/adminprovider.dart';

class AdminForm extends StatefulWidget {
  const AdminForm({super.key});

  @override
  State<AdminForm> createState() => _AdminFormState();
}

class _AdminFormState extends State<AdminForm> {
  final GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController storenameController = TextEditingController();
  TextEditingController storeaddressController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    storeaddressController.dispose();
    storenameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text("Fill valid details"),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    label: const Text("Store Admin Name"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                validator: (value) {
                  if (value!.length < 3) {
                    return "Please Enter Store Hounor's Valid Name";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: storenameController,
                decoration: InputDecoration(
                    label: const Text("Store Name"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                validator: (value) {
                  if (value!.length < 3) {
                    return "Please Enter Correct Store Name";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: storeaddressController,
                decoration: InputDecoration(
                    label: const Text("Store Address"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                validator: (value) {
                  if (value!.length < 3) {
                    return "Please Enter Correct Store Address";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CupertinoButton(
                  color: Colors.green,
                  child: const Text("Submit"),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      // setState(() {
                      //   stater = 2;
                      // });
                      Provider.of<ProviderAdminServices>(context, listen: false)
                          .createAdmin(
                              name: nameController.text.trim(),
                              storename: storenameController.text.trim(),
                              storeaddress: storeaddressController.text.trim());
                    }
                  })
            ],
          ),
        ));
  }
}
