import 'package:lotus_forms_package/src/data/data.dart';
import 'package:lotus_forms_package/src/data/mappers/form_mapper.dart';
import 'package:lotus_forms_package/src/domain/domain.dart';

class OfflineRepositoryImpl implements OfflineRepository {
  final Database _database;
  OfflineRepositoryImpl(Database database) : _database = database;
  @override
  Future<List<FormModel>> getForms() {
    return _database.getForms().then(FormMapper.transformToModelList);
  }

  @override
  Future<bool> hasForms() {
    return _database.hasForms();
  }

  @override
  Future<void> insertForm(FormModel form) {
    return _database.insertForm(FormMapper.transformToEntity(form));
  }
}
