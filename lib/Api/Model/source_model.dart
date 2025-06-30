class Source {
  final int sourceID;
  final String sourceName;

  Source({required this.sourceID, required this.sourceName});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(sourceID: json['SourceID'], sourceName: json['SourceName']);
  }

  Map<String, dynamic> toJson() {
    return {'SourceID': sourceID, 'SourceName': sourceName};
  }

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(sourceID: map['SourceID'], sourceName: map['SourceName']);
  }

  Map<String, dynamic> toMap() {
    return {'SourceID': sourceID, 'SourceName': sourceName};
  }
}
