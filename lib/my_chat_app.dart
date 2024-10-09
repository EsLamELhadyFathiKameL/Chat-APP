import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/Screens/my_chat_page.dart';
import 'package:my_chat_app/Screens/my_login_page.dart';
import 'package:my_chat_app/Screens/my_register_page.dart';
import 'package:my_chat_app/firebase_options.dart';
import 'package:my_chat_app/my_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyChatAPP());
}

class MyChatAPP extends StatelessWidget {
  const MyChatAPP({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        kLoginPage: (context) => const MyLoginPage(),
        kRegisterPage: (context) => const MyRegisterPage(),
        kChatPage: (context) => const MyChatPage(),
      },
      initialRoute: kLoginPage,
    );
  }
}
