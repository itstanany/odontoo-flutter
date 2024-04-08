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
        case _SubmitBtnClicked():
        // TODO: Handle this case.
        case _AddUserPhoneNumClicked():
        // TODO: Handle this case.
        case PhoneNumChanged():
          if (event is PhoneNumChanged) {
            print(
                "handling phone num changed, ${event.index}-${event.countryPhoneCode}-${event.phoneNumber}");
            final updatedFormInput = state.addUserContactFormInput.copyWith(
              numbers: [...state.addUserContactFormInput.numbers]
                ..[event.index] = event.phoneNumber,
              dialCodes: [...state.addUserContactFormInput.dialCodes]
                ..[event.index] = event.countryPhoneCode,
            );
            emit(AddUserContactStateActive(updatedFormInput));
          }
      }
    });
  }
}
