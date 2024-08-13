class AppException implements Exception {
  final dynamic message;
  final String _prefix;

  AppException(
    this.message,
    this._prefix,
  );

  @override
  String toString() {
    return "$_prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException({
    required String message,
  }) : super(
          message,
          "Error During Communication: ",
        );
}

class Handle500Exception extends AppException {
  Handle500Exception({required dynamic message})
      : super(
          message,
          "Error During Communication: ",
        );
}

class BadRequestException extends AppException {
  BadRequestException([
    message,
  ]) : super(
          message,
          "Invalid Request: ",
        );
}

class UnauthorisedException extends AppException {
  UnauthorisedException([
    message,
  ]) : super(
          message,
          "Unauthorised: ",
        );
}

class TokenExpired extends AppException {
  TokenExpired({required String message}) : super("", "");
}

class InvalidInputException extends AppException {
  InvalidInputException({
    required String message,
  }) : super(
          message,
          "Invalid Input: ",
        );
}

class ValidationException extends AppException {
  ValidationException()
      : super(
          "",
          "",
        );
}

class NotFoundException extends AppException {
  NotFoundException({required dynamic message}) : super(message, "");
}
