import 'package:resort_store/business_logic/contact/state.dart';
import 'package:resort_store/data/services/contacts/contacts.dart';
import 'package:bloc/bloc.dart';

class ContactCubit extends Cubit<ContactStates> {
  ContactCubit(this.contactService) : super(ContactInitState());
  ContactService contactService;

  sendContactCubit(Map<String, dynamic> body) {
    emit(ContactLoadingState());
    contactService.sendContactService(body).then((value) {
      emit(ContactSuccessState());
    }).catchError((e) {
      emit(ContactErrorState(e.toString()));
    });
  }
}
