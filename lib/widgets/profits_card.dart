import 'package:clientes_articulos/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/theme.dart';

class ProfitsCard extends StatelessWidget {
  ProfitsCard(
      {Key? key,
      required this.title,
      required this.info,
      this.color = Colors.white,
      this.icon = null})
      : super(key: key);

  final String title;
  final IconData? icon;
  final List<dynamic> info;
  Color? color;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(right: size.width * 0.025), //size.width * 0.04),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Card(
          color: color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeProvider.getThemeIsMedi()
                      ? AppTheme.buttomAndheadersMedi
                      : Color(0xff6A6A71),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.height > size.width
                              ? size.height * 0.018
                              : size.height * 0.022,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (icon != null) Icon(icon, color: Colors.white)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: info
                      .map(
                        (item) => Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(width: 1, color: Colors.black12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: const Offset(0, 8),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Text(
                            item.toString().replaceAll('\n', ''),
                            style: TextStyle(
                              color: themeProvider.getThemeIsMedi()
                                  ? Colors.indigo
                                  : null,
                              fontSize: size.width > size.height
                                  ? size.height * 0.02
                                  : size.width * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
