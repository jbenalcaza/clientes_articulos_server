import 'package:clientes_articulos/blocs/theme.dart';
import 'package:clientes_articulos/theme/app_theme.dart';
import 'package:clientes_articulos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/acumulaciones_response.dart';
import '../models/clientes_response.dart';
import '../providers/user_provider.dart';

class ProductsWebScreenExpan extends StatefulWidget {
  const ProductsWebScreenExpan({Key? key, required this.cliente})
      : super(key: key);

  final Cliente cliente;

  @override
  _ProductsWebScreenExpanState createState() => _ProductsWebScreenExpanState();
}

class _ProductsWebScreenExpanState extends State<ProductsWebScreenExpan> {
  bool isLeftSectionHidden = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);

    return GestureDetector(
      onTap: () {
        setState(() {
          isLeftSectionHidden = !isLeftSectionHidden;
        });
      },
      child: Flex(
        direction: Axis.horizontal,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isLeftSectionHidden = !isLeftSectionHidden;
              });
            },
            child: Container(
              child: Icon(
                size: 40,
                isLeftSectionHidden ? Icons.arrow_right : Icons.arrow_left,
                color: themeProvider.getThemeIsMedi()
                    ? AppTheme.buttomAndheadersMedi
                    : AppTheme.buttomAndheadersEco,
              ),
            ),
          ),
          Expanded(
            flex: isLeftSectionHidden ? 0 : 3,
            child: isLeftSectionHidden
                ? const SizedBox.shrink()
                : LeftInformationUser(
                    cliente: widget.cliente, userProvider: userProvider),
          ),
          Expanded(
            flex: isLeftSectionHidden ? 10 : 7,
            child: RightInformationUser(
                userProvider: userProvider, cliente: widget.cliente),
          ),
        ],
      ),
    );
  }
}
