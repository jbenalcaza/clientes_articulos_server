import 'package:clientes_articulos/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../blocs/theme.dart';

class OptionFilter extends StatefulWidget {
  const OptionFilter(
      {super.key, required this.value, required this.formValues});
  final String value;
  final Map<String, String> formValues;
  @override
  State<OptionFilter> createState() => _OptionFilterState();
}

class _OptionFilterState extends State<OptionFilter> {
  // String _selectedValue = '0'; // Mover la inicialización aquí
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio<String>(
            value: '0',
            groupValue: widget.formValues[widget.value],
            activeColor: themeProvider.getThemeIsMedi()
                ? AppTheme.buttomAndheadersMedi
                : AppTheme.buttomAndheadersEco,
            onChanged: (value) {
              setState(() {
                FocusScope.of(context).unfocus();
                widget.formValues[widget.value] = value.toString();
              });
            },
          ),
          const Text(
            'Código',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Radio<String>(
            value: '1',
            groupValue: widget.formValues[widget.value],
            activeColor: themeProvider.getThemeIsMedi()
                ? AppTheme.buttomAndheadersMedi
                : AppTheme.buttomAndheadersEco,
            onChanged: (value) {
              setState(() {
                FocusScope.of(context).unfocus();
                widget.formValues[widget.value] = value.toString();
                FocusScope.of(context).focusInDirection;
                print(widget.formValues[widget.value]);
              });
            },
          ),
          const Text(
            'Descripción',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Radio<String>(
            value: '2',
            activeColor: themeProvider.getThemeIsMedi()
                ? AppTheme.buttomAndheadersMedi
                : AppTheme.buttomAndheadersEco,
            groupValue: widget.formValues[widget.value],
            onChanged: (value) {
              setState(() {
                FocusScope.of(context).unfocus();
                widget.formValues[widget.value] = value.toString();

                print(widget.formValues[widget.value]);
              });
            },
          ),
          const Text(
            'Principio Activo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Radio<String>(
            value: '3',
            activeColor: themeProvider.getThemeIsMedi()
                ? AppTheme.buttomAndheadersMedi
                : AppTheme.buttomAndheadersEco,
            groupValue: widget.formValues[widget.value],
            onChanged: (value) {
              setState(() {
                FocusScope.of(context).unfocus();
                widget.formValues[widget.value] = value.toString();
              });
            },
          ),
          const Text(
            'Código barras',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
