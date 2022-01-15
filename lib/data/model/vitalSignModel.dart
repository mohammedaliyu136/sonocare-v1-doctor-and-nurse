class VitalSignModel {
  late String vitalSignId;
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
    return data;
  }
}
