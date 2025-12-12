abstract interface class FormProvider {
  Future<void> getForms();
  Future<void> getForm(String formId);
}
