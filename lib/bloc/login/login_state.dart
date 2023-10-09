part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginChangeVisible extends LoginState {}
class LoginChangeChageTrueValue extends LoginState {}


//-----------------------------------------LoginUSer------------------------------------------//
class LoginSuss extends LoginState{
  final UserCredential user ;
  final UserHome userHome ;
  LoginSuss(this.user , this.userHome);
}
class LoginLoding extends LoginState{}
class LoginError extends LoginState{
  final String error ;
  LoginError(this.error);
}
