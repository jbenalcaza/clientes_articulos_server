import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoImage extends StatelessWidget {
  const InfoImage({super.key, required this.urlImage, required this.title});
  final String urlImage;
  final String title;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width * 0.2,
          height: size.height * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(urlImage),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: size.width * 0.01,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
