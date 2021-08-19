import 'package:dio/dio.dart';

class DioHelper{
  static late Dio dio ;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: 50000 ,
        sendTimeout: 50000,
        validateStatus: (status){return status! < 500;},
      )
    );
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
    String lang = 'en',
    String token = '' ,
}) async {
    dio.options.headers =
        {
          'lang': lang,
          'Content-Type':'application/json',
          'Authorization' : token ,
        }
    ;
    return await dio.get(path , queryParameters: query);
  }


  static Future<Response> postData({
    required String path,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token  ,
  }) async {
    dio.options.headers =
    {
      'lang': lang,
      'Content-Type':'application/json',
      'Authorization' : token??'' ,
    }
    ;
    return await dio.post(path,data: data , queryParameters: query);
  }



  static Future<Response> putData({
    required String path,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token  ,
  }) async {
    dio.options.headers =
    {
      'lang': lang,
      'Content-Type':'application/json',
      'Authorization' : token??'' ,
    }
    ;
    return await dio.put(path,data: data , queryParameters: query);
  }
}