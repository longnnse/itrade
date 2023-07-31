import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:i_trade/common/utils/FirebaseMessagingHandler.dart';
import 'package:i_trade/src/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:i_trade/src/presentation/pages/dashboard/dashboard_page.dart';
import 'package:i_trade/src/presentation/pages/login/login_controller.dart';
import 'package:i_trade/src/presentation/pages/login/login_page.dart';
import 'core/config/module_config.dart';
import 'core/initialize/global_binding.dart';
import 'core/initialize/theme.dart';
import 'core/routers/router_config.dart';
import 'core/utils/app_settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<ITradeModuleConfig>(ITradeModuleConfig());
  await AppSettings.innitAppSetting();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  firebaseChatInit().whenComplete(() => FirebaseMessagingHandler.config());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        // designSize: const Size(360, 780),
        builder: (context, child) => GetMaterialApp(
              title: 'ITrade',
              theme: CoreTheme.lightTheme,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              getPages: ITradeRouterConfigs.routes,
              initialBinding: ITradeGlobalBinding(),
              home: const MyHomePage(),
              builder: EasyLoading.init(),
            ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PressPage();
  }
}

class PressPage extends StatefulWidget {
  const PressPage({super.key});

  @override
  State<PressPage> createState() => _PressPageState();
}

class _PressPageState extends State<PressPage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    Get.put(DashboardController());
    Get.put(LoginController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppSettings.getValue(KeyAppSetting.isDangNhap) == true
          ? const DashboardPage()
          : const LoginPage(),
    );
  }
}

Future firebaseChatInit() async {
  FirebaseMessaging.onBackgroundMessage(
      FirebaseMessagingHandler.firebaseMessagingBackground);
  if (GetPlatform.isAndroid) {
    FirebaseMessagingHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(FirebaseMessagingHandler.channel_call);
    FirebaseMessagingHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(FirebaseMessagingHandler.channel_message);
  }
}
