import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      color: Colors.transparent,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.place_outlined),
            onPressed: null,
          ),
          Text(
            'Farmaenalce © ',
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
