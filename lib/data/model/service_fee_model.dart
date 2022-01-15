class ServiceFeeModel{
  String type = '';
  double consultationFee = 0;
  ServiceFeeModel({required this.type, required this.consultationFee});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['consultation_fee'] = this.consultationFee.toString();
    return data;
  }
}