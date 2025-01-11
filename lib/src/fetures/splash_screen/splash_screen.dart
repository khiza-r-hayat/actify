import 'package:actify/src/constants/colors.dart';
import 'package:actify/src/services/pantheon_service/acess_service.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../constants/strings.dart';
import '../../models/user/user.dart';
import '../authentication/data/user_data_state_provider.dart';
import '../authentication/presentation/view/login_screen.dart';
import '../home/presentation/view/home_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

PackageInfo? packageInfo;

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? userId;
  getPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      getPackageInfo();
      Future(checkUserSession);
    });
  }

  checkUserSession() async {
    final dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final prefs = await _prefs;
    final date = prefs.getString(Strings.lastLoginDate);
    if (date == dateNow) {
      userId = prefs.getString(Strings.userId);
      final user = User(
          id: userId,
          role: prefs.getString(Strings.userRole),
          csrf: prefs.getString(Strings.csrf),
          jwt: prefs.getString(Strings.jwt),
        logout: prefs.getString(Strings.logoutToken),
          loginTime: DateFormat('h:mm a').format(DateTime.now())
      );
      ref.read(userStateProvider.notifier).setUser(user);
    } else {
      await AccessService.logoutSession(
          prefs.getString(Strings.csrf), prefs.getString(Strings.logoutToken));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
        duration: const Duration(seconds: 2),
        setStateTimer: const Duration(milliseconds: 500),
        backgroundColor: primaryColor,
        onInit: () {
          checkUserSession();
          // auth.currentUser != null
          //     ? ref.read(fetchUserDataProvider(auth.currentUser!.email!))
          //     : null;
        },
        onEnd: () {
          debugPrint("On End");
        },
        childWidget: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset("assets/images/logo_splash.png"),
        ),
        onAnimationEnd: () => debugPrint("On Fade In End"),
        nextScreen: _getLandingPage());
  }

  Widget _getLandingPage() {
    return userId != null ? const HomeScreen() : const LoginScreen();
    // return StreamBuilder<User?>(
    //   stream: auth.authStateChanges(),
    //   builder: (BuildContext context, snapshot) {
    //     if (snapshot.hasData) {
    //       return const HomeScreen();
    //     } else {
    //       // return const LoginScreen();
    //       return const LoginScreen();
    //     }
    //   },
    // );
  }
}
