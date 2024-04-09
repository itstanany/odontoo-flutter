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

final class RemovePhoneNumClicked extends AddUserContactEvent {
  final int index;
  const RemovePhoneNumClicked(this.index);
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

final class FullNameChanged extends AddUserContactEvent {
  final String name;
  const FullNameChanged(this.name);
}

final class NotesChanged extends AddUserContactEvent {
  final String notes;
  const NotesChanged(this.notes);
}
