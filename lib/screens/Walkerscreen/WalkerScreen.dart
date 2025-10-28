import 'package:aidkriya/screens/Walkerscreen/bottomnav/Request/Request.dart';
import 'package:aidkriya/screens/Walkerscreen/bottomnav/chat/Wchatscreen.dart';
import 'package:aidkriya/screens/Walkerscreen/bottomnav/ongoing/wmap.dart';
import 'package:aidkriya/screens/Walkerscreen/bottomnav/profile/WProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:aidkriya/colors/MyColors.dart';


// Import the page widgets
// You'll need to create separate files for these, e.g., 'ongoing_page.dart'
// For this example, we'll keep the WalkerScreen logic in its own file
// and create simple placeholders for the other pages.


class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Wallet & Earnings', style: TextStyle(color: Colors.white, fontSize: 24)));
  }
}


class Walkerscreen extends StatefulWidget {
  const Walkerscreen({super.key});

  @override
  State<Walkerscreen> createState() => _Walkerscreen();
}

class _Walkerscreen extends State<Walkerscreen> {
  int _selectedIndex = 0; // Tracks the selected tab

  // List of widgets to display in the body
  static final List<Widget> _widgetOptions = <Widget>[
    const RequestScreen(),
    const Walkermap(),
    const ChatScreen(),
    const WalletScreen(),
    const WProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.darkBackground, // Use the dark background

      // The body only shows the currently selected page content
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      // The Bottom Navigation Bar remains persistent
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: MyColors.darkSurface, // Darker background for nav bar
        selectedItemColor: MyColors.accentBlue, // Blue selected icon
        unselectedItemColor: Colors.white.withOpacity(0.7),
        currentIndex: _selectedIndex, // Highlights the correct icon
        onTap: _onItemTapped, // Call the function to change the page
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk),
            label: 'Ongoing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}