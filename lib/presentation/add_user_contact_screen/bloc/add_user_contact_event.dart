part of 'add_user_contact_bloc.dart';

@immutable
sealed class AddUserContactEvent {
  const AddUserContactEvent();
}

final class _SubmitBtnClicked extends AddUserContactEvent {
  const _SubmitBtnClicked();
}

final class _AddUserPhoneNumClicked extends AddUserContactEvent {
  const _AddUserPhoneNumClicked();
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
