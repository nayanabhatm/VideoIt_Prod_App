/*
 * Contains user information received from backend server and other api calls.
 */

class User {

  static List<dynamic> _userPermission=[];
  static String _uuid;
  static String _session;
  static String _username;

  static void setUserPermission(List<dynamic> permission){
    for(int i=0;i<permission.length;i++){
      _userPermission.add(permission[i]);
    }
  }

  static void setUuid(String uuid){
    _uuid=uuid;
  }

  static void setSession(String session){
    _session=session;
  }

  static void setUserName(String username){
    _username=username;
  }

  static String get uuid => _uuid;
  static String get session => _session;
  static String get username => _username;
  static List<dynamic> get permissions => _userPermission;


}