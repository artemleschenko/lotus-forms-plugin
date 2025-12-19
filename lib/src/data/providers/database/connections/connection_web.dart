import 'package:drift/drift.dart';

DatabaseConnection connect(
  String dbName, {
  bool logStatements = false,
  bool inMemory = false,
}) {
  return DatabaseConnection.delayed(Future.error('DB not supported on Web'));
}
