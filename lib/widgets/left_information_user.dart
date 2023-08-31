import 'package:clientes_articulos/models/acumulaciones_response.dart';
import 'package:clientes_articulos/models/clientes_response.dart';
import 'package:clientes_articulos/providers/user_provider.dart';
import 'package:clientes_articulos/theme/app_theme.dart';
import 'package:clientes_articulos/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/promocion_clientes_response.dart';
import '../providers/auth_provider.dart';

class LeftInformationUser extends StatelessWidget {
  const LeftInformationUser(
      {super.key, required this.cliente, required this.userProvider});
  final Cliente cliente;
  final UserProvider userProvider;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final Color profitsCardColor = authProvider.themeIsMedi
        ? AppTheme.backgroundColorMedi
        : AppTheme.backgroundColorEco;

    return FutureBuilder(
        future: Future.wait([
          userProvider.getClienteAcumulados(
              cliente.numeroDocumento, cliente.nombreCliente),
          userProvider.getPromocionByCliente(cliente.numeroDocumento)
        ]),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Acumulacion> lstAcumulacionAPI = snapshot.data[0];
            Promocion promocionAPI = snapshot.data[1];
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: const AssetImage(
                                    'assets/images/user_image.png'),
                                width: size.width * 0.2,
                                height: size.height * 0.2,
                              ),
                              Text(
                                size.width > 920 || size.width < 800
                                    ? cliente.nombreCliente
                                    : "${cliente.nombreCliente.substring(0, 22)}...",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: size.width > size.height
                                        ? size.height * 0.02
                                        : size.width * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "CI: ${cliente.numeroDocumento}",
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ProfitsCard(
                      color: profitsCardColor,
                      title: "PRODUCTOS ACUMULADOS",
                      info: lstAcumulacionAPI.length > 0
                          ? snapshot.data[0]
                              .map((objeto) => objeto.acumulacion)
                              .toList()
                          : ["NO SE ENCONTRARON PRODUCTOS ACUMULADOS"]),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ProfitsCard(
                      color: profitsCardColor,
                      title: "BENEFICIOS DEL CLIENTE",
                      info: [
                        promocionAPI.crmMensaje == "N/A"
                            ? "NO SE ENCONTRARON PROMOCIONES VIGENTES"
                            : promocionAPI.crmMensaje
                      ]),
                ],
              ),
            );
          } else {
            return const Center(
              child: CupertinoActivityIndicator(
                  radius: 20.0, color: CupertinoColors.activeBlue),
            );
          }
        });
  }
}
