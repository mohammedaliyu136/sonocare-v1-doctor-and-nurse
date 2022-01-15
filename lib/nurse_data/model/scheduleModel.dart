class ScheduleModel{
  String id = '';
  String date = '';
  String time = '';
  String day = '';

  ScheduleModel({required this.day,required this.date,required this.time,required this.id,});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['day'] = this.day;
    data['time'] = this.time;
    return data;
  }

  Map<String, dynamic> toJsonn() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dates_id'] = this.id;
    return data;
  }
  Map<String, dynamic> toJsonCreateSchedule({dates_id, time, day}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dates_id'] = 1;
    data['time'] = time;
    data['day'] = day;
    return data;
  }
}