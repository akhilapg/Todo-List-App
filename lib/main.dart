import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/firebase_options.dart';
import 'package:todo_list_app/local_keys.dart';
import 'package:todo_list_app/providers/bottom_nav_provider.dart';
import 'package:todo_list_app/screens/bottom_nav.dart';
import 'package:todo_list_app/screens/home_screen.dart';
import 'package:todo_list_app/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  var auth_status = prefs.getBool(LocalKeys.auth_key)?? false;
  runApp(MyApp(auth_status: auth_status));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.auth_status});

  var auth_status;

  @override
  Widget build(BuildContext context) {
    print("current auth status:$auth_status");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF6C63FF),
      ),
      home: auth_status ? ChangeNotifierProvider(
        create: (context) {
          return BottomNavProvider();
        }
        ,child:BottomNav() ,
      ) : LoginScreen(),
    );
  }
}
