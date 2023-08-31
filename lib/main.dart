import 'package:clientes_articulos/blocs/theme.dart';
import 'package:clientes_articulos/providers/user_provider.dart';
import 'package:clientes_articulos/router/app_routes.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'models/enviroment.dart';
import 'providers/auth_provider.dart';

void main() async {
  // ------------------Enviroment------------------------//

  await dotenv.load(fileName: Enviroment.fileName);
  final prefs = await SharedPreferences.getInstance();

  // ------------------ROUTES------------------------//
  //FluroRouters.configureRoutes();
  usePathUrlStrategy();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeChanger>(
      future: ThemeChanger.create(prefs),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AuthProvider()),
              ChangeNotifierProvider(create: (_) => UserProvider()),
              ChangeNotifierProvider.value(value: snapshot.data!),
            ],
            child: AppWithTheme(),
          );
        } else {
          return const Center(
              child: Center(
            child: CupertinoActivityIndicator(
                radius: 20.0, color: CupertinoColors.activeBlue),
          ));
        }
      },
    );
  }
}

class AppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FarmaHelp',
      theme: theme.getTheme(), // AppTheme
      initialRoute: '/checkAuth',
      onGenerateRoute: AppRoutes.generateRoute,
      //onGenerateRoute: FluroRouters.router.generator,
    );
  }
}
