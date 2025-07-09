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

  static List<competitorModel> competitorList = [];
}
