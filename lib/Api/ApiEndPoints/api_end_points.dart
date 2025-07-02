class ApiEndPoints {
  static const String BASE_URL =
      'https://krios-poweroldmsapi.azurewebsites.net';
  static const String SUB_URL = '/api';

  static const String appLogin = '$BASE_URL$SUB_URL/LogIn/LoginUser';
  static const String getUserRole = '$BASE_URL$SUB_URL/LogIn/GetUserRole';

  static const String getAllMasterData =
      '$BASE_URL$SUB_URL/Common/GetAllMasterData';
  static const String getAllMasterDataById =
      '$BASE_URL$SUB_URL/Common/GetAllMasterDataById';
  static const String getAllMasterDataByTwoId =
      '$BASE_URL$SUB_URL/Common/GetAllMasterDataByTwoId';
  static const String getAllMasterDataByThreeId =
      '$BASE_URL$SUB_URL/Common/GetAllMasterDataByThreeId';
  static const String getAllMasterDataByFourId =
      '$BASE_URL$SUB_URL/Common/GetAllMasterDataByFourId';
  static const String addEnquiry = '$BASE_URL$SUB_URL/Enquiry/AddEnquiry';
  static const String bindMasterCustomerList =
      '$BASE_URL$SUB_URL/Enquiry/BindMasterCustomerList';
  static const String addFollowUp = '$BASE_URL$SUB_URL/FollowUp/AddFollowUp';
  static const String updateFollowUp =
      '$BASE_URL$SUB_URL/FollowUp/UpdateFollowUp';
  static const String getTransactionAddFollowUpList =
      '$BASE_URL$SUB_URL/FollowUp/GetTransactionAddFollowUpList';
  static const String getByLoginUser = '$BASE_URL$SUB_URL/LogIn/GetByLoginUser';
}
