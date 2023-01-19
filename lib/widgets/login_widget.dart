import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicadmin/widgets/loading_widget.dart';
import 'package:medicadmin/services/adminprovider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int? stater;
  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    stater = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 50,
        ),
        Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  //const Text("Email"),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        label: const Text("Email"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    validator: (value) {
                      if (value!.length < 3) {
                        return "Please Enter Email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //const Text("Password"),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        label: const Text("Password"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    validator: (value) {
                      if (value!.length < 3) {
                        return "Please Enter Valid Password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                      color: stater == 1 ? Colors.green : Colors.grey,
                      onPressed: stater == 1
                          ? () {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  stater = 2;
                                });
                                Provider.of<ProviderAdminServices>(context,
                                        listen: false)
                                    .signinwithEmail(
                                        emailController.text.trim(),
                                        passwordController.text.trim());
                              }
                            }
                          : () {},
                      child: stater == 1
                          ? const Text("LogIn")
                          : const SizedBox(
                              height: 20, child: CircularProgressIndicator()))
                ],
              ),
            ))
      ],
    );
  }
}
