import 'package:lotus_forms_package/src/data/data.dart';
import 'package:lotus_forms_package/src/domain/domain.dart';

/// Test data factory for creating test instances
class TestDataFactory {
  /// Creates a simple FormEntity for testing
  static FormEntity createFormEntity({
    String id = 'test-form-1',
    String name = 'Test Form',
  }) {
    return FormEntity(id: id, name: name);
  }

  /// Creates a simple FormModel for testing
  static FormModel createFormModel({
    String id = 'test-form-1',
    String name = 'Test Form',
    List<FormElementEntity> elementForms = const [],
  }) {
    return FormModel(id: id, name: name, elementForms: elementForms);
  }

  /// Creates multiple FormEntity instances
  static List<FormEntity> createFormEntities(int count) {
    return List.generate(
      count,
      (index) => createFormEntity(
        id: 'test-form-${index + 1}',
        name: 'Test Form ${index + 1}',
      ),
    );
  }

  /// Creates multiple FormModel instances
  static List<FormModel> createFormModels(int count) {
    return List.generate(
      count,
      (index) => createFormModel(
        id: 'test-form-${index + 1}',
        name: 'Test Form ${index + 1}',
      ),
    );
  }

  /// Creates a FormElementEntity for testing
  static FormElementEntity createFormElement({
    String id = 'element-1',
    FieldType type = FieldType.text,
    String header = 'Test Header',
    bool isRequired = false,
    FormElementConfig? config,
  }) {
    return FormElementEntity(
      id: id,
      type: type,
      header: header,
      isRequired: isRequired,
      config: config ?? const FormElementConfig(),
    );
  }
}
