import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AddNewContactScreen extends StatefulWidget {
  const AddNewContactScreen({super.key});

  @override
  State<AddNewContactScreen> createState() => _AddNewContactScreenState();
}

class _AddNewContactScreenState extends State<AddNewContactScreen> {
  final TextEditingController controller = TextEditingController();
  final defaultIsoCode = "SA";
  late List<PhoneNumber> numbers;

   _AddNewContactScreenState() {
     numbers = [PhoneNumber(isoCode: defaultIsoCode)];
   }
  // Replace "yourPhoneNumber" and "yourText" with your values
  String phone = "";
  bool showNoteInputField = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autocorrect: false,
          decoration:
              InputDecoration(border: OutlineInputBorder(), hintText: "الاسم"),
        ),
        InternationalPhoneNumberInput(
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
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectorTextStyle: TextStyle(color: Colors.black),
          initialValue: numbers.first,
          textFieldController: controller,
          formatInput: true,
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          inputBorder: OutlineInputBorder(),
          onSaved: (PhoneNumber number) {
            print('On Saved: $number');
          },
        ),
        OutlinedButton(onPressed: () {
          setState(() {
            showNoteInputField = true;
          });
        }, child: Text("Press Here to add Notes -- optional")
        ),
        if(showNoteInputField) TextField(
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "Notes",
            border: OutlineInputBorder(),
          ),
        )
      ],
    );
  }
}
