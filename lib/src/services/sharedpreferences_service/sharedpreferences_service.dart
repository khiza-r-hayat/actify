import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constants/strings.dart';

class SharedPrefsService {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();
  static setUserLoginInfo(userInfo) async {
    final prefs = await _prefs;
    prefs.setString(Strings.csrf, userInfo['csrf_token']);
    prefs.setString(Strings.userId, userInfo['current_user']['uid'].toString());
    prefs.setString(Strings.logoutToken, userInfo['logout_token']);
    prefs.setString(Strings.userRole, userInfo['current_user']['roles'][1]);
    prefs.setString(Strings.lastLoginDate, DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }
  static Future<Map<String,String>> getUserLoginInfo(userInfo) async {
    final prefs = await _prefs;
    final Map<String, String> data = {
      Strings.csrf: prefs.getString(Strings.csrf) ?? '',
      Strings.userId: prefs.getString(Strings.userId) ?? '',
      Strings.userRole: prefs.getString(Strings.userRole) ?? '',
      Strings.logoutToken: prefs.getString(Strings.logoutToken) ?? '',
    };
    return data;
  }
  static setUserAccess(accessInfo) async {
    final prefs = await _prefs;
    prefs.setString(Strings.jwt, accessInfo['access_token']);
    // prefs.setString(Strings.jwtExpiry, accessInfo['expires_in'].toString());
    prefs.setString(Strings.refreshToken, accessInfo['refresh_token']);
  }
  static Future<Map<String,String>> getUserAccess(accessInfo) async {
    final prefs = await _prefs;
    final Map<String, String> data = {
      Strings.jwt: prefs.getString(Strings.jwt) ?? '',
      // Strings.jwtExpiry: prefs.getString(Strings.jwtExpiry) ?? '',
      Strings.refreshToken: prefs.getString(Strings.refreshToken) ?? ''
    };
    return data;
  }
}
