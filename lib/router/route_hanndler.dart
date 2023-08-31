import 'package:clientes_articulos/models/clientes_response.dart';
import 'package:clientes_articulos/providers/user_provider.dart';
import 'package:clientes_articulos/screens/banner_register.dart';
import 'package:clientes_articulos/screens/home_proces_screen.dart';
import 'package:clientes_articulos/screens/home_screen.dart';
import 'package:clientes_articulos/screens/products_screen.dart';
import 'package:clientes_articulos/screens/update_client_screen.dart';
import 'package:clientes_articulos/utils/utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/login_screen.dart';
import '../screens/search_client_screen.dart';

class RouteHandlers {
  static Handler homeHandler = Handler(handlerFunc: (context, params) {
    return _fadeRoute(context!, HomeScreen());
  });

  static Handler registerBanner = Handler(handlerFunc: (context, params) {
    return _fadeRoute(context!, RegisterBannerScreen());
  });

  static Handler processesHandler = Handler(handlerFunc: (context, params) {
    return _fadeRoute(context!, HomeProcesScreen());
  });

  static Handler productHandler = Handler(handlerFunc: (context, params) {
    print(params['redirectToProduct']);
    final redirectToProduct = params['redirectToProduct']?.first;

    if (redirectToProduct == 'true') {
      return _fadeRoute(
        context!,
        SearchClientScreen(
          redirectToProduct: true,
        ),
      );
    } else {
      return _fadeRoute(context!, HomeProcesScreen());
    }
  });

  static Handler clientUpdateHandler = Handler(handlerFunc: (context, params) {
    String identificationClient = params['identificationClient']!.first;

    return _fadeRoute(context!, HomeProcesScreen());
  });

  //VERIFICADOR DE AUTENTICACIÓN
  static Widget _fadeRoute(BuildContext context, Widget child) {
    return FutureBuilder<bool>(
      future: Utils.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(
              radius: 20.0,
              color: CupertinoColors.activeBlue,
            ),
          );
        } else {
          if (snapshot.data == true) {
            return child;
          } else {
            return LoginScreen();
          }
        }
      },
    );
  }
}
