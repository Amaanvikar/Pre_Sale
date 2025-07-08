class SegmentModel {
  final int segmentID;
  final String segmentName;

  SegmentModel({required this.segmentID, required this.segmentName});

  factory SegmentModel.fromJson(Map<String, dynamic> json) {
    return SegmentModel(
      segmentID: json['SegmentID'],
      segmentName: json['SegmentName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'SegmentID': segmentID, 'SegmentName': segmentName};
  }

  factory SegmentModel.fromMap(Map<String, dynamic> map) {
    return SegmentModel(
      segmentID: map['SegmentID'],
      segmentName: map['SegmentName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'SegmentID': segmentID, 'SegmentName': segmentName};
  }

  static List<SegmentModel> segmentList = [];
}
