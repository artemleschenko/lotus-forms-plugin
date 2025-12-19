import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class NetworkInfo {
  Future<bool> get isConnected;
  Stream<InternetStatus> get onStatusChange;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection _checker = InternetConnection();

  @override
  Future<bool> get isConnected => _checker.hasInternetAccess;

  @override
  Stream<InternetStatus> get onStatusChange => _checker.onStatusChange;
}
