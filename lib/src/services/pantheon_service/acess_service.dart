import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models/user/user.dart';
import '../sharedpreferences_service/sharedpreferences_service.dart';

class AccessService {
  static final baseURL = dotenv.env['BASE_URL']!;
  static final clientId = dotenv.env['CLIENT_ID']!;
  static final clientSecret = dotenv.env['CLIENT_SECRET']!;
  static Future<User> login(String username, String password) async {
    final response = await getCSRFToken(username, password);
    final data = jsonDecode(response.body);

    final access = await getAuthToken('test_supervisor', 'aaaaaaaaaaaaaA@1',
        data['current_user']['roles'][1]);
    final accessData = jsonDecode(access.body);
    SharedPrefsService.setUserLoginInfo(data);
    SharedPrefsService.setUserAccess(jsonDecode(access.body));
    User user = User(
        id: data['current_user']['uid'].toString(),
        role: data['current_user']['roles'][1],
        csrf: data['csrf_token'],
      logout: data['logout_token'],
      jwt: accessData['access_token'],
      loginTime: DateFormat('h:mm a').format(DateTime.now())
    );
    return user;
  }

  static getCSRFToken(String username, String password) {
    final url = '${baseURL}user/login?_format=json';

    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': 'test_supervisor',
        'pass': 'aaaaaaaaaaaaaA@1'
      }),
    );
  }

  static logoutSession(String? csrfToken, String? logoutToken) {
    if (csrfToken == null || logoutToken == null) {
      return;
    }
    final url = '${baseURL}user/logout?_format=json&token=$logoutToken';

    return http.post(Uri.parse(url),
        headers: <String, String>{'X-CSRF-Token': csrfToken});
  }

  static getAuthToken(String username, String password, String userRole) {
    final url = '${baseURL}oauth/token?_format=json';
    final body = <String, String>{
      'username': username,
      'password': password,
      'client_id': clientId,
      'client_secret': clientSecret,
      'grant_type': 'password',
      'scope': userRole.toLowerCase(),
    };

    return http.post(
      Uri.parse(url),
      body: body,
    );
  }
}
