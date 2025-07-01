class ApiEndPoints {
  static const String BASE_URL =
      'https://krios-poweroldmsapi.azurewebsites.net';
  static const String SUB_URL = '/api';

  static const String appLogin = '$BASE_URL$SUB_URL/LogIn/LoginUser';
  static const String getUserRole = '$BASE_URL$SUB_URL/LogIn/GetUserRole';

  static const String getAllMasterData = '$BASE_URL$SUB_URL/getAllMasterData';
  static const String getAllMasterDataById =
      '$BASE_URL$SUB_URL/getAllMasterDataById';
  static const String getAllMasterDataByTwoId =
      '$BASE_URL$SUB_URL/getAllMasterDataByTwoId';
  static const String getAllMasterDataByThreeId =
      '$BASE_URL$SUB_URL/getAllMasterDataByThreeId';
  static const String getAllMasterDataByFourId =
      '$BASE_URL$SUB_URL/getAllMasterDataByFourId';
  static const String addEnquiry = '$SUB_URL$BASE_URL/Enquiry/AddEnquiry ';
  static const String bindMasterCustomerList =
      '$BASE_URL$BASE_URL/Enquiry/BindMasterCustomerList';
  static const String addFollowUp = '$BASE_URL$BASE_URL/FollowUp/AddFollowUp';
  static const String updateFollowUp =
      '$BASE_URL$BASE_URL/FollowUp/UpdateFollowUp';
  static const String getTransactionAddFollowUpList =
      '$BASE_URL$BASE_URL/FollowUp/GetTransactionAddFollowUpList';
  static const String getByLoginUser =
      '$BASE_URL$BASE_URL/LogIn/GetByLoginUser';
}
