import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repository/getLocationDetails.dart';

part 'get_location_details_state.dart';

class GetLocationDetailsCubit extends Cubit<GetLocationDetailsState> {
  final GetLocationDetailsRepo getLocationDetailsRepo;

  GetLocationDetailsCubit({required this.getLocationDetailsRepo})
      : super(GetLocationDetailsInitial());

  getLocationDataCubit(double lat, double lon) {
    getLocationDetailsRepo.getLocationDetailsRepo(lat, lon).then((value) {
      print("value in Cubit ----------------------------- ${value["city"]}");
      emit(GetLocationDetailsSuccess(value));
    }).catchError((e) {
      emit(GetLocationDetailsError(e.toString()));
    });
  }
}
