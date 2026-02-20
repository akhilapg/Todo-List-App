import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Index"),
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile_pic'),
            radius: 25.0,
          ),
          SizedBox(width: 15,),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("What do you want to do today?",style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text("Tap + to add yor tasks",style: TextStyle(fontSize: 10),)
          ],
        ),
      ),
    );
  }
}
