class ErrorTranslator {
  static Map<String, String> code_map = {
    "server_unreachable": "Server is unreachable",
    "confirm_password_different": "Password and confirm password are different",
    "login_successful": "Login was successful",
    "empty_fields": "Please fill in all fields"
  };
  static trans(String error_code) {
    return (code_map.containsKey(error_code)) ? code_map[error_code] : error_code;
  }
}