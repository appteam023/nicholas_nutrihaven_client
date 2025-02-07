class ApiExceptions implements Exception {
  final _message;
  final _prefix;

  ApiExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix: $_message';
  }
}

class BadRequestException extends ApiExceptions {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}

class UnAuthorizeException extends ApiExceptions {
  UnAuthorizeException([String? message]) : super(message, 'UnAuthorize');
}

class NotFoundException extends ApiExceptions {
  NotFoundException([String? message]) : super(message, 'Not found');
}

class NoInternetException extends ApiExceptions {
  NoInternetException([String? message])
      : super(message, 'No Internet Connection');
}
