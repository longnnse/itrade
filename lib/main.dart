import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:i_trade/src/presentation/pages/dashboard/dashboard_page.dart';
import 'core/config/module_config.dart';
import 'core/initialize/global_binding.dart';
import 'core/initialize/theme.dart';
import 'core/routers/router_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<ITradeModuleConfig>(ITradeModuleConfig());
  // VIFBase.I.init(
  //   dialog: VIFDialog(),
  //   downloader: VIFDownloader(),
  //   fileHelper: VIFFileHelper(),
  //   uploader: VIFUploader(),
  //   mediaHelper: VIFMediaHelper(),
  //   dateTimePicker: VIFPicker(),
  //   toast: VIFToast(),
  //   loadingIndicator: VIFLoadingIndicator(),
  //   baseWidgets: VIFBaseWidgets(),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
    );
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
    Get.put(DashboardController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DashboardPage(),
    );
  }
}
