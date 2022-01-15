class StateModel {
  late int id;
  late String name;

  StateModel({required this.id, required this.name,});

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['title'];
  }
}

class LGAModel {
  late int id;
  late String name;

  LGAModel({required this.id, required this.name,});

  LGAModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['title'];
  }
}
