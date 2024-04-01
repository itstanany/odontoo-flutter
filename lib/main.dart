import 'package:flutter/material.dart';
import 'package:odontoo/widgets/OnTheFlyWhatsAppConnect.dart';


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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Odonto Connect"),
      ),
      body: OnTheFlyWhatsAppConnect()
    );
  }
}
