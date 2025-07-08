class competitorModel {
  final int competitorID;
  final String competitorName;

  competitorModel({required this.competitorID, required this.competitorName});

  factory competitorModel.fromJson(Map<String, dynamic> json) {
    return competitorModel(
      competitorID: json['CompetitorID'],
      competitorName: json['CompetitorName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'CompetitorID': competitorID, 'CompetitorName': competitorName};
  }

  factory competitorModel.fromMap(Map<String, dynamic> map) {
    return competitorModel(
      competitorID: map['CompetitorID'],
      competitorName: map['CompetitorName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'CompetitorID': competitorID, 'CompetitorName': competitorName};
  }

  static List<competitorModel> competitorList = [];
}
