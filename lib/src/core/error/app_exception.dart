abstract interface class AppException implements Exception {
  const AppException(this.message, {this.details});

  final String message;
  final String? details;
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.details});
}

class AuthorizationException extends AppException {
  const AuthorizationException(super.message, {super.details});
}

class UnexpectedAppException extends AppException {
  const UnexpectedAppException(super.message, {super.details});
}
