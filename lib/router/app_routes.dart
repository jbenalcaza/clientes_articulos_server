import 'package:clientes_articulos/screens/home_proces_screen.dart';
import 'package:clientes_articulos/screens/search_client_screen.dart';
import 'package:clientes_articulos/screens/update_client_screen.dart';
import 'package:clientes_articulos/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/clientes_response.dart';
import '../screens/banner_register.dart';
import '../screens/banners.dart';
import '../screens/login_screen.dart';
import 'package:clientes_articulos/screens/home_screen.dart';
import 'package:clientes_articulos/screens/check_auth_screen.dart';

import '../screens/products_screen.dart';

class AppRoutes {
  static const storage = const FlutterSecureStorage();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return _fadeRoute(LoginScreen(), '/login');
      case '/home':
        return _fadeRoute(HomeScreen(), '/home');

      case '/registrar_banner':
        return _fadeRoute(RegisterBannerScreen(), '/registrar_banner');

      case '/procesos':
        return _fadeRoute(HomeProcesScreen(), '/procesos');

      case '/banners':
        return _fadeRoute(const BannersScreen(), '/banners');

      case '/buscar_cliente':
        if (settings.arguments is bool) {
          bool redirectToProduct = settings.arguments as bool;
          return _fadeRoute(
              SearchClientScreen(redirectToProduct: redirectToProduct),
              '/buscar_cliente');
        }
        return _fadeRoute(HomeProcesScreen(), '/procesos');
      case '/productos':
        if (settings.arguments is Cliente) {
          Cliente cliente = settings.arguments as Cliente;
          return _fadeRoute(ProductsScreen(cliente: cliente), '/productos');
        }
        return _fadeRoute(
          SearchClientScreen(redirectToProduct: true),
          '/buscar_cliente',
        );
      case '/actualizar_cliente':
        if (settings.arguments is Cliente) {
          Cliente cliente = settings.arguments as Cliente;
          return _fadeRoute(UpdateClienteScreen(cliente: cliente, isNew: false),
              '/productos');
        }
        return _fadeRoute(
          SearchClientScreen(redirectToProduct: false),
          '/buscar_cliente',
        );

      default:
        return _fadeRoute( HomeScreen(), '/home');
    }
  }

  static PageRoute _fadeRoute(
    Widget child,
    String routeName,
  ) {
    return MaterialPageRoute(
      maintainState: true,
      settings: RouteSettings(name: routeName),
      builder: (_) => FutureBuilder<bool>(
        future: Utils.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(
                  radius: 20.0, color: CupertinoColors.activeBlue),
            );
          } else {
            if (snapshot.data == true) {
              return child;
            } else {
              return LoginScreen();
            }
          }
        },
      ),
    );
  }
}
