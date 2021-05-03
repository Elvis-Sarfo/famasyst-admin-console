String validateEmail(String value) {
  final verifyEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (value.isEmpty) {
    return 'Please Enter Email';
  }
  if (!verifyEmail.hasMatch(value)) {
    return 'Enter a valid Email Address';
  }

  return null;
}

String emptyFeildValidator(String value) {
  if (value.isEmpty) {
    return 'Feild must not be empty';
  }
  return null;
}
