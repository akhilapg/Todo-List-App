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
    double sh = MediaQuery.sizeOf(context).height;
    double sw = MediaQuery.sizeOf(context).width;
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
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text("Tap + to add yor tasks", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        backgroundColor: Color(0xFF6C63FF),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: SizedBox(
                  height: sh * 0.35,
                  width: sw * double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Task",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: ()  {
                                 showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2050),
                                );
                                // if (picked != null) {
                                //   Navigator.pop(context)
                              },
                              icon: Icon(Icons.send, size: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );

          // Navigator.of(context).pop();
          // showDialog(context: context, builder: (context){
          //   return AlertDialog(
          //     title: Text("Add Task"),
          //     content: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         TextField(
          //           controller: titleController,
          //           decoration: const InputDecoration(
          //             labelText: "Task Title",
          //           ),
          //         ),
          //         TextField(
          //           controller: descriptionController,
          //           decoration: InputDecoration(
          //             labelText: "description",
          //           ),
          //         )
          //       ],
          //     ),
          //     actions: [
          //       ElevatedButton(onPressed: (){
          //         String title = titleController
          //       }, child: child)
          //     ],
          //   )
          // })
          // showModalBottomSheet(
          //   context: context,
          //   builder: (context) {
          //     return SizedBox(
          //       height: sh * 0.5,
          //       width: double.infinity,
          //       child: Padding(
          //         padding: const EdgeInsets.all(25.0),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               "Add Task",
          //               style: TextStyle(fontSize: 20, color: Colors.white),
          //             ),
          //             SizedBox(height: 20),
          //             TextFormField(
          //               decoration: InputDecoration(
          //                 border: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(5),
          //                 ),
          //                 hintText: "Title",
          //                 hintStyle: TextStyle(
          //                   fontSize: 12,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),
          //             SizedBox(height: 10),
          //             TextFormField(
          //               decoration: InputDecoration(
          //                 border: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(5),
          //                 ),
          //                 hintText: "Description",
          //                 hintStyle: TextStyle(
          //                   fontSize: 12,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),
          //             Align(
          //               alignment: Alignment.bottomRight,
          //               child: IconButton(
          //                 onPressed: () {
          //                   showDialog(
          //                     context: context,
          //                     builder: (context) {
          //                       DateTime selectDate = DateTime.now();
          //                       return Dialog(
          //                         shape: RoundedRectangleBorder(
          //                           borderRadius: BorderRadiusGeometry.circular(
          //                             20,
          //                           ),
          //                         ),
          //                         child: Container(
          //                           height: 500,
          //                           width: 400,
          //                           padding: EdgeInsets.all(16),
          //                           child: Column(
          //                             children: [
          //                               CalendarDatePicker(
          //                                 initialDate: DateTime.now(),
          //                                 firstDate: DateTime(2000),
          //                                 lastDate: DateTime(2050),
          //                                 onDateChanged: (date) {
          //                                   selectDate = date;
          //                                   print("Selected date : $date");
          //                                   Navigator.pushReplacement(
          //                                     context,
          //                                     MaterialPageRoute(
          //                                       builder: (context) =>
          //                                           HomeScreen(),
          //                                     ),
          //                                   );
          //                                 },
          //                               ),
          //                               // Spacer(),
          //                               Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceAround,
          //                                 children: [
          //                                   TextButton(
          //                                     onPressed: () {
          //                                       Navigator.pop(context);
          //                                     },
          //                                     child: Text("Cancel"),
          //                                   ),
          //                                   SizedBox(width: 10),
          //                                   ElevatedButton(
          //                                     onPressed: () async {
          //                                       TimeOfDay? time =
          //                                           await showTimePicker(
          //                                             context: context,
          //                                             initialTime:
          //                                                 TimeOfDay.now(),
          //                                           );
          //                                       if (time != null) {
          //                                         print(
          //                                           "Selected Time:${time.format(context)}",
          //                                         );
          //                                       }
          //                                     },
          //                                     child: Text("choose time"),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       );
          //                     },
          //                   );
          //                 },
          //                 icon: Icon(Icons.send, color: Colors.blue),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // );
        },
        child: Icon(Icons.add, size: 25),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child:
            // Container(
            //   height: 60,
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       // Icon(Icons.home)
            //       IconButton(onPressed: (){}, icon: Icon(Icons.home,size: 25,),),
            //       // Text("Home",style: TextStyle(fontSize: 10)),
            //     ],
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // buildNavItem(Icons.home, "Home"),
                // buildNavItem(Icons.person, "Profile")
                IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ],
            ),
      ),
    );
  }
}

// Widget buildNavItem(IconData icon,String label){
//   return Column(
//     children: [
//       Icon(icon),
//       Text(label)
//     ],
//   );
// }
