class PanelProductModel {
  final int panelProductID;
  final String panelProductName;

  PanelProductModel({
    required this.panelProductID,
    required this.panelProductName,
  });

  factory PanelProductModel.fromJson(Map<String, dynamic> json) {
    return PanelProductModel(
      panelProductID: json['PanelProductID'],
      panelProductName: json['PanelProductName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PanelProductID': panelProductID,
      'PanelProductName': panelProductName,
    };
  }

  factory PanelProductModel.fromMap(Map<String, dynamic> map) {
    return PanelProductModel(
      panelProductID: map['PanelProductID'],
      panelProductName: map['PanelProductName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'PanelProductID': panelProductID,
      'PanelProductName': panelProductName,
    };
  }
}
