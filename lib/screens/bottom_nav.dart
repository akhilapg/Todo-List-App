import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/providers/bottom_nav_provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    print("inside of widget build");
    return  Consumer<BottomNavProvider>(

      builder: (context,bottomNav,child) {
        print("inside of consumer");
        return Scaffold(
          body: bottomNav.screens[bottomNav.current_index],
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: () {
                  bottomNav.changeNavigation(0);
                }, icon: Icon(Icons.home)),
                IconButton(onPressed: () {
                  bottomNav.changeNavigation(1);

                }, icon: Icon(Icons.person)),
              ],
            ),
          ),
        );
      }
    );
  }
}
