class FormValidators {
  static String? requiredField(String? value) =>
      (value == null || value.isEmpty) ? 'This field is required' : null;

  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value) ? null : 'Invalid email format';
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Phone is required';
    return value.length < 6 ? 'Invalid phone number' : null;
  }

  static String? id(String? value, String name) =>
      (value == null || value.length < 5) ? 'Invalid $name' : null;

  static String? signature(List? value) =>
      (value?.isEmpty ?? true) ? 'Signature is required' : null;

  static String? date(DateTime? value) =>
      (value?.isAfter(DateTime.now()) ?? true) ? 'Date is not valid' : null;
}
