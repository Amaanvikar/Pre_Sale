class CustomerTypeModel {
  final int customerTypeID;
  final String customerTypeName;

  CustomerTypeModel({
    required this.customerTypeID,
    required this.customerTypeName,
  });

  // Convert JSON map to CustomerTypeModel
  factory CustomerTypeModel.fromJson(Map<String, dynamic> json) {
    return CustomerTypeModel(
      customerTypeID: json['CustomerTypeID'] ?? 0,
      customerTypeName: json['CustomerTypeName'] ?? '',
    );
  }

  // Convert CustomerTypeModel to JSON map
  Map<String, dynamic> toJson() {
    return {
      'CustomerTypeID': customerTypeID,
      'CustomerTypeName': customerTypeName,
    };
  }

  Map<String, dynamic> toMap() => toJson();

  static List<CustomerTypeModel> customerTypeList = [];
}
