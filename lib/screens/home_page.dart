import 'package:flutter/material.dart';
import 'package:society/providers/appbar.dart';
import 'package:society/providers/drawer.dart';
import 'profile_screen.dart';
import 'package:society/dialogs/connections_dialog.dart';
import 'create.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Center(child: Text("Home Screen")),
    Center(child: Text("Connections Placeholder")),
    Center(child: Text("Groups Screen")),
    ProfileScreen(),
    Center(child: Text("Create Screen")),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      showConnectionsDialog(context);
      // setState(() {
      //   _selectedIndex = index;
      // });
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      drawer: CustomDrawer(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home, color: Colors.blue),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore, color: Colors.blue),
              label: "Connections",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined),
              activeIcon: Icon(Icons.groups, color: Colors.blue),
              label: "Groups",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person, color: Colors.blue),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle, color: Colors.blue),
              label: "Create",
            ),
          ],
        ),
      ),
    );
  }
}
