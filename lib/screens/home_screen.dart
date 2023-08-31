import 'package:clientes_articulos/models/permisos_response.dart';
import 'package:clientes_articulos/utils/utils.dart';
import 'package:clientes_articulos/widgets/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:clientes_articulos/blocs/theme.dart';
import 'package:clientes_articulos/widgets/widgets.dart';

import '../widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

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
          title: const Text(
            "FARMAHELP",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
        body: const SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text("Por favor acceda al menú para observar las opciones."),
                Image(
                    image:
                        AssetImage('assets/images/output-onlinegiftools.gif')),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const Footer(),
      ),
    );
  }
}
