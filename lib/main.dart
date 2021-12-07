import 'package:letstalk_group_chat/screens/auth_screen.dart';
import 'package:letstalk_group_chat/screens/chat_screen.dart';
//import 'package:letstalk_group_chat/screens/splash_screen.dart';
import 'package:letstalk_group_chat/services/local_notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Me UP',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        //backgroundColor: Colors.pink,--
        colorScheme: ColorScheme.fromSwatch(
          //accentColor: Colors.pink,
          //brightness: Brightness.dark,
          primarySwatch: Colors.pink,
        ),
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        textTheme: const TextTheme(
            headline1: TextStyle(
          color: Colors.blueGrey,
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const SplashScreen();
          // }
          if (snapshot.hasData) {
            return ChatScreen();
          } else {
            return AuthScreen();
          }
        },
      ),
      // routes: {
      //   AuthScreen.id: (context) => AuthScreen(),
      //   ChatScreen.id: (context) => ChatScreen(),
      // },
    );
  }
}
