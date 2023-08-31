import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import '../models/clientes_response.dart';
import '../providers/user_provider.dart';
import 'clients_screen.dart';
import '../widgets/widgets.dart';
import '../widgets/side_menu.dart';
import 'package:clientes_articulos/screens/products_screen.dart';
import 'package:clientes_articulos/screens/update_client_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SearchClientScreen extends StatelessWidget {
  SearchClientScreen({Key? key, required this.redirectToProduct})
      : super(key: key);
  final bool redirectToProduct;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final Map<String, String> _formValues = {
    'cedula': '',
  };
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            "Buscar Cliente",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize:
                  size.width > 600 ? size.height * 0.06 : size.height * 0.03,
            ),
          ),
          leading: IconButton(
            icon: const BackButtonIcon(),
            tooltip: "Atrás",
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/procesos', (route) => false);
            },
          ),
          height: size.height,
        ),
        drawer: const SideMenu(),
        body: FadeIn(
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Para continuar ingrese documento de indentidad o nombres",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.height > size.width
                                  ? size.height * 0.015
                                  : size.width * 0.018),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AuthField(
                            hintText: "Cédula/Nombre",
                            value: "cedula",
                            formValues: _formValues,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      CustomButtom(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (_formValues['cedula'].toString() == "") {
                            empyFieldsValidate(context);
                          } else {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return Center(
                                    child: LoadingAnimationWidget.newtonCradle(
                                      color: Colors.white,
                                      size: 200,
                                    ),
                                  );
                                });

                            List<Cliente> clientes =
                                await userProvider.getClientsInfo(
                                    _formValues['cedula'].toString());

                            Future.microtask(() {
                              Navigator.of(context).pop();
                              if (clientes.length == 1) {
                                if (clientes[0].numeroDocumento == "N/A" ||
                                    clientes.isEmpty) {
                                  //MENSAJE DE ERROR
                                  if (redirectToProduct) {
                                    noUserAlert(context);
                                  } else {
                                    registerNewUserAlert(context);
                                  }
                                } else {
                                  print(clientes[0].toJson());
                                  if (redirectToProduct) {
                                    Navigator.of(context).pushNamed(
                                      '/productos',
                                      arguments: clientes[0],
                                    );
                                  } else {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        settings: const RouteSettings(
                                            name: '/actualizar_cliente'),
                                        builder: (context) =>
                                            UpdateClienteScreen(
                                          cliente: clientes[0],
                                          isNew: false,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              } else {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    settings:
                                        const RouteSettings(name: '/clientes'),
                                    builder: (context) => ClientsScreen(
                                      lstClientes: clientes,
                                      redirectToProduct: redirectToProduct,
                                    ),
                                  ),
                                );
                              }
                            });
                          }
                        },
                        text: "Buscar",
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      if (redirectToProduct)
                        CustomButtom(
                          color: const Color(0xff8D9095),
                          onPressed: () {
                            Cliente cliente = Cliente(
                                tipoIdcliente: "N/A",
                                numeroDocumento: "N/A",
                                nombreCliente: "INVITADO",
                                email: "",
                                telefono: "");
                            Navigator.of(context).pushNamed(
                              '/productos',
                              arguments: cliente,
                            );
                          },
                          text: "Entrar como Invitado",
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> empyFieldsValidate(BuildContext context) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: "!Campo Vacío!",
      text: "Estimado ususario, revise los campos y vuelva a intentar.",
      confirmBtnText: "Aceptar",
      //autoCloseDuration: const Duration(seconds: 4),
    );
  }

  Future<dynamic> noUserAlert(BuildContext context) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      title: "¡Cliente No Encontrado!",
      text:
          "Estimado ususario el cliente no ha sido encontrado, ¿Desea seguir como invitado?",
      confirmBtnText: "Aceptar",
      cancelBtnText: "Cancelar",
      showCancelBtn: true,
      onConfirmBtnTap: () {
        Cliente cliente = Cliente(
            tipoIdcliente: "N/A",
            numeroDocumento: "N/A",
            nombreCliente: "INVITADO",
            email: "",
            telefono: "");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductsScreen(
              cliente: cliente,
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> registerNewUserAlert(BuildContext context) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      title: "¡Cliente No Encontrado!",
      text:
          "Estimado ususario el cliente no ha sido encontrado, ¿Desea registrar como usuario nuevo?",
      confirmBtnText: "Aceptar",
      cancelBtnText: "Cancelar",
      showCancelBtn: true,
      onConfirmBtnTap: () {
        Cliente cliente = Cliente(
            tipoIdcliente: "",
            numeroDocumento: "",
            nombreCliente: "",
            email: "",
            telefono: "");
        Navigator.of(context).push(
          MaterialPageRoute(
            settings: const RouteSettings(name: '/registrar_cliente'),
            builder: (context) =>
                UpdateClienteScreen(cliente: cliente, isNew: true),
          ),
        );
      },
    );
  }
}
