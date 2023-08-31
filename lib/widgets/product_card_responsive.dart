import 'package:animate_do/animate_do.dart';
import 'package:clientes_articulos/models/producto_matriz_response.dart';
import 'package:clientes_articulos/models/producto_promocion_response.dart';
import 'package:clientes_articulos/models/productos_response.dart';
import 'package:clientes_articulos/providers/user_provider.dart';
import 'package:clientes_articulos/screens/stock_matriz_screen.dart';
import 'package:clientes_articulos/theme/app_theme.dart';
import 'package:clientes_articulos/widgets/image_dialog.dart';
import 'package:clientes_articulos/widgets/options_product_responsive.dart';
import 'package:clientes_articulos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/theme.dart';
import '../models/producto_acumulacion_response.dart';
import '../utils/utils.dart';

class ProductCardResponsive extends StatelessWidget {
  const ProductCardResponsive({super.key, required this.producto});
  final Producto producto;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);
    final Color colorDescription = themeProvider.getThemeIsMedi()
        ? AppTheme.buttomAndheadersMedi
        : AppTheme.buttomAndheadersEco;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: size.width > size.height
                      ? size.height * 0.3
                      : size.width * 0.3,
                  height: size.width > size.height
                      ? size.height * 0.2
                      : size.width * 0.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          barrierDismissible: false,
                          useSafeArea: true,
                          context: context,
                          builder: (context) {
                            return ZoomIn(
                              child: AlertDialog(
                                backgroundColor: Colors.transparent,
                                title: Row(
                                  children: [
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                                content: SizedBox(
                                  width: 650.0,
                                  height: 325.0,
                                  child: ImageDialog(
                                    title: producto.descripcion,
                                    image: producto.imgImagenmediana,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: producto.imgImagenmediana != null
                          ? Image(
                              image: producto.imgImagenmediana!,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(15),
                              child: Image(
                                image: Image.asset(
                                  "assets/images/no_image.png",
                                ).image,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.3,
                    child: Text(
                      producto.descripcion,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width > size.height
                            ? size.height * 0.025
                            : size.width * 0.025,
                        color: themeProvider.getThemeIsMedi()
                            ? AppTheme.buttomAndheadersMedi
                            : const Color(0xff6A6A71),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.31,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              producto.codArticulo,
                              style: TextStyle(
                                color: const Color(0xff646464),
                                fontSize: size.height > size.width
                                    ? size.width * 0.018
                                    : size.height * 0.018,
                              ),
                            ),
                            _StockInformation(
                                colorDescription: colorDescription,
                                size: size,
                                cantidad: producto.entero.toString(),
                                title: "Enteros"),
                            _StockInformation(
                                colorDescription: colorDescription,
                                size: size,
                                cantidad: producto.fraccion.toString(),
                                title: "Fracciones"),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Column(
                          children: [
                            Text(
                              "\$${producto.pvp.toStringAsFixed(2)}(antes)",
                              style: TextStyle(
                                  fontSize: size.height > size.width
                                      ? size.width * 0.02
                                      : size.height * 0.022,
                                  decoration: TextDecoration.lineThrough,
                                  color: const Color(0xffA2A0A0)),
                            ),
                            Text(
                              "\$${producto.pvc.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: size.height > size.width
                                      ? size.width * 0.024
                                      : size.height * 0.024,
                                  fontWeight: FontWeight.bold,
                                  color: colorDescription),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
              OptionsProductResponsive(
                onPressedAcumualdos: () async {
                  Utils.showLoading(context);
                  ProductoAcumulacion productoAcumulacion = await userProvider
                      .getAcumulacionByIdProducto(producto.codArticulo);

                  Future.microtask(() {
                    Navigator.of(context).pop();
                    showDialog(
                      useSafeArea: true,
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return ZoomIn(
                          child: AlertDialog(
                            backgroundColor: Colors.transparent,
                            title: Row(
                              children: [
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                            content: SizedBox(
                              width: 500.0,
                              height: 250.0,
                              child: ProfitsCard(
                                icon: Icons.add_shopping_cart,
                                title: "PRODUCTOS ACUMULADOS",
                                info: [
                                  productoAcumulacion.informativoDobleMonitor !=
                                          "N/A"
                                      ? productoAcumulacion
                                          .informativoDobleMonitor
                                      : "El producto no participa en ninguna acumulación."
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  });
                },
                onPressedPromocion: () async {
                  Utils.showLoading(context);
                  ProductoPromocion productoPromocion = await userProvider
                      .getPromocionByIdProducto(producto.codArticulo);

                  Future.microtask(() {
                    Navigator.of(context).pop();
                    showDialog(
                      barrierDismissible: false,
                      useSafeArea: true,
                      context: context,
                      builder: (context) {
                        return ZoomIn(
                          child: AlertDialog(
                            backgroundColor: Colors.transparent,
                            title: Row(
                              children: [
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                            content: SizedBox(
                              width: 500.0,
                              height: 250.0,
                              child: ProfitsCard(
                                icon: Icons.percent,
                                title: "PROMOCIONES VIGENTES",
                                info: [
                                  productoPromocion.sugerencia != "N/A"
                                      ? productoPromocion.sugerencia
                                      : "El producto no participa en ninguna promoción vigente."
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  });
                },
                onPressedStock: () async {
                  Utils.showLoading(context);
                  List<Farmacia> lstFarmacias = await userProvider
                      .getFarmaciaStockByIdProducto(producto.codArticulo);
                  Future.microtask(() {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StockMatrizScreen(
                          lstFarmacias: lstFarmacias,
                          nombreProducto: producto.descripcion,
                        ),
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StockInformation extends StatelessWidget {
  const _StockInformation({
    super.key,
    required this.colorDescription,
    required this.size,
    required this.cantidad,
    required this.title,
  });

  final Color colorDescription;
  final Size size;
  final String cantidad;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorDescription,
            fontSize: size.height > size.width
                ? size.width * 0.018
                : size.height * 0.018,
          ),
        ),
        Text(
          " $cantidad",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color(0xff646464),
            fontSize: size.height > size.width
                ? size.width * 0.018
                : size.height * 0.018,
          ),
        ),
      ],
    );
  }
}
