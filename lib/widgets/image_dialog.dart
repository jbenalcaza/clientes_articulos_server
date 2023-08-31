import 'package:clientes_articulos/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/theme.dart';

class ImageDialog extends StatelessWidget {
  ImageDialog(
      {Key? key,
      required this.title,
      this.color = Colors.white,
      required this.image})
      : super(key: key);

  final String title;
  final ImageProvider<Object>? image;
  Color? color;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
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
                      : const Color(0xff6A6A71),
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
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontSize: size.height > size.width
                              ? size.height * 0.015
                              : size.width * 0.015,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.image,
                        size: size.height * 0.03,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              // Center the image using an Expanded widget
              Expanded(
                  child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: image != null
                      ? Image(
                          fit: BoxFit.contain, // Use a fitting strategy
                          image: image!,
                        )
                      : Image.asset(
                          "assets/images/no_image.png",
                        ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
