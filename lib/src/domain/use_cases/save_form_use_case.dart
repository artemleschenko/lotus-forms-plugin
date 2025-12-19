import '../domain.dart';
import '../use_cases/use_case.dart';

class SaveFormUseCase implements UseCase<FormModel, void> {
  const SaveFormUseCase(FormRepository formRepository)
    : _formRepository = formRepository;
  final FormRepository _formRepository;

  @override
  Future<void> execute(FormModel form) {
    return _formRepository.saveForm(form);
  }
}
