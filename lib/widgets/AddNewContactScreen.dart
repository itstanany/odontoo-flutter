import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:odontoo/main.dart';
import 'package:odontoo/presentation/add_user_contact_screen/bloc/add_user_contact_bloc.dart';

import '../data/db/entities/UserContactDBEntity.dart';
import '../data/db/user_database.dart';

class AddNewContactScreen extends StatefulWidget {
  const AddNewContactScreen({super.key});

  @override
  State<AddNewContactScreen> createState() => _AddNewContactScreenState();
}

class _AddNewContactScreenState extends State<AddNewContactScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
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
  Future<void> saveContact() async {
    // Get user input (name, note)
    final name = nameController.text;
    final note = (showNoteInputField)
        ? notesController.text
        : ""; // Handle optional note

    // Create UserContactDBEntity
    final contact = UserContactDBEntity(
      id: UniqueKey().toString(), // Generate a unique ID
      name: name,
      countryCodes: dialCodes, // Assuming dialCodes represent country codes
      numbers: numbers,
      tags: const [], // Set tags to an empty list initially
      note: note,
      profilePic: null, // Set profilePic to null for now
    );
    final db = $FloorUserDatabase.databaseBuilder("user_database.db").build();

    db.then((value) =>
        value.contactDao.insertContact(contact).then((value) => print(value)));
    // Insert contact using ContactDao
    // await ContactDaoProvider.provide().contactDao.insertContact(contact);

    // Handle success or error (optional)
    print("Contact saved successfully!");

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    print(numbers);
    print(dialCodes);

    return BlocProvider<AddUserContactBloc>(
      create: (context) => AddUserContactBloc(),
      child: BlocBuilder<AddUserContactBloc, AddUserContactState>(
        builder: (context, state) {
          final addUFI = state.addUserContactFormInput;
          final bloc = BlocProvider.of<AddUserContactBloc>(context);
          return Column(
            children: [
              OutlinedButton(
                onPressed: () => bloc.add(
                    const SubmitBtnClicked()), // Call the saveContact function
                child: Text("Save Contact"),
              ),
              TextField(
                autocorrect: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "الاسم"),
                onChanged: (change) {
                  bloc.add(FullNameChanged(change));
                },
              ),
              ...List.generate(
                state.addUserContactFormInput.numbers.length,
                (index) => Row(
                  key: Key(addUFI.keys[index].toString()),
                  children: [
                    Expanded(
                      flex: 85, // Occupy 85% of the remaining space
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                          BlocProvider.of<AddUserContactBloc>(context)
                              .add(PhoneNumChanged(
                            index,
                            number.dialCode.toString(),
                            number.phoneNumber.toString(),
                          ));
                          // setState(() {
                          //   dialCodes[index] = number.dialCode.toString();
                          //   numbers[index] = number.parseNumber();
                          // });
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
                              bloc.add(const AddUserPhoneNumClicked());
                            })
                        : IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Handle delete button press
                              bloc.add(RemovePhoneNumClicked(index));
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
                  onChanged: (String text) {
                    bloc.add(NotesChanged(text));
                  },
                )
            ],
          );
        },
      ),
    );

    return Column(
      children: [
        OutlinedButton(
          onPressed: () => saveContact(), // Call the saveContact function
          child: Text("Save Contact"),
        ),
        TextField(
          autocorrect: false,
          decoration:
              InputDecoration(border: OutlineInputBorder(), hintText: "الاسم"),
          controller: nameController,
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
            controller: notesController,
          )
      ],
    );
  }
}
