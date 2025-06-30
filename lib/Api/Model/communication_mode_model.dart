class CommunicationMode {
  final int modeID;
  final String modeName;

  CommunicationMode({required this.modeID, required this.modeName});

  factory CommunicationMode.fromJson(Map<String, dynamic> json) {
    return CommunicationMode(
      modeID: json['ModeID'],
      modeName: json['ModeName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'ModeID': modeID, 'ModeName': modeName};
  }

  factory CommunicationMode.fromMap(Map<String, dynamic> map) {
    return CommunicationMode(modeID: map['ModeID'], modeName: map['ModeName']);
  }

  Map<String, dynamic> toMap() {
    return {'ModeID': modeID, 'ModeName': modeName};
  }
}
