import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final ValueChanged<int> onItemSelected;
  final Color color;
  final Color backgroundColor;

  const BottomBar({
    super.key,
    required this.onItemSelected,
    this.color = Colors.orange,
    this.backgroundColor = Colors.white,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 🔥 هنا خلينا الأحجام نسبية للشاشة
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return CurvedNavigationBar(

      index: currentIndex,
      height: min(screenHeight * 0.08, 75),
      color: widget.color,
      backgroundColor: widget.backgroundColor,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
        widget.onItemSelected(index);
      },
      items: [
        Icon(Icons.search, size: screenWidth * 0.08, color: Colors.white),
        Icon(Icons.star, size: screenWidth * 0.08, color: Colors.white),
        Icon(Icons.handshake, size: screenWidth * 0.08, color: Colors.white),
        Icon(Icons.chat, size: screenWidth * 0.08, color: Colors.white),
        Icon(Icons.account_circle, size: screenWidth * 0.08, color: Colors.white),
      ],
    );
  }
}
