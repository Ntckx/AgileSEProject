import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/leaderboard_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    MyHomePage(),
    MyHomePage(),
    Leaderboard(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages.elementAt(_currentIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _onItemTapped(index);
        },
        showUnselectedLabels: true,
        selectedItemColor: const Color(0xFFDA2D4A),
        backgroundColor: Colors.white60,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 40.0,
                color: Colors.black,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 40.0,
                color: Colors.black,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.leaderboard_outlined,
                size: 40.0,
                color: Colors.black,
              ),
              label: 'Rank'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
                size: 40.0,
                color: Colors.black,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    return setState(() {
      _currentIndex = index;
    });
  }
}
