import 'package:clientes_articulos/screens/product_screen_expan.dart';

import '../models/productos_response.dart';
import '../widgets/side_menu.dart';
import 'package:flutter/material.dart';
import '../models/clientes_response.dart';
import 'package:clientes_articulos/widgets/widgets.dart';
import 'package:clientes_articulos/screens/products_web_screen.dart';
import 'package:clientes_articulos/screens/products_mobile.screen.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key, required this.cliente});
  final Cliente cliente;
  List<Producto> _consultaProductos = [];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          
          leading: IconButton(
            icon: const BackButtonIcon(),
            
            tooltip: "Atrás",
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/buscar_cliente',
                arguments: true,
              );
            },
          ),
          
          title: Text(
            "PRODUCTOS",
            style: TextStyle(
                fontSize:
                    size.width > 600 ? size.height * 0.04 : size.height * 0.02,
                fontWeight: FontWeight.bold),
          ),
          height: size.height,
        ),
        drawer: const SideMenu(),
        body: size.width > 800
            ? ProductsWebScreenExpan(
                cliente: cliente,
              )
            : ProductsMobileScreen(
                cliente: cliente, lstProductos: _consultaProductos),
      ),
    );
  }
}
