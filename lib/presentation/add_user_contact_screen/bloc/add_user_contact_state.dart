part of 'add_user_contact_bloc.dart';

@immutable
sealed class AddUserContactState {
  final AddUserContactFormInput addUserContactFormInput;
  // const AddUserContactState._({
  //   this.addUserContactFormInput = const AddUserContactFormInput(),
  // });
  //
  // const AddUserContactState.initial() : this._();
  //
  // const AddUserContactState.active(
  //   AddUserContactFormInput addUserContactFormInput,
  // ) : this._(addUserContactFormInput: addUserContactFormInput);

  const AddUserContactState(this.addUserContactFormInput);
}

class AddUserContactStateInitial extends AddUserContactState {
  const AddUserContactStateInitial() : super(const AddUserContactFormInput());
}

class AddUserContactStateActive extends AddUserContactState {
  const AddUserContactStateActive(
    AddUserContactFormInput addUserContactFormInput,
  ) : super(addUserContactFormInput);
}

class AddUserContactFormInput {
  final String fullName;

  final List<String> numbers;
  final List<String> dialCodes;
  final List<int> keys;

  const AddUserContactFormInput({
    this.numbers = const [""],
    this.dialCodes = const [""],
    this.keys = const [1],
    this.fullName = "",
  });

  AddUserContactFormInput copyWith({
    List<String>? numbers,
    List<String>? dialCodes,
    List<int>? keys,
    String? fullName,
  }) {
    return AddUserContactFormInput(
      numbers: numbers ?? this.numbers,
      dialCodes: dialCodes ?? this.dialCodes,
      keys: keys ?? this.keys,
      fullName: fullName ?? this.fullName,
    );
  }
}
