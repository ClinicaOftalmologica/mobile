import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();
  late SharedPreferences _prefs;

  factory UserPreferences() => _instance;

  UserPreferences._internal();

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get prefsUser => _prefs;

  String get token => _prefs.getString('token') ?? '';
  String get id => _prefs.getString('id') ?? '';
  String get email => _prefs.getString('email') ?? '';
  String get username => _prefs.getString('username') ?? '';
  String get role => _prefs.getString('role') ?? '';

  set token(String token) => _prefs.setString('token', token);
  set id(String id) => _prefs.setString('id', id);
  set email(String email) => _prefs.setString('email', email);
  set username(String username) => _prefs.setString('username', username);
  set role(String role) => _prefs.setString('role', role);

  static void saveUserPreferences(User data) {
    final prefs = UserPreferences();

    prefs.token = data.token ?? '';
    prefs.id = data.id ?? '';
    prefs.email = data.email ?? '';
    prefs.username = data.username ?? '';
    prefs.role = data.role ?? '';
  }

  void clearUser() {
    _prefs.setString('token', '');
    _prefs.setString('id', '');
    _prefs.setString('email', '');
    _prefs.setString('username', '');
    _prefs.setString('role', '');
  }
}
