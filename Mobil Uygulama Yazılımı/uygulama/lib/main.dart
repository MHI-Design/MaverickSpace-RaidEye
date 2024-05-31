import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uygulama/pages/home_page.dart';
import 'package:uygulama/pages/settings_page.dart';

import 'model_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
          return MaterialApp(
            title: 'Raid Eye',
            theme: themeNotifier.isDark
                ? ThemeData(
                    brightness: Brightness.dark,
                    primaryColor: Colors.black54,
                    primaryColorDark: Colors.deepPurpleAccent,
                    //cardColor: Colors.blueGrey,
                  )
                : ThemeData(
                    brightness: Brightness.light,
                    primaryColor: Colors.deepPurpleAccent,
                    primarySwatch: Colors.deepPurple,
                  ),
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
            routes: {
              '/settingspage': (context) => const SettingsPage(),
            },
          );
        },
      ),
    );
  }
}
