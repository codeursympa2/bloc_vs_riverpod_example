import 'package:bloc_vs_riverpod_example/Data/models/api_response.dart';
import 'package:bloc_vs_riverpod_example/Data/models/fact.dart';
import 'package:dio/dio.dart';

class ApiService{
  //Pour http
  final Dio _dio=Dio();

  final String _url= 'https://uselessfacts.jsph.pl/random.json?language=en';

  //Recupération depuis l'API et gestion d'erreur
  Future<ApiResponse<Fact>> fetchData() async{
    try{
      Response  response =await _dio.get(_url);
      //en se basant sur le assert on retourne la réponse
      return ApiResponse(
        data: Fact.fromJson(response.data)
      );
    }catch(error, stacktrace){
      print("Exception levée: $error stackTrace: $stacktrace");

      return ApiResponse(
        success: false,
        error: "Data not found / Connection issue :\n${error.toString()}"
      );
    }
  }

}