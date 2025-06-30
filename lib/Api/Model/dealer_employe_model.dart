class DealerEmployee {
  final int dealerEmployeeID;
  final String employeeName;

  DealerEmployee({required this.dealerEmployeeID, required this.employeeName});

  factory DealerEmployee.fromJson(Map<String, dynamic> json) {
    return DealerEmployee(
      dealerEmployeeID: json['DealerEmployeeID'],
      employeeName: json['EmployeeName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'DealerEmployeeID': dealerEmployeeID, 'EmployeeName': employeeName};
  }

  factory DealerEmployee.fromMap(Map<String, dynamic> map) {
    return DealerEmployee(
      dealerEmployeeID: map['DealerEmployeeID'],
      employeeName: map['EmployeeName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'DealerEmployeeID': dealerEmployeeID, 'EmployeeName': employeeName};
  }
}
