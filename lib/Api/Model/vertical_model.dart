class VerticalModel {
  final int verticalID;
  final String verticalName;
  final String listAbbreviation;

  VerticalModel({
    required this.verticalID,
    required this.verticalName,
    required this.listAbbreviation,
  });

  // From JSON (API to model)
  factory VerticalModel.fromJson(Map<String, dynamic> json) {
    return VerticalModel(
      verticalID: json['VerticalID'],
      verticalName: json['VerticalName'],
      listAbbreviation: json['ListAbbreviation'],
    );
  }

  // To JSON (model to API or DB insert)
  Map<String, dynamic> toJson() {
    return {
      'VerticalID': verticalID,
      'VerticalName': verticalName,
      'ListAbbreviation': listAbbreviation,
    };
  }

  // From Map (DB to model)
  factory VerticalModel.fromMap(Map<String, dynamic> map) {
    return VerticalModel(
      verticalID: map['VerticalID'],
      verticalName: map['VerticalName'],
      listAbbreviation: map['ListAbbreviation'],
    );
  }

  // To Map (model to DB)
  Map<String, dynamic> toMap() {
    return {
      'VerticalID': verticalID,
      'VerticalName': verticalName,
      'ListAbbreviation': listAbbreviation,
    };
  }
}
