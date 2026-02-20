import 'package:flutter/material.dart';
import 'package:todo_list_app/screens/login_screen.dart';

void main(){
 runApp(MyApp());
}
 class MyApp extends StatelessWidget {
   const MyApp({super.key});
 
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       title: 'UpTodo',
       theme: ThemeData(
         brightness: Brightness.dark,
         primaryColor: Color(0xFF6C63FF)
       ),
       home: LoginScreen(),
     );
   }
 }
 