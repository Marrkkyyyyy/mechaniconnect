validInput(val, type) {
  if (val.isEmpty) {
    return "Enter required field";
  }

  if (type == "name") {
    if (!isValidName(val)) {
      return "Invalid Name";
    }
  }
}

bool containsUppercase(String val) {
  return val.contains(RegExp(r'[A-Z]'));
}

bool containsLowercase(String val) {
  return val.contains(RegExp(r'[a-z]'));
}

bool isValidName(String name) {
  RegExp nameRegex = RegExp(r"^[A-Za-z.\- ]+$");
  return nameRegex.hasMatch(name);
}
