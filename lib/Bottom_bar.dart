import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final ValueChanged<int> onItemSelected; // 👈 callback to parent

  const BottomBar({super.key, required this.onItemSelected}); // 👈 add it to constructor

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      height: 60,
      color: Colors.orange,
      backgroundColor: Colors.white,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
        widget.onItemSelected(index); // 👈 notify HomePage
      },
      items: const [
        Icon(Icons.search, size: 30, color: Colors.white),
        Icon(Icons.star, size: 30, color: Colors.white),
        Icon(Icons.handshake, size: 30, color: Colors.white),
        Icon(Icons.chat, size: 30, color: Colors.white),
        Icon(Icons.account_circle, size: 30, color: Colors.white),
      ],
    );
  }
}
