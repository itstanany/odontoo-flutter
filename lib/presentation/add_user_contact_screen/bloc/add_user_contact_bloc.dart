import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
