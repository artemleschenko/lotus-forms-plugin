enum FieldType { text, dropdown, file, unknown }

class FormOption {
  final String value;
  final String displayText;

  const FormOption({required this.value, required this.displayText});
}

class FormElementConfig {
  final String? placeholder;
  final List<FormOption> options;

  const FormElementConfig({this.placeholder, this.options = const []});
}

class FormElementEntity {
  final String id;
  final FieldType type;
  final String header;
  final bool isRequired;
  final FormElementConfig config;

  const FormElementEntity({
    required this.id,
    required this.type,
    required this.header,
    this.isRequired = false,
    required this.config,
  });
}

class FormModel {
  final String id;
  final String name;
  final List<FormElementEntity> elementForms;

  const FormModel({
    required this.id,
    required this.name,
    required this.elementForms,
  });
}
