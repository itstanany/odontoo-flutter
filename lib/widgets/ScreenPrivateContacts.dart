import 'package:flutter/material.dart';

import '../data/db/user_database.dart';

class ScreenPrivateContact extends StatefulWidget {
  const ScreenPrivateContact({super.key});

  @override
  State<ScreenPrivateContact> createState() => _ScreenPrivateContactState();
}

class _ScreenPrivateContactState extends State<ScreenPrivateContact> {
  String contacts = "Placeholder... Loading";
  final db = $FloorUserDatabase.databaseBuilder("user_database.db").build();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db.then((value) =>
        value.contactDao.getAllContacts()
            .then((value) => setState(() {
              contacts = value.first.name.toString();
            })
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Text(contacts);
  }
}
