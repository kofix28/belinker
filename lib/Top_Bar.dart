import 'package:flutter/material.dart';

class Top_Bar extends StatelessWidget implements PreferredSizeWidget {
  const Top_Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'BeLinker',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/belinke_name.png',
          fit: BoxFit.contain,
          height: 32,
        ),
      ),
    );
  }


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
