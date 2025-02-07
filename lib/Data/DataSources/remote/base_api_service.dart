abstract class BaseApiServices {
  Future<dynamic> GetResponse({
    required String url,
    bool isTokenRequired,
  });

  Future<dynamic> PostResponse(
      {required String url,
      required Map<String, dynamic> data,
      bool isTokenRequired = true});

  Future<dynamic> PutResponse(
      {required String url,
      required Map<String, dynamic> data,
      bool isTokenRequired = true});
}
