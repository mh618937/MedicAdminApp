import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicadmin/data/models/admin_model.dart';
import 'package:medicadmin/data/repositories/admin_repository.dart';
import 'package:medicadmin/services/messaging/messaging_services.dart';

var usertoken = FirebaseAuth.instance.currentUser;
AdminModel? adminModel;

class ProviderAdminServices with ChangeNotifier {
  AdminRepository adminRepository = AdminRepository();
  MessagingServiceFCM messagingServiceFCM = MessagingServiceFCM();
  bool isloading = true;
  bool loginerror = false;
  bool isloggedin = false;
  bool alreadyExist = false;

  checklogin() async {
    //await Future.delayed(Duration(milliseconds: 500));
    if (usertoken != null) {
      await checkAdminExistance();
      //log(d.toString());
      isloggedin = true;
      isloading = false;
    } else {
      await delayer();
      isloading = false;
      isloggedin = false;
    }
    notifyListeners();
  }

  signinwithEmail(String email, String password) async {
    try {
      log("inside");
      var cred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      usertoken = cred.user;
    } catch (e) {
      log(e.toString());
      loginerror = true;
      isloading = false;
      notifyListeners();
      return;
    }
    await checklogin();

    // log(d.toString());
  }

  // notification
  notificIdsCheck(AdminModel adminModel) async {
    List<dynamic> nList = adminModel.notificationIds!;
    log(nList.toString());
    await messagingServiceFCM.getSetToken(nList).then((value) {
      // log(value[0].toString());
      // log((value[1].toString()));
      value[1]
          ? adminRepository.updateAdmin(
              adminid: adminModel.adminuserid!,
              name: adminModel.name!,
              medicalstorename: adminModel.medicalstorename!,
              notificationids: value[0],
              storeaddress: adminModel.storeaddress!)
          : null;
    });
  }
  //checking existance in mongo

  checkAdminExistance() async {
    if (usertoken != null) {
      adminModel = await adminRepository.fetchAdmin(uid: usertoken!.uid);
      //log(adminModel!.name.toString());
      if (adminModel != null) {
        notificIdsCheck(adminModel!);
        alreadyExist = true;
      }
    }
    log(alreadyExist.toString());
    notifyListeners();
  }
  //create admin

  createAdmin(
      {required String name,
      required String storename,
      required String storeaddress}) async {
    adminModel = await adminRepository.createAdmin(
        adminid: usertoken!.uid,
        name: name,
        medicalstorename: storename,
        storeaddress: storeaddress);
    await checklogin();
  }

  delayer() async {
    await Future.delayed(const Duration(milliseconds: 600), () {
      log("delay success");
    });
  }
}
