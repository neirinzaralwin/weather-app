import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMService {
  // * <------------- Firebase cloud messenging & Notification --------------->

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  initializeFirebaseFCM({required String? fcmtoken}) async {
    debugPrint("fcm token ---> ${fcmtoken!}");
    await listenFCM(); // firebase cloud messeging
    await storeTokenAtFireStore(fcmtoken);
  }

  Future<void> listenFCM() async {
    // listen for user to click on notification
    debugPrint("your app is listening notification");
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
      String? title = remoteMessage.notification!.title;
      String? description = remoteMessage.notification!.body;
      debugPrint("remote Message -> ${remoteMessage.notification!.title}");
      BotToast.showSimpleNotification(title: title!, subTitle: description);
    });
  }

  Future<void> storeTokenAtFireStore(fcmtoken) async {
    final CollectionReference fcmTokens = FirebaseFirestore.instance.collection("fcm_tokens");

    QuerySnapshot querySnapshot = await fcmTokens.where("token", isEqualTo: fcmtoken).get();

    if (querySnapshot.size > 0) {
      // Token already exists, update the existing document
      String docId = querySnapshot.docs.first.id;
      await fcmTokens.doc(docId).update({"token": fcmtoken});
      debugPrint('FCM token updated in Firestore');
    } else {
      // Token doesn't exist, add a new document
      await fcmTokens.add({"token": fcmtoken});
      debugPrint('FCM token stored in Firestore');
    }
  }
}
