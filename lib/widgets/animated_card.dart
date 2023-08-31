import 'package:clientes_articulos/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AnimatedCard extends StatefulWidget {
  const AnimatedCard({super.key, required this.title, required this.urlImage});
  final String title;
  final String urlImage;

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 246, 80, 80),
              // Color.fromARGB(255, 238, 113, 113),
              Color.fromARGB(255, 247, 201, 201),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Center(
              child: Image.asset(
                widget.urlImage, // Coloca la ruta de tu imagen aquí
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 10),
            if (isExpanded)
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/buscar_cliente',
                        arguments: false,
                      );
                    },
                    child: const ListTile(
                      leading: Icon(Icons.offline_bolt),
                      title: Text('Actualización Datos Clientes'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/buscar_cliente',
                        arguments: true,
                      );
                    },
                    child: const ListTile(
                      leading: Icon(Icons.local_activity),
                      title: Text('Clientes y Productos'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/registrar_banner',
                        arguments: true,
                      );
                    },
                    child: const ListTile(
                      leading: Icon(Icons.local_activity),
                      title: Text('Registro Banners'),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down),
                  Text(isExpanded ? 'Cerrar' : 'Expandir'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
