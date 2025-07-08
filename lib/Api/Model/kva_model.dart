class KVAModel {
  final int kvaID;
  final String kva;

  KVAModel({required this.kvaID, required this.kva});

  factory KVAModel.fromJson(Map<String, dynamic> json) {
    return KVAModel(kvaID: json['KVAID'], kva: json['KVA']);
  }

  Map<String, dynamic> toJson() {
    return {'KVAID': kvaID, 'KVA': kva};
  }

  factory KVAModel.fromMap(Map<String, dynamic> map) {
    return KVAModel(kvaID: map['KVAID'], kva: map['KVA']);
  }

  Map<String, dynamic> toMap() {
    return {'KVAID': kvaID, 'KVA': kva};
  }

  static List<KVAModel> kvaList = [];
}
