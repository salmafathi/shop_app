import 'package:shop_app/models/LoginModel.dart';

abstract class LoginState {}
class LoginInitialState extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {
  late final LoginModel loginModelObject;
  LoginSuccessState(this.loginModelObject);
}
class LoginErrorState extends LoginState {
   final String? errorString ;
  LoginErrorState(this.errorString);

}

class PasswordVisibilityState extends LoginState {}

