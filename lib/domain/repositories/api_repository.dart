import 'package:bloc_vs_riverpod_example/common/network/api_service.dart';
import 'package:bloc_vs_riverpod_example/Data/models/api_response.dart';
class ApiRepository{
  final _provider = ApiService();

  //Recupération d'un fact
  Future<ApiResponse> fetchFact() {
    return _provider.fetchData();
  }


}