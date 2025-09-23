import 'package:flutter/material.dart';


class BottomBar extends StatelessWidget {
   const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('BeLinker'),
          ),

          bottomNavigationBar: BottomNavigationBar(

            selectedItemColor: Colors.black,     // اللون للآيكون/النص لما يكون مختار
            unselectedItemColor: Colors.grey, // اللون للآيكونات/النصوص الغير مختارة
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  label: 'Explore',
                  icon: Icon(Icons.search)

              ),BottomNavigationBarItem(
                  label: 'Review',
                  icon: Icon(Icons.star)
              ),BottomNavigationBarItem(
                  label: 'Deals',
                  icon: Icon(Icons.handshake)
              ),BottomNavigationBarItem(
                  label: 'Inbox',
                  icon: Icon(Icons.chat)
              ),
              BottomNavigationBarItem(
                  label: 'Profile',
                  icon: Icon(Icons.account_circle))
            ],
          ) ,
        )
    );
  }
}