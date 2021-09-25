import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:megacloud/pages/authentication_page/one_time_pin_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      child: const MegaCloudApp(),
      supportedLocales: const [Locale('ru', 'KG'), Locale('ky', 'KG')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru', 'KG'),
      saveLocale: false,
      useFallbackTranslations: false,
      startLocale: const Locale('ru', 'KG'),
    ),
  );
}

class MegaCloudApp extends StatelessWidget {
  const MegaCloudApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Megacloud MVP 1.0',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OneTimePinPage(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
