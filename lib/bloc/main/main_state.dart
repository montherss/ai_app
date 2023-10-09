part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}
class MainChangeNavBar extends MainState {}
class MainChangeTheme extends MainState {}
class MainLoginNewUser extends MainState {}
class MainLoginCloseDialog extends MainState {}
class MainAddAllUSers extends MainState {}
class MainUserAllReadyLogin extends MainState {}
