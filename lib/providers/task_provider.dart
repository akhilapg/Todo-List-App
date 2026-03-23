import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TaskProvider extends ChangeNotifier{
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance; // firestore database instance

  Future<void> updateTask(String id) async {
    await firestore.collection("tasks").doc(id).update({
      "title":titleController.text,
      "description":descriptionController.text,
    });
    titleController.clear();
    descriptionController.clear();
  }
}