import 'package:flutter/cupertino.dart';
import 'package:todo_list_app/screens/home_screen.dart';
import 'package:todo_list_app/screens/profile_screen.dart';

class BottomNavProvider extends ChangeNotifier{
  List<Widget> screens=[HomeScreen(),ProfileScreen()];
  int current_index=0;


  void changeNavigation(int index){
    current_index=index;
    notifyListeners();

  }
  Widget profilePage(){
    return SizedBox();
  }

}