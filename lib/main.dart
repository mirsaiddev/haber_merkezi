import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:news_app_v1/providers/data_provider.dart';
import 'package:news_app_v1/screens/Splash/splash_screen.dart';
import 'package:news_app_v1/utils/my_snackbar.dart';
import 'package:news_app_v1/utils/navigator_state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    Permission.notification.request();
    print(await Permission.notification.status);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('message received');
      MySnackbar.showNotification(
        GlobalVariable.navState.currentContext!,
        title: message.notification!.title!,
        body: message.notification!.body!,
        onTap: (val) {},
      );
    });
    FirebaseMessaging.instance.subscribeToTopic('all');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
      ],
      child: MaterialApp(
        title: 'Haber Merkezi',
        debugShowCheckedModeBanner: false,
        navigatorKey: GlobalVariable.navState,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: SplashScreen(),
      ),
    );
  }
}
