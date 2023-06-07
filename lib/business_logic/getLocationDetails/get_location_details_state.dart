part of 'get_location_details_cubit.dart';

@immutable
abstract class GetLocationDetailsState {}

class GetLocationDetailsInitial extends GetLocationDetailsState {}

class GetLocationDetailsLoading extends GetLocationDetailsState {}

class GetLocationDetailsSuccess extends GetLocationDetailsState {
  final data;
  GetLocationDetailsSuccess(this.data);
}

class GetLocationDetailsError extends GetLocationDetailsState {
  final String error;

  GetLocationDetailsError(this.error);
}
