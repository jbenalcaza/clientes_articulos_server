import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clientes_articulos/blocs/theme.dart';
import 'package:clientes_articulos/widgets/widgets.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../widgets/side_menu.dart';

class HomeProcesScreen extends StatelessWidget {
  HomeProcesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);
    final String urlImage = themeProvider.getThemeIsMedi()
        ? "assets/logos/medicity_color.png"
        : "assets/logos/eco_color.png";
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: size.height * 0.15,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Image.asset(
                urlImage,
                width: size.width / 4,
              ),
            ),
          ],
        ),
        drawer: const SideMenu(
          isHome: true,
        ),
        body: Column(
          children: [
            Text(
              "FARMAHELP",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:
                    size.width > 600 ? size.height * 0.06 : size.height * 0.03,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Por favor seleccione una opción:",
              style: TextStyle(
                fontSize:
                    size.width > 600 ? size.height * 0.03 : size.height * 0.015,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: ResponsiveGridList(
                  horizontalGridSpacing: 40,
                  verticalGridSpacing: 16,
                  horizontalGridMargin: 50,
                  verticalGridMargin: 50,
                  minItemWidth: 250,
                  minItemsPerRow: 1,
                  maxItemsPerRow: 2,
                  children: [
                    ZoomIn(
                      child: ModuleCard(
                        urlImage: "assets/modulos/modulo_clientes.png",
                        title: 'Actualización Clientes',
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/buscar_cliente',
                            arguments: false,
                          );
                        },
                      ),
                    ),
                    ZoomIn(
                      child: ModuleCard(
                        urlImage: "assets/modulos/modulo_productos.png",
                        title: 'Clientes y Productos',
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/buscar_cliente',
                            arguments: true,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const Footer(),
      ),
    );
  }
}
