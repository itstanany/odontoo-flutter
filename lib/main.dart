import 'package:flutter/material.dart';
import 'package:odontoo/widgets/AddNewContactScreen.dart';
import 'package:odontoo/widgets/HomeScreen.dart';
import 'package:odontoo/widgets/SupportScreen.dart';


void main() {
  runApp(MaterialApp(
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

    int _selectedIndex = 0; // Keep track of the selected index

    final List<Widget> _screens = [
      HomeScreen(),
      AddNewContactScreen(),
      SupportScreen(),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Odonto Connect'),
        ),
        body: _screens[_selectedIndex], // Display the selected screen
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue, // Adjust color as desired
          unselectedItemColor: Colors.grey, // Adjust color as desired
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Support',
            ),
          ],
        ),
      );
    }
}
