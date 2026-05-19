import 'package:get_storage/get_storage.dart';



class ApiConstants {
  ApiConstants._();

  // static const baseUrl = "http://nutrihaven.testdevlink.net/";
  static const baseUrl = "https://nutrihaven.testdevlink.net/";
  static const mainUrl = "$baseUrl/api/";
  static var publishKey = "";
  static var secretKey = "";
  static final storage = GetStorage();
  static var userId = "";
  static var foodLibAPIKey = "ad5927de50824cc5a961535177d92f10";
}
