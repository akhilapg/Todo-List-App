import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/local_keys.dart';
import 'package:todo_list_app/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Index"),
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions: [
          CircleAvatar(
            radius: 25.0,
            child: IconButton(
              onPressed: () async {
                final prefs=await SharedPreferences.getInstance();
                prefs.setBool(LocalKeys.auth_key, false);
                await FirebaseAuth.instance.signOut().then((_) {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                });
              },
              icon: Icon(Icons.logout),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "What do you want to do today?",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 10),
            Text("Tap + to add yor tasks", style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF6C63FF),
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black26,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 8),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 15),
            label: "Index",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 15),
            label: "Calender",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer, size: 15),
            label: "Focuse",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 15),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
