import 'package:clientes_articulos/blocs/theme.dart';
import 'package:clientes_articulos/theme/app_theme.dart';
import 'package:clientes_articulos/widgets/widgets.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/clientes_response.dart';
import '../models/productos_response.dart';
import '../providers/user_provider.dart';

class ProductsMobileScreen extends StatelessWidget {
  const ProductsMobileScreen({super.key, required this.cliente, required this.lstProductos});
  final Cliente cliente;
  final List<Producto> lstProductos ;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);
    final Color? textColor =
        themeProvider.getThemeIsMedi() ? null : const Color(0xff7F7F79);
    final Color indicatorColor = themeProvider.getThemeIsMedi()
        ? AppTheme.buttomAndheadersMedi
        : AppTheme.buttomAndheadersEco;

    return ContainedTabBarView(
      tabBarProperties: TabBarProperties(indicatorColor: indicatorColor),
      tabs: [
        Text(
          'Beneficios',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Productos',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
      views: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child:
              LeftInformationUser(cliente: cliente, userProvider: userProvider),
        ),
        RightInformationUser(userProvider: userProvider, cliente: cliente)
      ],
      onChange: (index) => print(index),
    );
  }
}
