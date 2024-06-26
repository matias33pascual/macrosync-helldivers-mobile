import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macro_sync_helldivers/home_page/providers/exports_providers.dart';
import 'package:macro_sync_helldivers/home_page/screens/home_page.dart';
import 'package:macro_sync_helldivers/mission_page/providers/mission_provider.dart';
import 'package:macro_sync_helldivers/mission_page/screens/mission_page.dart';
import 'package:macro_sync_helldivers/stratagems_page/providers/exports_providers.dart';
import 'package:macro_sync_helldivers/stratagems_page/screens/stratagems_page.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ConnectButtonProvider()),
        ChangeNotifierProvider(create: (_) => StratagemsProvider()),
        ChangeNotifierProvider(create: (_) => TabsMenuProvider()),
        ChangeNotifierProvider(create: (_) => SelectedProvider()),
        ChangeNotifierProvider(create: (_) => MissionProvider()),
      ],
      child: kDebugMode == true
          ? DevicePreview(
              enabled: false,
              tools: const [...DevicePreview.defaultTools],
              builder: (context) => const MyApp(),
            )
          : const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        StratagemsPage.routeName: (context) => const StratagemsPage(),
        MissionPage.routeName: (context) => const MissionPage(),
      },
      title: 'MacroSync',
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
    );
  }
}
