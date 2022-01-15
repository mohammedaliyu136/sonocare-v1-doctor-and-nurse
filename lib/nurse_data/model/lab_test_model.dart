class LabTestModel{
  String id = "";
  String name = "";
  LabTestModel({required this.id,required this.name});

  LabTestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class SubLabTestModel{
  String id = "";
  String name = "";
  SubLabTestModel({required this.id,required this.name});

  SubLabTestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}