class ErrorTranslator {
  static Map<String, String> codeMap = {
    "server_unreachable": "Server is unreachable",
    "confirm_password_different": "Password and confirm password are different",
    "login_successful": "Login was successful",
    "empty_fields": "Please fill in all fields"
  };
  static trans(String errorCode) {
    return (codeMap.containsKey(errorCode)) ? codeMap[errorCode] : errorCode;
  }
}