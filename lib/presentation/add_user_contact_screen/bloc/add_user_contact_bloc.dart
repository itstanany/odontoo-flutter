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
      }
    });
  }
}
