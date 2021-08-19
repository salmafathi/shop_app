import 'package:shop_app/models/LoginModel.dart';

abstract class SignUpState {}
class SignUpInitialState extends SignUpState {}
class SignUpLoadingState extends SignUpState {}
class SignUpSuccessState extends SignUpState {
  late final LoginModel SignUpModelObject;
  SignUpSuccessState(this.SignUpModelObject);
}
class SignUpErrorState extends SignUpState {
  final String? errorString ;
  SignUpErrorState(this.errorString);

}

class SignUpPasswordVisibilityState extends SignUpState {}

