import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownField extends StatefulWidget {
  final String title;
  final List customList;

  const DropdownField({
    Key? key,
    required this.title,
    required this.customList,
  }) : super(key: key);

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: size.width > 600 ? size.width * 0.24 : size.width * 0.8,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              widget.title, // Título del TextFormField
              style: TextStyle(
                  color: const Color(0xff7F7F79),
                  fontSize: size.height * 0.025), // Estilo del título
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(20),
                dropdownColor: Colors.white,
                icon: Icon(
                  Icons
                      .keyboard_arrow_down_outlined, // Ícono de flecha hacia abajo de Flutter
                  size: size.height * 0.05,
                  color: Colors.green, // Color de la flecha desplegable
                ),
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                ),
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text(
                      'SELECCIONE',
                    ),
                  ),
                  ...widget.customList.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  print(value);
                }),
          ),
        ],
      ),
    );
  }
}
