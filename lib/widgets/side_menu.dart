import 'package:clientes_articulos/blocs/theme.dart';
import 'package:clientes_articulos/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
    this.isHome = false,
  }) : super(key: key);

  final bool? isHome;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: themeProvider.getThemeIsMedi()
              ? const [
                  AppTheme.buttomAndheadersMedi,
                  // Color.fromARGB(255, 238, 113, 113),
                  Color.fromARGB(255, 151, 200, 73),
                ]
              : const [
                  Color.fromARGB(255, 246, 80, 80),
                  // Color.fromARGB(255, 238, 113, 113),
                  Color.fromARGB(255, 247, 201, 201),
                ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Drawer(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        width: size.width > 600 ? size.width / 4 : size.width / 1.5,
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 120,
              child: DrawerHeader(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: AppTheme.backgroundColorEco,
                  child: Image.asset(
                    "assets/logos/farmaenlace.png",
                  ),
                ),
              )),
            ),
            if (isHome == false)
              DrawerListTile(
                icon: Icons.home,
                title: "Inicio",
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                },
              ),
            FutureBuilder(
              future: Utils.atributionsUser(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: LoadingAnimationWidget.inkDrop(
                      color: Colors.white,
                      size: 60,
                    ),
                  );
                } else {
                  String atribuciones = snapshot.data!;
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      if (atribuciones.contains('administracion'))
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const DrawerSectionTitle(title: "Administración"),
                            DrawerListTile(
                              icon: Icons.photo,
                              title: "Banners",
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  '/registrar_banner',
                                );
                              },
                            ),
                          ],
                        ),
                      if (atribuciones.contains('procesos'))
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const DrawerSectionTitle(title: "Procesos"),
                            DrawerListTile(
                              icon: Icons.supervised_user_circle,
                              title: "FarmaClientes",
                              onTap: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/procesos', (route) => false);
                              },
                            ),
                          ],
                        ),
                    ],
                  );
                }
              },
            ),
            DrawerListTile(
              icon: Icons.login_outlined,
              title: "Cerrar Sesión",
              onTap: () {
                authProvider.logout();
                themeProvider.setTheme(AppTheme.mediTheme);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerSectionTitle extends StatelessWidget {
  const DrawerSectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 0,
      leading: Icon(
        icon,
        color: Colors.white,
        size: 18,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
