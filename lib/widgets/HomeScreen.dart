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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Add some vertical spacing
          const SizedBox(height: 16),

          // OnTheFlyWhatsAppConnect widget
          const OnTheFlyWhatsAppConnect(),

          // Add some vertical spacing
          const SizedBox(height: 16),

          // InkWell for navigating to ScreenPrivateContact
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenPrivateContact(),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
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