part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeChangeColorRandom extends HomeState {}
class HomeChangeScreen extends HomeState {}
class HomeChangeTimeVisibale extends HomeState {}
class HomeChangeTimeVisibaleSender extends HomeState {}
class HomeGetDataFromApiLoading extends HomeState {}
class HomeGetDataFromApiSuss extends HomeState {}
class HomeGetDataFromApiError extends HomeState {
  final String error ;
  HomeGetDataFromApiError(this.error);
}
class HomeGetDataFromApiImageLoading extends HomeState {}
class HomeGetDataFromApiImageSuss extends HomeState {}
class HomeGetDataFromApiImageError extends HomeState {
  final String error ;
  HomeGetDataFromApiImageError(this.error);
}
