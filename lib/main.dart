// ignore_for_file: depend_on_referenced_packages
import 'package:actify/src/fetures/home/presentation/view/home_screen.dart';
import 'package:actify/src/fetures/splash_screen/splash_screen.dart';
import 'package:actify/src/theme/theme.dart';
import 'package:actify/src/utils/instances.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'firebase_options.dart';

bool newVersion = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('leads_db');
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  PlatformDispatcher.instance.onError = (error, stack) {
    log("Platform Error $error, Stacktrace $stack");
    return true;
  };
  await dotenv.load(fileName: ".env");

  final prefs = await SharedPreferences.getInstance();
  newVersion = prefs.getBool("19") ?? true;
  if (newVersion) {
    auth.signOut();
    prefs.setBool("19", false);
  }

  runApp(ProviderScope(
      child: MyApp(
        navigatorKey: navigatorKey,
      )));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      navigatorKey: navigatorKey,
      title: 'Actify Leads',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      themeMode: ThemeMode.light,
      navigatorObservers: <NavigatorObserver>[observer],
      home: const SplashScreen(),
    );
  }
}
