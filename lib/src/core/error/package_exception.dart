abstract interface class PackageException implements Exception {
  const PackageException(this.message, {this.details});

  final String message;
  final String? details;
}

class NetworkException extends PackageException {
  const NetworkException(super.message, {super.details});
}

class AuthorizationException extends PackageException {
  const AuthorizationException(super.message, {super.details});
}

class UnexpectedAppException extends PackageException {
  const UnexpectedAppException(super.message, {super.details});
}
