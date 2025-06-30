class HPModel {
  final int hpid;
  final String hp;

  HPModel({required this.hpid, required this.hp});

  factory HPModel.fromJson(Map<String, dynamic> json) {
    return HPModel(hpid: json['HPID'], hp: json['HP']);
  }

  Map<String, dynamic> toJson() {
    return {'HPID': hpid, 'HP': hp};
  }

  factory HPModel.fromMap(Map<String, dynamic> map) {
    return HPModel(hpid: map['HPID'], hp: map['HP']);
  }

  Map<String, dynamic> toMap() {
    return {'HPID': hpid, 'HP': hp};
  }
}
