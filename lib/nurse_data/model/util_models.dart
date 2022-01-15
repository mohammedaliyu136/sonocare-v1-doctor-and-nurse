class NurseType{
  String id = '';
  String title = '';
  NurseType({required this.id, required this.title});
  NurseType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}
class NurseService{
  String id = '';
  String title = '';
  NurseService({required this.id, required this.title});
  NurseService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}
class ServicePref{
  String id = '';
  String type = '';
  ServicePref({required this.id, required this.type});
  ServicePref.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }
}