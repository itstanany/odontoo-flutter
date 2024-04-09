import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:odontoo/presentation/add_user_contact_screen/bloc/add_user_contact_bloc.dart';

class AddNewContactScreen extends StatefulWidget {
  const AddNewContactScreen({super.key});

  @override
  State<AddNewContactScreen> createState() => _AddNewContactScreenState();
}

class _AddNewContactScreenState extends State<AddNewContactScreen> {
  final defaultIsoCode = "EG";

  bool showNoteInputField = false;

  @override
  Widget build(BuildContext context) {
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
                          BlocProvider.of<AddUserContactBloc>(context)
                              .add(PhoneNumChanged(
                            index,
                            number.dialCode.toString(),
                            number.parseNumber(),
                          ));
                          // setState(() {
                          //   dialCodes[index] = number.dialCode.toString();
                          //   numbers[index] = number.parseNumber();
                          // });
                        },
                        initialValue: PhoneNumber(
                          isoCode: defaultIsoCode,
                        ),
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
  }
}
