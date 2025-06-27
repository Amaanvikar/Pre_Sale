class ApiEndPoints {
  static const String BASE_URL = '';
  static const String SUB_URL = '';

  static const String appLogin = '$BASE_URL$SUB_URL/loginUser';
  static const String getUserRole = '$BASE_URL$SUB_URL/getUserRole';
  static const String getAllMasterData = '$BASE_URL$SUB_URL/getAllMasterData';
  static const String getAllMasterDataById =
      '$BASE_URL$SUB_URL/getAllMasterDataById';
  static const String getAllMasterDataByTwoId =
      '$BASE_URL$SUB_URL/getAllMasterDataByTwoId';
  static const String getAllMasterDataByThreeId =
      '$BASE_URL$SUB_URL/getAllMasterDataByThreeId';
  static const String getAllMasterDataByFourId =
      '$BASE_URL$SUB_URL/getAllMasterDataByFourId';
  static const String addEnquiry = '$SUB_URL$BASE_URL/addEnquiry';
  static const String getByLoginUser =
      '$BASE_URL$BASE_URL/bindMasterCustomerList';
}
