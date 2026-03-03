import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/local_keys.dart';
import 'package:todo_list_app/screens/home_screen.dart';
import 'package:todo_list_app/screens/login_screen.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key}
      );

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 TextEditingController emailAddress=TextEditingController();
 TextEditingController password=TextEditingController();
 TextEditingController userName=TextEditingController();

    Future signUp() async{
      //creating firebase firestore object  to assing db varibale
      var    db = FirebaseFirestore.instance;
      // assing sharedprefernces intailization to prefs object vairble  to access local storage
      //capablity
      final prefs=await SharedPreferences.getInstance();
      // Create a new user with a first and last name
      final user = {
        "full_name": userName.text,
        "email_address": emailAddress.text,
        "password":password.text
      };

// Add a new document with a generated ID

      try {
        print("email address:${emailAddress.text}");
        print("password${password.text}");
        //calling firebase authentication for new user creating account with email and password
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress.text,
          password: password.text,
        );

    // this below code for checking current authnecation is success then only go to
        // to home screen like currently credentail user is null the meaning firebase authenctaion not created

        if(credential.user!=null){
          db.collection("users").doc(credential.user?.uid).set(user).then((_){
            print("data added with ${credential.user?.uid}");
          });
        prefs.setBool(LocalKeys.auth_key, true);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
      } on
      FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Register",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text("Username"),
              TextField(
                controller: userName,
                decoration: InputDecoration(
                  hintText: "Enter your Username",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text("Email Address"),
              TextField(
                controller: emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter your Email Address",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Password"),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text("Confirm Password"),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirm password",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Color(0xFF6C63FF),
                  ),
                  onPressed: () {
                    signUp();
                  },
                  child: Text("Register"),
                ),
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1)),
                  Text(" or ", style: TextStyle(color: Colors.grey)),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: BorderSide(color: Color(0xFF6C63FF))
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/google.png',
                      width: 48,
                      height: 48,
                    ),
                    SizedBox(height: 8),
                    Text("Register with Google"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: BorderSide(color: Color(0xFF6C63FF))
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/apple.png',
                      width: 48,
                      height: 48,
                    ),
                    SizedBox(height: 8),
                    Text("Register with Appe"),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.grey,fontSize: 10),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      " Login",
                      style: TextStyle(fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
