import 'package:flutter/material.dart';
import 'Top_Bar.dart';
import 'bottom_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BeLinker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(), // هنا تبدأ بالصفحة الرئيسية
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Top_Bar(),
      body: const Center(
        child: Text("محتوى الصفحة الرئيسية"),
      ),
      bottomNavigationBar:  BottomBar(),
    );
  }
}
