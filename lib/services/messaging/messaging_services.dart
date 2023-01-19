import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../data/models/notificationid_model.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  log("message recieved ! ${message.notification!.title}");
}

class MessagingServiceFCM {
  //static Future<void> initiallize() async {
  //   NotificationSettings notificationSettings =
  //       await FirebaseMessaging.instance.requestPermission();
  //   if (notificationSettings.authorizationStatus ==
  //       AuthorizationStatus.authorized) {
  //     String? token = await FirebaseMessaging.instance.getToken();
  //     if (token != null) {
  //       log(token);
  //     }

  //     FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  //     FirebaseMessaging.onMessage.listen(
  //       (message) {
  //         log("message recieved ! ${message.notification!.title}");
  //       },
  //     );
  //     log("Notifications Initialized");
  //   }
  // }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log("user granted provisional permission");
    } else {
      log("user denied permission");
    }
  }

  Future<List<dynamic>> getSetToken(List<dynamic> nList) async {
    //List<NotificationIdModel> tokenlist = [];
    bool mustUpdate = false;
    await FirebaseMessaging.instance.getToken().then((token) async {
      try {
        // var doc = await FirebaseFirestore.instance
        //     .collection("MedicAdmin")
        //     .doc(FirebaseAuth.instance.currentUser!.uid)
        //     .get();
        // List<dynamic>? nList = doc.data()!["notifierIds"];
        // nList != null ? nList = nList : nList = [];

        // log("Upcoming notif list $nList");
        // log("obtained token ${token!}");
        if (nList.any((element) {
          // log("element " + element.toString());
          // log("token of element" + element["token"]);
          return element["token"] == token;
          // log((element["token"] == token).toString());
        })) {
          // log("You dont't have to update");
        } else {
          nList.add(NotificationIdModel(token: token, index: nList.length + 1)
              .toMap());
          mustUpdate = true;
          // try {
          //   await FirebaseFirestore.instance
          //       .collection("MedicAdmin")
          //       .doc(FirebaseAuth.instance.currentUser!.uid)
          //       .update({"notifierIds": nList});
          // } catch (e) {
          //   throw e.toString();
          // }
        }
      } catch (e) {
        throw e.toString();
      }

      //log(token.toString());
    });
    log("New nList $nList");
    List<dynamic> t = [nList, mustUpdate];
    log("Complete Package $t");
    return t;
  }

  void sentPushMessage(String token, String body1, String title) async {
    log("token  $token");
    final data = {
      "notification": {
        "title": title,
        "body": body1,
        "android_channel_id": "high_importance_chanel",
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to": token
    };
    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAARq0j8yQ:APA91bGimJuYet8NoAYUfmJ5HktrSnzh-mIQlg5dgNnMdvF2qwyjp4C07MwpTArrHWcqbU8D9Dx9lqkJZ71p6rfs1icPzAVRg9kS41x3sM7dWRzRgs_K0DEArceNzy2xcp4FE_pbEsIw'
    };
    var postUrl = "https://fcm.googleapis.com/fcm/send";
    BaseOptions options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );
    try {
      final res = await Dio(options).post(postUrl, data: data);

      if (res.statusCode == 200) {
        log('Request Sent To Driver');
      } else {
        print('notification sending failed');
        // on failure do sth
      }

      log("response  ${res.statusCode}");
      log("body ${res.data}");
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }
}
