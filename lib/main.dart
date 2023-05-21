import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentations/login/login_page.dart';
import 'package:weather_app/repository/app_repo.dart';
import 'package:weather_app/repository/weather_repo.dart';

import 'firebase_options.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp();
  } else if (Platform.isAndroid) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform, name: "Weather App");
  }
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform, name: "Weather App");
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppRepository>(create: (context) => AppRepository()),
        RepositoryProvider<WeatherRepository>(create: (context) => WeatherRepository()),
      ],
      child: MaterialApp(
        builder: BotToastInit(),
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: appThemeData,
        home: const LoginPage(),
      ),
    );
  }
}
