class VitalSignModel {
  late int vitalSignId;
  late String bloodPressure;
  late String temperature;
  late String pulseRate;
  late String respiration;
  late String sp02;
  late String bodyMassIdex;

  VitalSignModel({required this.vitalSignId, required this.bloodPressure, required this.temperature, required this.pulseRate, required this.respiration, required this.sp02, required this.bodyMassIdex});

  VitalSignModel.fromJson(Map<String, dynamic> json) {}


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vitalsign_id'] = vitalSignId.toString();
    data['blood_group'] = bloodPressure;
    data['temprature'] = temperature;
    data['pulse_rate'] = pulseRate;
    data['respiration'] = respiration;
    data['sp02'] = sp02;
    data['body_mass'] = bodyMassIdex;
    return data;
  }
}
