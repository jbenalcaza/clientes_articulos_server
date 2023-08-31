import 'package:clientes_articulos/screens/home_screen.dart';
import 'package:clientes_articulos/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authProvider.readToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Text('Espere...');
            }

            Future.microtask(() {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        snapshot.data == '' ? LoginScreen() : HomeScreen(),
                    transitionDuration: const Duration(seconds: 0),
                  ));
            });
            return Container();
          },
        ),
      ),
    );
  }
}
