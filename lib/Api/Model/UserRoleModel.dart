class UserRole {
  final int userId;
  final int roleId;
  final String roleName;
  final int roleLevelId;
  final String roleLevelName;
  final int verticalId;
  final String verticalName;
  final int hierarchy;
  final bool isExcelDownload;
  final bool isPdfDownload;

  UserRole({
    required this.userId,
    required this.roleId,
    required this.roleName,
    required this.roleLevelId,
    required this.roleLevelName,
    required this.verticalId,
    required this.verticalName,
    required this.hierarchy,
    required this.isExcelDownload,
    required this.isPdfDownload,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      userId: json['UserId'] ?? 0,
      roleId: json['RoleID'],
      roleName: json['RoleName'],
      roleLevelId: json['RoleLevelID'],
      roleLevelName: json['RoleLevelName'],
      verticalId: json['VerticalID'],
      verticalName: json['VerticalName'],
      hierarchy: json['Hierarchy'],
      isExcelDownload: json['IsExcelDownload'],
      isPdfDownload: json['IsPDFDownload'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'RoleID': roleId,
      'RoleName': roleName,
      'RoleLevelID': roleLevelId,
      'RoleLevelName': roleLevelName,
      'VerticalID': verticalId,
      'VerticalName': verticalName,
      'Hierarchy': hierarchy,
      'IsExcelDownload': isExcelDownload ? 1 : 0,
      'IsPDFDownload': isPdfDownload ? 1 : 0,
    };
  }

  factory UserRole.fromMap(Map<String, dynamic> map) {
    return UserRole(
      userId: map['UserId'],
      roleId: map['RoleID'],
      roleName: map['RoleName'],
      roleLevelId: map['RoleLevelID'],
      roleLevelName: map['RoleLevelName'],
      verticalId: map['VerticalID'],
      verticalName: map['VerticalName'],
      hierarchy: map['Hierarchy'],
      isExcelDownload: map['IsExcelDownload'] == 1,
      isPdfDownload: map['IsPDFDownload'] == 1,
    );
  }
}
