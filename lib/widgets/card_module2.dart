import 'package:clientes_articulos/widgets/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardModule2 extends StatelessWidget {
  const CardModule2({
    Key? key,
    required this.title,
    required this.description,
    required this.urlImage,
  }) : super(key: key);

  final String title;
  final String description;
  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
      child: SizedBox(
        width: 700,
        height: 200,
        child: Stack(
          alignment:
              AlignmentDirectional.topStart, // Alineación arriba a la izquierda
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F7FA),
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 120, 0),
                                child: SelectionArea(
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SelectionArea(
                                child: Text(
                                  description,
                                  style: TextStyle(
                                    color: Color(0x80101213),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                    child: CustomButtom(
                                      onPressed: () {},
                                      text: "Revisar/Entrar",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 8, // Ajustar la posición izquierda
              top: 8, // Ajustar la posición superior
              child: Hero(
                tag: 123,
                transitionOnUserGestures: true,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage(urlImage),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
