import 'package:animate_do/animate_do.dart';
import 'package:clientes_articulos/widgets/banner_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../widgets/custom_appbar.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            "BANNERS",
            style: TextStyle(
                fontSize:
                    size.width > 600 ? size.height * 0.06 : size.height * 0.03,
                fontWeight: FontWeight.bold),
          ),
          height: size.height,
        ),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: ResponsiveGridList(
            horizontalGridSpacing: 40,
            verticalGridSpacing: 16,
            horizontalGridMargin: 50,
            verticalGridMargin: 50,
            minItemWidth: 250,
            minItemsPerRow: 2,
            maxItemsPerRow: 4,
            children: [
              ZoomIn(
                child: const BannerCard(
                  imageUrl: "assets/modulos/modulo_clientes.png",
                  description: 'Ejemplo Banners',
                  isActive: false,
                ),
              ),
              ZoomIn(
                child: const BannerCard(
                  imageUrl: "assets/modulos/modulo_clientes.png",
                  description: 'Ejemplo Banners',
                  isActive: false,
                ),
              ),
              ZoomIn(
                child: const BannerCard(
                  imageUrl: "assets/modulos/modulo_clientes.png",
                  description: 'Ejemplo Banners',
                  isActive: false,
                ),
              ),
              ZoomIn(
                child: const BannerCard(
                  imageUrl: "assets/modulos/modulo_clientes.png",
                  description: 'Ejemplo Banners',
                  isActive: false,
                ),
              ),
              ZoomIn(
                child: const BannerCard(
                  imageUrl: "assets/modulos/modulo_clientes.png",
                  description: 'Ejemplo Banners',
                  isActive: true,
                ),
              ),
              ZoomIn(
                child: const BannerCard(
                  imageUrl: "assets/modulos/modulo_clientes.png",
                  description: 'Ejemplo Banners',
                  isActive: true,
                ),
              ),
              ZoomIn(
                child: const BannerCard(
                  imageUrl: "assets/modulos/modulo_clientes.png",
                  description: 'Ejemplo Banners',
                  isActive: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
