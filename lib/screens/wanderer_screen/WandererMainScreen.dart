import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:aidkriya/colors/MyColors.dart';

import 'bottomnav/home.dart';

class WandererMainScreen extends StatefulWidget {
  const WandererMainScreen({super.key});

  @override
  State<WandererMainScreen> createState() => _WandererMainScreenState();
}

class _WandererMainScreenState extends State<WandererMainScreen> {
  int _selectedIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [
    const Home(),
    // const ActivityScreen(),
    // const ChatScreen(),
    // const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.useWhite,
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_walk_outlined), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),

      // Floating SOS button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.redAccent,
        child: const Text(
          "SOS",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
