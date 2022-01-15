class StateModelPAC {
  int id = -1;
  String title = "";
  //List<String> lgas = [];

  StateModelPAC({required this.id, required this.title});

  StateModelPAC.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    //lgas = json['lgas'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    //data['lgas'] = this.lgas;
    return data;
  }
}