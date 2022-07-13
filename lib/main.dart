import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/views/chat_room_screen.dart';
import 'package:chat_app/views/sign_in.dart';
import 'package:chat_app/views/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'helper/helper_function.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xff145C9E),
        scaffoldBackgroundColor: const Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
      ),
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  dynamic userIsLoggedIn;

  @override
  void initState() {
    super.initState();
  }

  getLoggedIn() async {
    await HelperFunction.getUserLoggedInSharedPreferences().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return userIsLoggedIn != null
        ? userIsLoggedIn
            ? const ChatRoom()
            : const Authenticate()
        : const Authenticate();
  }
}

class IAmBlank extends StatefulWidget {
  const IAmBlank({Key? key}) : super(key: key);

  @override
  State<IAmBlank> createState() => _IAmBlankState();
}

class _IAmBlankState extends State<IAmBlank> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
