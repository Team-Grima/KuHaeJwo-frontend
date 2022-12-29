class ServiceResponse<T> {
  bool result;
  String errorMsg;
  T? value;

  ServiceResponse({required this.result, this.value, this.errorMsg = ''});
}
