
import 'package:nicholas_nutrihaven/Data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? response;
  String? message;

  ApiResponse.initial() : status = Status.INITIAL;

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.completed(this.response) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data: $response";
  }
}
