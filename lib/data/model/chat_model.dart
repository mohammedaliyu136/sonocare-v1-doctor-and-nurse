class ChatModel {
  String _id = '';
  int _userId = 0;
  String? _message;
  String? _reply;
  String _createdAt = '';
  String _updatedAt = '';
  String _image = '';

  ChatModel(
      {required String id,
        required int userId,
        String? message,
        String? reply,
        required String createdAt,
        required String updatedAt,
        required String checked,
        required String image}) {
    this._id = id;
    this._userId = userId;
    this._message = message;
    this._reply = reply;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._image = image;
  }

  String get id => _id;
  int get userId => _userId;
  String? get message => _message;
  String? get reply => _reply;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get image => _image;

  ChatModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _message = json['message'];
    _reply = json['reply'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['message'] = this._message;
    data['reply'] = this._reply;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['image'] = this._image;
    return data;
  }
}

class MessageModel {
  String _id = '';
  int _userId = 0;
  String _email = '';
  String _messageSummary = '';
  bool _checked = false;
  int _counter = 0;
  String _createdAt = '';

  MessageModel(
      {
        required String id,
        required int userId,
        required String email,
        required String messageSummary,
        required String createdAt,
        required bool checked,
        required int counter,
      }) {
    this._id = id;
    this._userId = userId;
    this._email = email;
    this._messageSummary = messageSummary;
    this._createdAt = createdAt;
    this._checked = checked;
    this._counter = counter;
  }

  String get id => _id;
  int get userId => _userId;
  String get email => _email;
  String get messageSummary => _messageSummary;
  bool get checked => _checked;
  int get counter => _counter;
  String get createdAt => _createdAt;

  MessageModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _email = json['email'];
    _messageSummary = json['message_summary'];
    _checked = json['checked'];
    _counter = json['counter'];
    _createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['email'] = this._email;
    data['message_summary'] = this._messageSummary;
    data['checked'] = this._checked;
    data['counter'] = this._counter;
    data['created_at'] = this._createdAt;
    return data;
  }
}