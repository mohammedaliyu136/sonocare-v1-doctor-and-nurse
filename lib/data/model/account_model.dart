class AccountInfoModel{
  String accountNumber = '';
  String accountBank = '';
  String bankCode = '';
  String accountName = '';

  AccountInfoModel({required this.accountName, required this.accountNumber, required this.accountBank, required this.bankCode});

  AccountInfoModel.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    accountBank = json['account_bank'];
    accountName = json['account_name'];
    bankCode = json['bank_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['account_number'] = accountNumber;
    json['account_bank'] = accountBank;
    json['account_name'] = accountName;
    json['bank_code'] = bankCode;
    return json;
  }
}