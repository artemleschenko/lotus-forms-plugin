import 'package:lotus_forms_package/src/domain/domain.dart';
import 'package:lotus_forms_package/src/domain/repository/form_repository.dart';

import '../use_cases/use_case.dart';

class GetFormUseCase implements FutureUseCase<String, FormModel> {
  const GetFormUseCase(FormRepository formRepository)
    : _formRepository = formRepository;
  final FormRepository _formRepository;

  @override
  Future<FormModel> execute(String input) {
    return _formRepository.getForm(input);
  }
}
