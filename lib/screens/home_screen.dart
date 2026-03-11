import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/local_keys.dart';
import 'package:todo_list_app/screens/add_task_screen.dart';
import 'package:todo_list_app/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance; // firestore database instance

  // text controls
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // selected date and time
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  List<Map<String, dynamic>> tasks = [];

  // @override
  // void initState() {
  //
  //   firestore.collection("tasks").get().then(
  //         (querySnapshot) {
  //       print("Successfully completed");
  //       for (var docSnapshot in querySnapshot.docs) {
  //         print('${docSnapshot.id} => ${docSnapshot.data()}');
  //         tasks.add(docSnapshot.data());
  //       }
  //     },
  //     onError: (e) => print("Error completing: $e"),
  //   );
  //   // TODO: implement initState
  //   super.initState();
  // }

// add task dialog
  void openAddTaskDialog() {
    showDialog(
      context: context,
      builder: (cotext) {
        return AlertDialog(
          title: Text("Add Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: () async {
                  Navigator.pop(context);
                  await pickDate();
                },
                icon: const Icon(Icons.send),
                label: const Text(""),
              ),
            ],
          ),
        );
      },
    );
  }

  // date picker
  Future<void> pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      confirmText: 'Choose time',
    );
    if (date != null) {
      selectedDate = date;
      await pickTime();
    }
  }

  // time picker
  Future<void> pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      confirmText: 'Save',
    );
    if (time != null) {
      selectedTime = time;
      saveTask();
    }
  }

  // save task to firestore

  Future<void> saveTask() async {
    await firestore.collection("tasks").add({
        "title": titleController.text,
        "description": descriptionController.text,
        "date": selectedDate!.toString(),
        "time": selectedTime!.format(context),
      // "created": Timestamp.now()
      });

    titleController.clear();
    descriptionController.clear();
  }

  // design
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
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("tasks").orderBy("createdat").snapshots(),
        builder: (context,snapshot) {
          print("stream builder started");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }
          if(!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            print("stream builder data is empty");

          return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "What do you want to do today?",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Tap + to add yor tasks",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          }
          final tasks = snapshot.data!.docs;

          // )
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              var task = tasks[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child:  ListTile(
                  title: Text(task["title"]),
                  subtitle: Text(
                    "${task["description"]}"
                        "\n${"date"} ${task["time"]}",
                  ),
                ),
              );
            },
          );
        },
      ),

      // display tasks from firestore

      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        backgroundColor: Color(0xFF6C63FF),
        onPressed: openAddTaskDialog,
        child: Icon(Icons.add, size: 25),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.home)),
            IconButton(onPressed: () {}, icon: Icon(Icons.person)),
          ],
        ),
      ),
    );
  }
}
