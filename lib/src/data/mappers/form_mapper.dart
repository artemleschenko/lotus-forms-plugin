import 'package:lotus_forms_package/src/data/data.dart';
import 'package:lotus_forms_package/src/domain/domain.dart';

class FormMapper {
  static FormModel transformToModel(FormEntity entity) {
    // FIXME: implement transformToModel method
    return FormModel(id: entity.id, name: entity.name, elementForms: []);
  }

  static List<FormModel> transformToModelList(List<FormEntity> entities) {
    return entities.map((e) => transformToModel(e)).toList();
  }

  static FormEntity transformToEntity(FormModel model) {
    return FormEntity(id: model.id, name: model.name);
  }
}
