class DGOwnershipModel {
  final int dgOwnershipID;
  final String dgOwnershipName;

  DGOwnershipModel({
    required this.dgOwnershipID,
    required this.dgOwnershipName,
  });

  // From JSON (API)
  factory DGOwnershipModel.fromJson(Map<String, dynamic> json) {
    return DGOwnershipModel(
      dgOwnershipID: json['DGOwnerShipID'],
      dgOwnershipName: json['DGOwnerShipName'],
    );
  }

  // To JSON (API)
  Map<String, dynamic> toJson() {
    return {'DGOwnerShipID': dgOwnershipID, 'DGOwnerShipName': dgOwnershipName};
  }

  // From Map (for database)
  factory DGOwnershipModel.fromMap(Map<String, dynamic> map) {
    return DGOwnershipModel(
      dgOwnershipID: map['DGOwnerShipID'],
      dgOwnershipName: map['DGOwnerShipName'],
    );
  }

  // To Map (for database)
  Map<String, dynamic> toMap() {
    return {'DGOwnerShipID': dgOwnershipID, 'DGOwnerShipName': dgOwnershipName};
  }

  // Optional: Static cache list
  static List<DGOwnershipModel> dgOwnershipList = [];
}
