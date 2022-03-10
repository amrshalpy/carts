import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() async {
    dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: 'https://fakestoreapi.com/products'),
       
      );
  }

  static getData(){
    
  }
}
