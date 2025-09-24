import 'package:flutter/material.dart';
import 'BottomBar.dart';   // ✅ CustomSliverTabBar
import 'Header.dart';
import 'custom_tabbar.dart';




void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: HomePage(),
));

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _bottomIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // عندك 3 Tabs بالكود المعدل
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const CustomAppBar(), // ✅ الهيدر مع اللوجو

        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              CustomSliverTabBar(controller: _tabController),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const [
              Center(child: Text("request page")),
              Center(child: Text("service page")),
              Center(child: Text("suggestions page")),
            ],
          ),
        ),

        // ✅ البار السفلي
        bottomNavigationBar: BottomBar(
          onItemSelected: (index) {
            setState(() {
              _bottomIndex = index;
            });
          },
        ),
      ),
    );
  }
}
