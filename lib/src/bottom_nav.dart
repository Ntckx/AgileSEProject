import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/leaderboard_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  final user = FirebaseAuth.instance.currentUser;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MyHomePage(),
    MyHomePage(),
    MyLeaderBoardPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Retrieve Theme and Check Brightness
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Center(child: _pages.elementAt(_currentIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        
        // Set Colors Conditionally
        elevation: 0,
        selectedItemColor: isDarkMode ? Colors.white : Colors.black,
        unselectedItemColor: isDarkMode ? Colors.white70 : Colors.black54,
        
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.search, 0),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.home_outlined, 1),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.leaderboard_outlined, 2),
            label: 'Rank',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.account_circle_outlined, 3),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildIcon(IconData iconData, int index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (_currentIndex == index)
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              color: const Color(0xFFDA2D4A).withOpacity(0.3), // Updated to use the specific pink color
              shape: BoxShape.circle,
            ),
          ),
        Icon(
          iconData,
          size: 40.0,
          color: _currentIndex == index
              ? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
              : (Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54),
        ),
      ],
    );
  }
}
