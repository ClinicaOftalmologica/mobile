import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/screens/MLCameraScreen.dart';

import '../screens/MLDashboardScreen.dart';
import '../screens/MLLoginScreen.dart';
import '../screens/MLSplashScreen.dart';
import '../share_preferens/user_preferences.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String camera = '/camera';
}

late List<CameraDescription> cameras;

Map<String, WidgetBuilder> getApplicationRoutes() {
  final prefs = UserPreferences();
  return <String, WidgetBuilder>{
    '/': (BuildContext context) =>
        prefs.isLogged ? MLDashboardScreen() : MLSplashScreen(),
    Routes.login: (BuildContext context) => MLLoginScreen(),
    Routes.home: (BuildContext context) => MLDashboardScreen(),
    '/camera': (BuildContext context) => MLCameraScreen(cameras: cameras),
  };
}
