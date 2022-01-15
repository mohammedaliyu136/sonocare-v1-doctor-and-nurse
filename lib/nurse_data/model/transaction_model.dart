class NurseTransactionModel{
  String id = '';
  String status = '';
  String nurseID = '';
  String type = '';
  String amount = '';
  String createdAT = '';

  NurseTransactionModel({required this.id, required this.status, required this.nurseID, required this.type, required this.amount, required this.createdAT});

  NurseTransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    nurseID = json['nurse_id'];
    type = json['type'];
    amount = json['amount'];
    createdAT = json['created_at'];
  }
}