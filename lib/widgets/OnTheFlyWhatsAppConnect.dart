import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:odontoo/data/db/entities/UserContactDBEntity.dart';
import 'package:odontoo/data/db/user_database.dart';
import 'package:url_launcher/url_launcher.dart';


class OnTheFlyWhatsAppConnect extends StatefulWidget {
  const OnTheFlyWhatsAppConnect({super.key});

  @override
  State<OnTheFlyWhatsAppConnect> createState() => _OnTheFlyWhatsAppConnectState();
}

class _OnTheFlyWhatsAppConnectState extends State<OnTheFlyWhatsAppConnect> {

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'EG';
  PhoneNumber number = PhoneNumber(isoCode: 'EG');
  // Replace "yourPhoneNumber" and "yourText" with your values
  String phone = "";
  String prefilledMsg = "";


  final db = $FloorUserDatabase
      .databaseBuilder("user_database.db")
      .build();


  Future<void> _launchWhatsapp(String phone, String text) async {
    final url = Uri.parse('whatsapp://send?phone=$phone&text=$text');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('WhatsApp not installed'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            // Handle plus button press
           db.then((value) =>
           value
               .contactDao
               .insertContact(UserContactDBEntity(id: "fdsfdsf", name: "Tanany", countryCodes: ["+20"], numbers: ["01017001982"], note: "First Contact Added"))
               .then((value) => print(value))
           );
          },
        ),
        Expanded(
          flex: 85, // Occupy 85% of the remaining space
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              print(number.phoneNumber);
              phone = number.phoneNumber ?? "";
            },
            onInputValidated: (bool value) {
              print(value);
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              useBottomSheetSafeArea: true,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: TextStyle(color: Colors.black),
            initialValue: number,
            textFieldController: controller,
            formatInput: true,
            keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
            inputBorder: OutlineInputBorder(),
            onSaved: (PhoneNumber number) {
              print('On Saved: $number');
            },
          ),
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.whatsapp),
          onPressed: () async {
            // Check if both apps are installed before showing the menu
            final canLaunchWhatsapp = await canLaunchUrl(
                Uri.parse('whatsapp://send?phone=$phone'));
            if (canLaunchWhatsapp) {
              _launchWhatsapp(phone, prefilledMsg);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Neither WhatsApp nor WhatsApp Business is installed'),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
