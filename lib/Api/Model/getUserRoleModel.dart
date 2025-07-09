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
      roleId: json['RoleID'] ?? 0,
      roleName: json['RoleName'] ?? '',
      roleLevelId: json['RoleLevelID'] ?? 0,
      roleLevelName: json['RoleLevelName'] ?? '',
      verticalId: json['VerticalID'] ?? 0,
      verticalName: json['VerticalName'] ?? '',
      hierarchy: json['Hierarchy'] ?? 0,
      isExcelDownload: json['IsExcelDownload'] ?? false,
      isPdfDownload: json['IsPDFDownload'] ?? false,
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
      userId: map['UserId'] ?? 0,
      roleId: map['RoleID'] ?? 0,
      roleName: map['RoleName'] ?? '',
      roleLevelId: map['RoleLevelID'] ?? 0,
      roleLevelName: map['RoleLevelName'] ?? '',
      verticalId: map['VerticalID'] ?? 0,
      verticalName: map['VerticalName'] ?? '',
      hierarchy: map['Hierarchy'] ?? 0,
      isExcelDownload: (map['IsExcelDownload'] ?? 0) == 1,
      isPdfDownload: (map['IsPDFDownload'] ?? 0) == 1,
    );
  }
  @override
  String toString() {
    return 'UserRole(roleId: $roleId, roleName: $roleName)';
  }

  Map<String, dynamic> toMap() => toJson();

  static List<UserRole> userRoleList = [];
}
