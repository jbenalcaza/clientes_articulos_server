import 'package:clientes_articulos/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/theme.dart';

class OptionsProductResponsive extends StatelessWidget {
  const OptionsProductResponsive(
      {super.key,
      required this.onPressedAcumualdos,
      required this.onPressedPromocion,
      required this.onPressedStock});
  final Function() onPressedAcumualdos;
  final Function() onPressedPromocion;
  final Function() onPressedStock;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);
    final Color colorButt = themeProvider.getThemeIsMedi()
        ? AppTheme.buttomAndheadersMedi
        : AppTheme.buttomAndheadersEco;
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: onPressedAcumualdos,
          child: Column(
            children: [
              Icon(
                Icons.add_shopping_cart,
                color: colorButt,
                size: size.width > size.height
                    ? size.height * 0.05
                    : size.width * 0.05,
              ),
              Text(
                "Acumulados",
                style: TextStyle(
                  color: const Color(0xff646464),
                  fontSize: size.width > size.height
                      ? size.height * 0.018
                      : size.width * 0.016,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: onPressedPromocion,
          child: Column(
            children: [
              Icon(
                Icons.date_range_rounded,
                color: colorButt,
                size: size.width > size.height
                    ? size.height * 0.05
                    : size.width * 0.05,
              ),
              Text(
                "Promociones",
                style: TextStyle(
                  color: const Color(0xff646464),
                  fontSize: size.width > size.height
                      ? size.height * 0.018
                      : size.width * 0.016,
                ),
              )
            ],
          ),
        ),
        TextButton(
          onPressed: onPressedStock,
          child: Column(
            children: [
              Icon(
                Icons.store_mall_directory_rounded,
                color: colorButt,
                size: size.width > size.height
                    ? size.height * 0.05
                    : size.width * 0.05,
              ),
              Text(
                "Stock PDV",
                style: TextStyle(
                  color: const Color(0xff646464),
                  fontSize: size.width > size.height
                      ? size.height * 0.018
                      : size.width * 0.016,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
