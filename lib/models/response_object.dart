class ResponseObject {
  final String message;
  final bool success;
  final dynamic data;

  ResponseObject({required this.message, required this.success, this.data});
}