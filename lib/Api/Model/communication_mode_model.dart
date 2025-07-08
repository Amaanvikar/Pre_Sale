class CommunicationModeModel {
  final int modeID;
  final String modeName;

  CommunicationModeModel({required this.modeID, required this.modeName});

  factory CommunicationModeModel.fromJson(Map<String, dynamic> json) {
    return CommunicationModeModel(
      modeID: json['ModeID'],
      modeName: json['ModeName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'ModeID': modeID, 'ModeName': modeName};
  }

  factory CommunicationModeModel.fromMap(Map<String, dynamic> map) {
    return CommunicationModeModel(
      modeID: map['ModeID'],
      modeName: map['ModeName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'ModeID': modeID, 'ModeName': modeName};
  }

  static List<CommunicationModeModel> communicationModeList = [];
}
