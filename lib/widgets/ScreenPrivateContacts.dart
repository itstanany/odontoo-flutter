import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:odontoo/data/db/entities/UserContactDBEntity.dart';

import '../data/db/user_database.dart';

class ScreenPrivateContact extends StatefulWidget {
  const ScreenPrivateContact({super.key});

  @override
  State<ScreenPrivateContact> createState() => _ScreenPrivateContactState();
}

class _ScreenPrivateContactState extends State<ScreenPrivateContact> {
  List<UserContactDBEntity> _contacts = [];
  final db = $FloorUserDatabase.databaseBuilder("user_database.db").build();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db.then((value) =>
        value.contactDao.getAllContacts()
            .then((value) => setState(() {
              _contacts = value;
            })
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Odonto Connect"),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return ListTile(
            title: Text(contact.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min, // Control trailing icon size
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.whatsapp),
                  onPressed: () async {
                    // Check if both apps are installed before showing the menu
                    // final canLaunchWhatsapp = await canLaunchUrl(
                    //     Uri.parse('whatsapp://send?phone=$phone'));
                    // if (canLaunchWhatsapp) {
                    //   _launchWhatsapp(phone, prefilledMsg);
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text(
                    //           'Neither WhatsApp nor WhatsApp Business is installed'),
                    //     ),
                    //   );
                    // }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
                    // Handle phone call action (launch dialer)
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
