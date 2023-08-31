import 'package:clientes_articulos/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/theme.dart';

class ModuleCard extends StatelessWidget {
  const ModuleCard({
    Key? key,
    required this.urlImage,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final String urlImage;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: size.height > size.width
                    ? size.height * 0.08
                    : size.width * 0.08,
                backgroundColor: themeProvider.getThemeIsMedi()
                    ? AppTheme.buttomAndheadersMedi
                    : Color(0xfff44d4d),
              ),
              Positioned(
                // Establecer left y right como null centrará el Container horizontalmente
                left: null,
                right: null,
                // Establecer top y bottom como null centrará el Container verticalmente
                top: null,
                bottom: null,
                // Ahora, usando solo width y height, el Container estará en el medio
                width: size.height > size.width
                    ? size.height * 0.16
                    : size.width * 0.16,
                height: size.height > size.width
                    ? size.height * 0.16
                    : size.width * 0.16,
                child: Container(
                  height: size.height > size.width
                      ? size.height * 0.08
                      : size.width * 0.08,
                  width: size.height > size.width
                      ? size.height * 0.08
                      : size.width * 0.08,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage(urlImage),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: size.height > size.width
                  ? size.height * 0.02
                  : size.width * 0.02,
            ),
          )
        ],
      ),
    );
  }
}
