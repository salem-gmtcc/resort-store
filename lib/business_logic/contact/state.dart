import 'package:resort_store/data/services/contacts/contacts.dart';

abstract class ContactStates {}

class ContactInitState extends ContactStates {}

class ContactSuccessState extends ContactStates {}

class ContactLoadingState extends ContactStates {}

class ContactErrorState extends ContactStates {
  String? e;

  ContactErrorState(this.e);
}
