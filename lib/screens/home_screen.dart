import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/local_keys.dart';
import 'package:todo_list_app/screens/add_task_screen.dart';
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
    double sh = MediaQuery
        .sizeOf(context)
        .height;
    double sw = MediaQuery
        .sizeOf(context)
        .width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Index"),
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions: [
          CircleAvatar(
            // backgroundImage: AssetImage('assets/images/profile_pic'),
            radius: 25.0,
            child: IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
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
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: sh * 0.8,
                    width: sw * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Add Task", style: TextStyle(
                            fontSize: 20, color: Colors.white),),
                        SizedBox(height: 20,),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),

                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Select date",
                              hintStyle: TextStyle(
                                fontSize: 12, color: Colors.white,),
                              suffixIcon
                              :IconButton(onPressed: () {

                                showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1990),
                                    lastDate: DateTime(2024).add(Duration(days: 365)));
                              }, icon: Icon(Icons.calendar_month))
                          ),
                        ),


                        // TextField(
                        //   decoration: InputDecoration(
                        //     hintText: 'Title',hintStyle: TextStyle(color: Colors.white)
                        //   ),
                        // ),
                        // TextField(
                        //   decoration: InputDecoration(
                        //     hintText: 'Description',hintStyle: TextStyle(color: Colors.white),
                        //   ),
                        // )

                      ],
                    ),
                  ),
                ),
              );
            },
          );

          // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen()));
          // showModalBottomSheet(context: context, builder: (BuildContext context) {
          //   return Container(
          //     height: 400,
          //     child: Center(child: Text('Text'),),
          //   );
          // });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
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
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.calendar_today, size: 15),
            //   label: "Calender",
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.timer, size: 15),
            //   label: "Focuse",
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 15),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
