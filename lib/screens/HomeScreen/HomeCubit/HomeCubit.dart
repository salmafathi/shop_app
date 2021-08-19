import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/CategoriesModel.dart';
import 'package:shop_app/models/ChangeCartModel.dart';
import 'package:shop_app/models/FavoriteModel.dart';
import 'package:shop_app/models/GetCartsModel.dart';
import 'package:shop_app/models/GetFavoritesModel.dart';
import 'package:shop_app/models/HomeModel.dart';
import 'package:shop_app/models/LoginModel.dart';
import 'package:shop_app/screens/CartScreen/CartScreen.dart';
import 'package:shop_app/screens/HomeScreen/HomeCubit/HomeStates.dart';
import 'package:shop_app/screens/HomeScreen/categoriesScreen/categoriesScreen.dart';
import 'package:shop_app/screens/HomeScreen/favoriteScreen/FavoriteScreen.dart';
import 'package:shop_app/screens/HomeScreen/productsScreen/ProductsScreen.dart';
import 'package:shop_app/shared/Network/endpoints.dart';
import 'package:shop_app/shared/Network/remote/ExceptionsHandle.dart';
import 'package:shop_app/shared/Network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/constants.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> bottomNavScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    CartScreen(),
  ] ;
  int currentBottomNavIndex = 0 ;
  void changeBottomNav(int index){
    currentBottomNavIndex = index ;
    emit(HomeChangeBottomNavState());
  }


  //get home data
  HomeModel? homeModel ;

  Map<int,bool> productsIndicatorID_Fav ={};
  int counter = 0 ;

  Map<int,bool> productsIndicatorIDCart ={};
  int counterCart = 0 ;

void getHomeData(){
  emit(HomeLoadingState());
  DioHelper.getData(path: home,token: token.toString())
  .then((value) {

    homeModel = HomeModel.fromJson(value.data) ;
    print('hooooooooome Model : ${homeModel!.data}');
    homeModel!.data!.products.forEach((element) {
      // امشى على كل برودكت شوفى من المفضلات ولا لا و شوفى موجود فى الكارت ولا لا
        productsIndicatorID_Fav.addAll({
          element.id : element.inFavorites
        }) ;

        productsIndicatorIDCart.addAll({
          element.id : element.inCart
        }) ;

    });

    emit(HomeSuccessState());

  })
  .catchError((error){
    if (error is DioError)
     emit(HomeErrorState(exceptionsHandle(error: error)));
    else
      emit(HomeErrorState(error.toString()));
    print('error in Home  : ${error.toString()}');
  });
}


//get categories data
  CategoriesModel? categoriesModel ;
  void getCategoriesData(){
    DioHelper.getData(path:categories , lang: 'en')
        .then((value) {

      categoriesModel = CategoriesModel.fromJson(value.data) ;
      emit(CategoriesSuccessState());


    })
        .catchError((error){

      if (error is DioError)
        emit(CategoriesErrorState(exceptionsHandle(error: error)));
      else
        emit(CategoriesErrorState(error.toString()));
    });
  }


// change favorites
  ChangeFavoritesModel? changeFavModel ;
void changeFavorites (int productId){

    if (productsIndicatorID_Fav[productId] == true)
    {productsIndicatorID_Fav[productId]=false ;}
    else {
      productsIndicatorID_Fav[productId] = true ;
    }
    emit(FavoritesChangeState());

    DioHelper.postData(
        path: favorites,
        data: {'product_id' : productId},
        token: token)
        .then((value)
    {
         changeFavModel =  ChangeFavoritesModel.fromJson(value.data);

         if(changeFavModel!.status == false)
          {
            if (productsIndicatorID_Fav[productId] == true)
              productsIndicatorID_Fav[productId]=false ;
            else
              productsIndicatorID_Fav[productId] = true ;
          }
         else  {
           getFavoritesModel();
         }

          emit(FavoritesSuccessState(changeFavModel));
    })
        .catchError((error){

          if (productsIndicatorID_Fav[productId] == true)
            productsIndicatorID_Fav[productId]=false ;
          else
            productsIndicatorID_Fav[productId] = true ;

          emit(FavoritesErrorState(error));
    });
}


//get favorites data
  getFavModel? favsModel ;
  void getFavoritesModel(){

    emit(GetFavLoadingState());
    DioHelper.getData(path:favorites , lang: 'en',token: token.toString())
        .then((value) {
      favsModel = getFavModel.fromJson(value.data) ;
      counter = favsModel!.data!.data.length ;
      emit(GetFavSuccessState());


    })
        .catchError((error){
      if (error is DioError)
        emit(GetFavErrorState(exceptionsHandle(error: error)));
      else
        emit(GetFavErrorState(error.toString()));
    });
  }


// change cart
ChangeCartModel? changeCartModel ;
void changeCart (int productId){

  print('change Cart faun has been called');
  if (productsIndicatorIDCart[productId] == true) {productsIndicatorIDCart[productId]=false ;}
  else {productsIndicatorIDCart[productId] = true ;}
  print('Icon Changed firstly');
  emit(CartChangeState());

  DioHelper.postData(
      path: carts,
      data: {'product_id' : productId},
      token: token)
      .then((value)
  {
    changeCartModel =  ChangeCartModel.fromJson(value.data);
    print('Data posted and result data for changed one product  Status: ${changeCartModel!.status}');
    print('Data posted and result data for changed one product Mess : ${changeCartModel!.message}');
    print('Data posted and result data for changed one product ID : ${changeCartModel!.changedData.product!.id}');
    emit(CartChangeSuccessState(changeCartModel));

    if(changeCartModel!.status == false)
    {
      print('Status in Change Model == False !!!!');

      if (productsIndicatorIDCart[productId] == true) {productsIndicatorIDCart[productId]=false ;}
      else { productsIndicatorIDCart[productId] = true ;}
    }
    else  {
      print('Status changed == true and i will call get cart Method');
      getCartModel();
    }



  })
      .catchError((error){
        print('errrrrrrrrror${error.toString()}');

    if (productsIndicatorIDCart[productId] == true) {productsIndicatorIDCart[productId]=false ;}
    else { productsIndicatorIDCart[productId] = true ;}
    emit(CartChangeErrorState(error.toString()));
  });
}


//get cart data
  late getCartsModel getcartsModel ;
void getCartModel(){
  emit(GetCartLoadingState());
  DioHelper.getData(path:carts , lang: 'en',token: token.toString())
      .then((value) {
    getcartsModel = getCartsModel.fromJson(value.data) ;
    counterCart = getcartsModel.data!.cartItems.length ;
    emit(GetCartSuccessState());
  })
      .catchError((error){

    if (error is DioError)
      {emit(GetCartErrorState(exceptionsHandle(error: error)));
      print('Dio Error Happened : ${error.toString()}');}
    else
      {emit(GetCartErrorState(error.toString()));
      print('Error Happened : ${error.toString()}');}
  });
}


//get profile data
  LoginModel? loginModel ;
  void getLoginModel() async{
    emit(GetProfileLoadingState());
    await DioHelper.getData(path:profile ,token: token.toString())
        .then((value) {
      loginModel = LoginModel.fromJson(value.data) ;
      emit(GetProfileSuccessState(loginModel));
    })
        .catchError((error){
      if (error is DioError)
      {emit(GetCartErrorState(exceptionsHandle(error: error)));
      print('Dio Error Happened In profile: ${error.toString()}');}
      else
      {emit(GetCartErrorState(error.toString()));
      print('Error Happened In profile: ${error.toString()}');}
    });
  }
  
  
  //Update profile data
  void updateUserData({
    String? image,
    required String name ,
    required String email ,
    required String phone,
}) {
    emit(UpdateProfileLoadingState());
     DioHelper.putData(
         path:update ,
         token: token.toString(),
         data: {
           'name': name ,
           'email' : email ,
           'phone' : phone,
           'image' : image ,
         })
        .then((value) {
      loginModel = LoginModel.fromJson(value.data) ;
      emit(UpdateProfileSuccessState());
      getLoginModel();
    })
        .catchError((error){
      if (error is DioError)
      {emit(UpdateProfileErrorState(exceptionsHandle(error: error)));
      print('Dio Error Happened In profile: ${error.toString()}');}
      else
      {emit(UpdateProfileErrorState(error.toString()));
      print('Error Happened In profile: ${error.toString()}');}
    });
  }



  bool updatedUserFormData = false ;
  void onChangeEditText(){
    updatedUserFormData = ! updatedUserFormData ;
    emit(ActiveUpdateFormState());
  }

  bool changePhotoClicked = false ;
  void onchangePhotoClicked(){
    changePhotoClicked = ! changePhotoClicked ;
    emit(ChangePhotoClickedtate());
  }



}
