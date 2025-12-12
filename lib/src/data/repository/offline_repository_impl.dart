import 'package:lotus_forms_package/src/data/data.dart';
import 'package:lotus_forms_package/src/data/mappers/form_mapper.dart';
import 'package:lotus_forms_package/src/domain/domain.dart';

class OfflineRepositoryImpl implements OfflineRepository {
  final Database _database;
  OfflineRepositoryImpl(Database database) : _database = database;
  @override
  Future<List<FormModel>> getForms() async {
    return _database.getForms().then(FormMapper.transformToModelList);
  }

  @override
  Stream<bool> hasForms() {
    return _database.hasForms();
  }
  
  @override
  Future<void> deleteForm(int id) {
    return _database.deleteForm(id);
  }
}
