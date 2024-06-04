import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilab_prokit/routes/application_routes.dart';
import 'package:medilab_prokit/screens/MLSplashScreen.dart';
import 'package:medilab_prokit/store/AppStore.dart';
import 'package:medilab_prokit/utils/AppTheme.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:nb_utils/nb_utils.dart';

import 'config/graphQL_service.dart';
import 'share_preferens/user_preferences.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize(aLocaleLanguageList: languageList());

  appStore.toggleDarkMode(value: getBoolAsync('isDarkModeOnPref'));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  final prefs = UserPreferences();
  await prefs.initPrefs();

  await Hive.initFlutter();
  Box<Map<dynamic, dynamic>> graphqlCacheBox;
  if (!Hive.isBoxOpen('graphqlCache')) {
    graphqlCacheBox = await Hive.openBox<Map<dynamic, dynamic>>('graphqlCache');
  } else {
    graphqlCacheBox = Hive.box<Map<dynamic, dynamic>>('graphqlCache');
  }

  GraphQLService.init(graphqlCacheBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '${'MediLab'}${!isMobile ? ' ${platformName()}' : ''}',
        /* home: MLSplashScreen(), */
        routes: getApplicationRoutes(),
        initialRoute: '/',
        theme: !appStore.isDarkModeOn
            ? AppThemeData.lightTheme
            : AppThemeData.darkTheme,
        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localeResolutionCallback: (locale, supportedLocales) => locale,
      ),
    );
  }
}
