
class ValidationMixin {
  static String? descriptionValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description field must not be blank';
    } else if (value.length < 5) {
      return 'Description must be at least 5 characters long';
    }
    return null;
  }
}
