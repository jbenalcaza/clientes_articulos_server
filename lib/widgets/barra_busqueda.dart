import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/theme.dart';
import '../theme/app_theme.dart';

class BarraBusqueda extends StatefulWidget {
  final Function(String) onFilter;
  final String? hintText;

  const BarraBusqueda({
    Key? key,
    required this.onFilter,
    this.hintText = "",
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BarraBusquedaState createState() => _BarraBusquedaState();
}

class _BarraBusquedaState extends State<BarraBusqueda> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _clearSearch() {
    setState(() {
      _controller.clear();
    });
    widget.onFilter('');
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);
    final Color colorButtom = themeProvider.getThemeIsMedi()
        ? AppTheme.buttomAndheadersMedi
        : AppTheme.buttomAndheadersEco;
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            textInputAction: TextInputAction.search,
            onChanged: widget.onFilter,
            style: TextStyle(
              color: themeProvider.getThemeIsMedi()
                  ? const Color(0xff4066AD)
                  : null,
            ),
            decoration: InputDecoration(
              focusColor: Colors.red,
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Color(0xff6A6A71)),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xff6A6A71),
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 255, 255, 255),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        SizedBox(
          width: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorButtom,
            ),
            child: IconButton(
              icon: const Icon(Icons.clear_all),
              color: Colors.white,
              onPressed: _clearSearch,
            ),
          ),
        ),
      ],
    );
  }
}
