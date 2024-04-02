import 'package:flutter/material.dart';
import 'package:odontoo/data/db/shared_database.dart';
import 'package:odontoo/widgets/OnTheFlyWhatsAppConnect.dart';
import 'package:odontoo/widgets/ScreenPrivateContacts.dart';


void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = $FloorSharedDatabase
  .databaseBuilder("shared_database.db")
  .build();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Odonto Connect"),
      ),
      body:Column(
        children: [
          OnTheFlyWhatsAppConnect(),
          InkWell( // Wrap the entire Card
            onTap: () {
              // Navigate to ScreenPrivateContact on tap
              Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenPrivateContact()));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "جهات الاتصال الخاصة",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
