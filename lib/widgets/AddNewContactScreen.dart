import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AddNewContactScreen extends StatefulWidget {
  const AddNewContactScreen({super.key});

  @override
  State<AddNewContactScreen> createState() => _AddNewContactScreenState();
}

class _AddNewContactScreenState extends State<AddNewContactScreen> {
  final TextEditingController controller = TextEditingController();
  final defaultIsoCode = "EG";
  late List<String> numbers;
  late List<String> dialCodes;
  late List<int> keys;

  _AddNewContactScreenState() {
    numbers = [
      "",
    ];
    dialCodes = [
      "",
    ];
    keys = [1];
  }

  // Replace "yourPhoneNumber" and "yourText" with your values
  String phone = "";
  bool showNoteInputField = false;

  @override
  Widget build(BuildContext context) {
    print(numbers);
    print(dialCodes);
    return Column(
      children: [
        TextField(
          autocorrect: false,
          decoration:
              InputDecoration(border: OutlineInputBorder(), hintText: "الاسم"),
        ),
        ...List.generate(
          numbers.length,
          (index) => Row(
            key: Key(keys[index].toString()),
            children: [
              Expanded(
                flex: 85, // Occupy 85% of the remaining space
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                    setState(() {
                      dialCodes[index] = number.dialCode.toString();
                      numbers[index] = number.parseNumber();
                    });
                  },
                  initialValue: PhoneNumber(
                    isoCode: defaultIsoCode,
                  ),
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
                  formatInput: true,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: OutlineInputBorder(),
                  onSaved: (PhoneNumber number) {
                    print('On Saved: $number');
                  },
                ),
              ),
              index == 0
                  ? IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        // Handle plus button press
                        setState(() {
                          numbers.add("");
                          dialCodes.add("");
                          keys.add(keys.last + 1);
                        });
                      })
                  : IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Handle delete button press
                        setState(() {
                          numbers.removeAt(index);
                          dialCodes.removeAt(index);
                          keys.removeAt(index);
                        });
                      },
                    ),
            ],
          ),
        ),
        OutlinedButton(
            onPressed: () {
              setState(() {
                showNoteInputField = true;
              });
            },
            child: Text("Press Here to add Notes -- optional")),
        if (showNoteInputField)
          TextField(
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
