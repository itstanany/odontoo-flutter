import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/db/entities/UserContactDBEntity.dart';
import '../../../data/db/user_database.dart';

part 'add_user_contact_event.dart';
part 'add_user_contact_state.dart';

class AddUserContactBloc
    extends Bloc<AddUserContactEvent, AddUserContactState> {
  AddUserContactBloc() : super(AddUserContactStateInitial()) {
    on<AddUserContactEvent>((event, emit) {
      // TODO: implement event handler
      switch (event) {
        case SubmitBtnClicked sbc:
          // TODO: Handle this case.
          Future<void> saveContact() async {
            final formInput = state.addUserContactFormInput;
            // Get user input (name, note)
            final name = formInput.fullName;
            final note = formInput.notes;

            // Create UserContactDBEntity
            final contact = UserContactDBEntity(
              id: UniqueKey().toString(), // Generate a unique ID
              name: name,
              countryCodes: formInput
                  .dialCodes, // Assuming dialCodes represent country codes
              numbers: formInput.numbers,
              tags: const [], // Set tags to an empty list initially
              note: note,
              profilePic: null, // Set profilePic to null for now
            );
            final db =
                $FloorUserDatabase.databaseBuilder("user_database.db").build();

            db.then((value) => value.contactDao
                .insertContact(contact)
                .then((value) => print(value)));
            // Insert contact using ContactDao
            // await ContactDaoProvider.provide().contactDao.insertContact(contact);

            // Handle success or error (optional)
            print("Contact saved successfully!");
          }
          saveContact();
          break;
        case AddUserPhoneNumClicked aupnc:
          // TODO: Handle this case.
          final updatedFormInput = state.addUserContactFormInput.copyWith(
            numbers: [...state.addUserContactFormInput.numbers, ""],
            dialCodes: [...state.addUserContactFormInput.dialCodes, ""],
            keys: [
              ...state.addUserContactFormInput.keys,
              state.addUserContactFormInput.keys.last + 1
            ],
          );
          emit(AddUserContactStateActive(updatedFormInput));
          break;
        case RemovePhoneNumClicked rpnc:
          final int index = rpnc.index;
          final updatedFormInput = state.addUserContactFormInput.copyWith(
            numbers: [...state.addUserContactFormInput.numbers]
              ..removeAt(index),
            dialCodes: [...state.addUserContactFormInput.dialCodes]
              ..removeAt(index),
            keys: [...state.addUserContactFormInput.keys]..removeAt(index),
          );
          emit(AddUserContactStateActive(updatedFormInput));
          break;
        case PhoneNumChanged pnc:
          print(
              "handling phone num changed, ${pnc.index}-${event.countryPhoneCode}-${event.phoneNumber}");
          final updatedFormInput = state.addUserContactFormInput.copyWith(
            numbers: [...state.addUserContactFormInput.numbers]..[event.index] =
                event.phoneNumber,
            dialCodes: [...state.addUserContactFormInput.dialCodes]
              ..[event.index] = event.countryPhoneCode,
          );
          emit(AddUserContactStateActive(updatedFormInput));
          break;
        case FullNameChanged fnc:
          final updatedFormInput = state.addUserContactFormInput.copyWith(
            fullName: fnc.name,
          );
          emit(AddUserContactStateActive(updatedFormInput));
          break;

        case NotesChanged nc:
          final updatedFormInput = state.addUserContactFormInput.copyWith(
            notes: nc.notes,
          );
          emit(AddUserContactStateActive(updatedFormInput));
          break;
      }
    });
  }
}
