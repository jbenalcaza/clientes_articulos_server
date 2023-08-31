import 'package:clientes_articulos/router/route_hanndler.dart';
import 'package:clientes_articulos/screens/check_auth_screen.dart';
import 'package:clientes_articulos/screens/home_screen.dart';
import 'package:clientes_articulos/screens/login_screen.dart';
import 'package:clientes_articulos/utils/utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FluroRouters {
  static final FluroRouter router = FluroRouter();

  static void configureRoutes() {
    router.define('/',
        handler: _checkAuthHandler, transitionType: TransitionType.fadeIn);

    router.define('/home',
        handler: RouteHandlers.homeHandler,
        transitionType: TransitionType.fadeIn);

    router.define('/registrar_banner',
        handler: RouteHandlers.registerBanner,
        transitionType: TransitionType.fadeIn);

    router.define('/procesos',
        handler: RouteHandlers.processesHandler,
        transitionType: TransitionType.fadeIn);

    router.define('/buscar_cliente/:redirectToProduct',
        handler: RouteHandlers.productHandler,
        transitionType: TransitionType.fadeIn);

    router.define('/actualizar_cliente/:client',
        handler: RouteHandlers.registerBanner,
        transitionType: TransitionType.fadeIn);

    router.notFoundHandler = _checkAuthHandler;
  }

  static final Handler _checkAuthHandler =
      Handler(handlerFunc: (context, params) => const CheckAuthScreen());
}
