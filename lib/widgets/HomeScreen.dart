import 'package:flutter/material.dart';

import '../data/db/shared_database.dart';
import 'OnTheFlyWhatsAppConnect.dart';
import 'ScreenPrivateContacts.dart';

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
