/*
 * Contains signed in user information.
 */
class UserInformation {

  static bool isAnonymous = false;
  static String username;
  static String emailId;
  static String tokenId;

  void setUsername(String aUserName) {
    username = aUserName;
  }

  void setEmailId(String aEmailId) {
    emailId = aEmailId;
  }

  void setToken(String aToken) {
    tokenId = aToken;
  }

}