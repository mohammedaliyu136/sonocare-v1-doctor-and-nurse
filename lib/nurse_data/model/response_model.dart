class ResponseModelNurse {
  bool _isSuccess;
  String _message;
  ResponseModelNurse(this._isSuccess, this._message);

  String get message => _message;
  bool get isSuccess => _isSuccess;
}