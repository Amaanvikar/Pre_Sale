class Segment {
  final int segmentID;
  final String segmentName;

  Segment({required this.segmentID, required this.segmentName});

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
      segmentID: json['SegmentID'],
      segmentName: json['SegmentName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'SegmentID': segmentID, 'SegmentName': segmentName};
  }

  factory Segment.fromMap(Map<String, dynamic> map) {
    return Segment(
      segmentID: map['SegmentID'],
      segmentName: map['SegmentName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'SegmentID': segmentID, 'SegmentName': segmentName};
  }
}
