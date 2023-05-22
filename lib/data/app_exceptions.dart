class AppException implements Exception{
  final String? _message;
  final String? _prefix;
  AppException([this._message, this._prefix]);

  @override
  String toString(){
    return '$_prefix $_message';
  }
}

class FetchDataException extends AppException{
  FetchDataException([String? message]) : super(message, "Error during communication");
}

class BadRequestException extends AppException{
  BadRequestException([String? message]) : super(message, "Invalid request");
}

class UnAuthorisedException extends AppException{
  UnAuthorisedException([String? message]) : super(message, "UnAuthorised request");
}

class ServerBackendException extends AppException{
  ServerBackendException([String? message]) : super(message, "Server does not work properly");
}

class AppBackendException extends AppException{
  AppBackendException([String? message]) : super(message, "App handling error");
}