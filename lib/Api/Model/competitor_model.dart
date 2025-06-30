class Competitor {
  final int competitorID;
  final String competitorName;

  Competitor({required this.competitorID, required this.competitorName});

  factory Competitor.fromJson(Map<String, dynamic> json) {
    return Competitor(
      competitorID: json['CompetitorID'],
      competitorName: json['CompetitorName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'CompetitorID': competitorID, 'CompetitorName': competitorName};
  }

  factory Competitor.fromMap(Map<String, dynamic> map) {
    return Competitor(
      competitorID: map['CompetitorID'],
      competitorName: map['CompetitorName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'CompetitorID': competitorID, 'CompetitorName': competitorName};
  }
}
