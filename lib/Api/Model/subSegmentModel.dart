class subSegmentModel {
  final int id;
  final int segmentId;
  final String subSegmentName;

  subSegmentModel({
    required this.id,
    required this.segmentId,
    required this.subSegmentName,
  });

  factory subSegmentModel.fromMap(Map<String, dynamic> map) {
    return subSegmentModel(
      id: map['id'],
      segmentId: map['segment_id'],
      subSegmentName: map['sub_segment_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'segment_id': segmentId,
      'sub_segment_name': subSegmentName,
    };
  }

  static List<subSegmentModel> subSegmentList = [];
}
