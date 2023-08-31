import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ModuleCardLs extends StatelessWidget {
  const ModuleCardLs({
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: size.height * 0.15,
          width: size.width / 1.5,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/bgcardmedi.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.black12,
                    ),
                    Positioned(
                      left: null,
                      right: null,
                      top: null,
                      bottom: null,
                      width: 100,
                      height: 100,
                      child: Container(
                        height: 100,
                        width: 100,
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
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: size.width * 0.025,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(size.width * 0.04),
                child: const Icon(Icons.arrow_forward_ios_rounded),
              )
            ],
          )),
    );
  }
}
