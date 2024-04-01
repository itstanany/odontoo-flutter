import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'EG';
  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  Future<void> _launchWhatsapp(String phone, String text) async {
    final url = Uri.parse('whatsapp://send?phone=+201017001982&text=$text');
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

  Future<void> _launchWhatsappBusiness(String phone, String text) async {
    final url = Uri.parse(
        'whatsapp://send?phone=+201017001982&text=$text&app_name=com.whatsapp.w4b');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('WhatsApp Business not installed'),
        ),
      );
    }
  }

  Future<void> _showWhatsappMenu(String phone, String text) async {
    final result = await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choose WhatsApp App'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              _launchWhatsapp(phone, text);
            },
            child: const Text('WhatsApp'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              _launchWhatsappBusiness(phone, text);
            },
            child: const Text('WhatsApp Business'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Odonto Connect"),
      ),
      body: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Handle plus button press
            },
          ),
          Expanded(
            flex: 85, // Occupy 85% of the remaining space
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);
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
              // Replace "yourPhoneNumber" and "yourText" with your values
              final phone = "yourPhoneNumber";
              final text = "yourText";
              // Check if both apps are installed before showing the menu
              final canLaunchWhatsapp = await canLaunchUrl(
                  Uri.parse('whatsapp://send?phone=+201017001982'));
              if (canLaunchWhatsapp) {
                _launchWhatsapp(phone, text);
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
      ),
    );
  }
}
