part of 'add_user_contact_bloc.dart';

@immutable
sealed class AddUserContactEvent {
  const AddUserContactEvent();
}

final class SubmitBtnClicked extends AddUserContactEvent {
  const SubmitBtnClicked();
}

final class AddUserPhoneNumClicked extends AddUserContactEvent {
  const AddUserPhoneNumClicked();
}

final class PhoneNumChanged extends AddUserContactEvent {
  const PhoneNumChanged(
    this.index,
    this.countryPhoneCode,
    this.phoneNumber,
  );
  final int index;
  final String countryPhoneCode;
  final String phoneNumber;
}
