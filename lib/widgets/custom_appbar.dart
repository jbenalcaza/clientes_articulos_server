import 'package:clientes_articulos/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.height,
      this.title = null,
      this.leading = null});
  final Text? title;
  final double height;
  final Widget? leading;

  @override
  Size get preferredSize => Size.fromHeight(height * 0.08);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);
    final String urlImage = themeProvider.getThemeIsMedi()
        ? "assets/logos/medicity_color.png"
        : "assets/logos/eco_color.png";
    return AppBar(
      elevation: 0,
      toolbarHeight: height * 0.09,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: title,
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: leading,
      actions: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.only(right: 10),
          child: Image.asset(
            urlImage,
            width: size.width / 4,
          ),
        ),
      ],
    );
  }
}
