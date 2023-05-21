import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/bloc/app/app_event.dart';
import 'package:weather_app/bloc/app/app_state.dart';
import 'package:weather_app/repository/app_repo.dart';
import 'package:weather_app/service/firebase_cloud_messenging.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository appRepo;

  AppBloc(this.appRepo) : super(AppLoadingState()) {
    on<LoadAppEvent>(
      (event, emit) async {
        FirebaseMessaging messaging = FirebaseMessaging.instance;
        await handleNotificationPermission(messaging);
        String fcmtoken = await getFcmToken(messaging);
        FCMService().initializeFirebaseFCM(fcmtoken: fcmtoken);
        bool hasLocationPermission = await handleLocationPermission();
        if (hasLocationPermission) {
          emit(AppLoadedState(fcmtoken));
        }
      },
    );
  }

  Future getFcmToken(messaging) async {
    String? token = await messaging.getToken();
    debugPrint("---- recieving fcm token ----");
    debugPrint(token.toString());
    return token;
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  handleNotificationPermission(messaging) async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }
}
