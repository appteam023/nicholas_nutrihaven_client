import 'package:nicholas_nutrihaven/Data/DataSources/remote/api_endpoints.dart';
import 'package:nicholas_nutrihaven/Data/DataSources/remote/network_api_service.dart';

class Addpreferencerepository {
  final NetworkApiService _networkApiService = NetworkApiService();

  postPreference(Map<String, dynamic> data, id) async {
    try {
      dynamic response = await _networkApiService.PostResponse(
          url: "user/addpreferences/$id", data: data, isTokenRequired: true);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
