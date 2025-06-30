class KVA {
  final int kvaID;
  final String kva;

  KVA({required this.kvaID, required this.kva});

  factory KVA.fromJson(Map<String, dynamic> json) {
    return KVA(kvaID: json['KVAID'], kva: json['KVA']);
  }

  Map<String, dynamic> toJson() {
    return {'KVAID': kvaID, 'KVA': kva};
  }

  factory KVA.fromMap(Map<String, dynamic> map) {
    return KVA(kvaID: map['KVAID'], kva: map['KVA']);
  }

  Map<String, dynamic> toMap() {
    return {'KVAID': kvaID, 'KVA': kva};
  }
}
