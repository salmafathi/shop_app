import 'package:shop_app/models/ChangeCartModel.dart';
import 'package:shop_app/models/FavoriteModel.dart';
import 'package:shop_app/models/HomeModel.dart';
import 'package:shop_app/models/LoginModel.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeChangeBottomNavState extends HomeStates {}


class HomeLoadingState extends HomeStates {}
class HomeSuccessState extends HomeStates {}
class HomeErrorState extends HomeStates {
  final String? errorString ;
  HomeErrorState(this.errorString);
}


class CategoriesSuccessState extends HomeStates {}
class CategoriesErrorState extends HomeStates {
  final String? errorString ;
  CategoriesErrorState(this.errorString);
}


class FavoritesChangeState extends HomeStates {}
class FavoritesSuccessState extends HomeStates {
  late final ChangeFavoritesModel? changeFavModel ;
  FavoritesSuccessState(this.changeFavModel);
}
class FavoritesErrorState extends HomeStates {
  final String? errorString ;
  FavoritesErrorState(this.errorString);
}

class GetFavLoadingState extends HomeStates {}
class GetFavSuccessState extends HomeStates {}
class GetFavErrorState extends HomeStates {
  final String? errorString ;
  GetFavErrorState(this.errorString);
}



class CartChangeState extends HomeStates {}
class CartChangeSuccessState extends HomeStates {
  late final ChangeCartModel? changeCartModel ;
  CartChangeSuccessState(this.changeCartModel);
}
class CartChangeErrorState extends HomeStates {
  final String? errorString ;
  CartChangeErrorState(this.errorString);
}

class GetCartLoadingState extends HomeStates {}
class GetCartSuccessState extends HomeStates {}
class GetCartErrorState extends HomeStates {
  final String? errorString ;
  GetCartErrorState(this.errorString);
}


class GetProfileLoadingState extends HomeStates {}
class GetProfileSuccessState extends HomeStates {
  LoginModel?  profileModel ;
  GetProfileSuccessState(this.profileModel);
}
class GetProfileErrorState extends HomeStates {
  final String? errorString ;
  GetProfileErrorState(this.errorString);
}



class UpdateProfileLoadingState extends HomeStates {}
class UpdateProfileSuccessState extends HomeStates {}
class UpdateProfileErrorState extends HomeStates {
  final String? errorString ;
  UpdateProfileErrorState(this.errorString);
}


class ActiveUpdateFormState extends HomeStates {}
class ChangePhotoClickedtate extends HomeStates{}