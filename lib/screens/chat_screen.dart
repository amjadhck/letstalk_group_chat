// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:letstalk_group_chat/services/local_notification_service.dart';
import 'package:letstalk_group_chat/widgets/chat/messages.dart';
import 'package:letstalk_group_chat/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const id = "/chat-screen";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void registerNotification() async {
    final FirebaseMessaging _messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permission");

      //when app is terminated
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        print(message!.data);
      });

      //foreground
      FirebaseMessaging.onMessage.listen((message) {
        print(message.notification!.title);
        print(message.notification!.body);
        LocalNotificationService.display(message);
      });
      //in background but not terminated
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print(message.notification!.title);
      });
    }
  }

  @override
  void initState() {
    registerNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Screen"),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
