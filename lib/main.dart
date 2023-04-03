import 'package:notpad_flutter/screens/HomePage.dart';
import 'package:notpad_flutter/screens/LoginPage.dart';
import 'package:notpad_flutter/screens/SingUpPage.dart';
import 'package:notpad_flutter/screens/Splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'splashscreen',
      routes: {
        '/': (context) => const HomePage(),
        'splashscreen': (context) => const Splashscreen(),
        'singup': (context) => const Singup(),
        'login': (context) => Login(),
      },
    );
  }
}
