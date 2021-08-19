import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/SearchModel.dart';
import 'package:shop_app/screens/HomeScreen/searchScreen/SearchCubit/SearchStates.dart';
import 'package:shop_app/shared/Network/endpoints.dart';
import 'package:shop_app/shared/Network/remote/ExceptionsHandle.dart';
import 'package:shop_app/shared/Network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel ;
  void searchOn(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(
        token: token,
        path: search,
        data: {
      'text':text
    })
    .then((value){
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    })
     . catchError ((error) {
      if (error is DioError)
      {print ('i am in Dio');
      emit(SearchErrorState(exceptionsHandle(error: error)));}
      else
      {
        print ('i am in cubit else');
        emit(SearchErrorState(error.toString()));
      }

    });
  }

}