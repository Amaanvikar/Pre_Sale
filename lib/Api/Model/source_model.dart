class SourceModel {
  final int sourceID;
  final String sourceName;

  SourceModel({required this.sourceID, required this.sourceName});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      sourceID: json['SourceID'],
      sourceName: json['SourceName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'SourceID': sourceID, 'SourceName': sourceName};
  }

  factory SourceModel.fromMap(Map<String, dynamic> map) {
    return SourceModel(
      sourceID: map['SourceID'],
      sourceName: map['SourceName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'SourceID': sourceID, 'SourceName': sourceName};
  }

  static List<SourceModel> sourceList = [];
}
