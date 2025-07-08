class DealByModel {
  final int dealerEmployeeID;
  final String employeeName;

  DealByModel({required this.dealerEmployeeID, required this.employeeName});

  factory DealByModel.fromJson(Map<String, dynamic> json) {
    return DealByModel(
      dealerEmployeeID: json['DealerEmployeeID'],
      employeeName: json['EmployeeName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'DealerEmployeeID': dealerEmployeeID, 'EmployeeName': employeeName};
  }

  factory DealByModel.fromMap(Map<String, dynamic> map) {
    return DealByModel(
      dealerEmployeeID: map['DealerEmployeeID'],
      employeeName: map['EmployeeName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'DealerEmployeeID': dealerEmployeeID, 'EmployeeName': employeeName};
  }

  static List<DealByModel> dealByList = [];
}
