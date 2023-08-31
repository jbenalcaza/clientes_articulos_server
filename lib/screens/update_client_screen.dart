import 'package:clientes_articulos/blocs/theme.dart';
import 'package:clientes_articulos/screens/home_screen.dart';
import 'package:clientes_articulos/theme/app_theme.dart';
import 'package:clientes_articulos/utils/utils.dart';
import 'package:clientes_articulos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../models/clientes_response.dart';
import '../providers/user_provider.dart';

class UpdateClienteScreen extends StatefulWidget {
  UpdateClienteScreen({Key? key, required this.cliente, required this.isNew})
      : super(key: key);
  final Cliente cliente;
  final bool isNew;

  @override
  State<UpdateClienteScreen> createState() => _UpdateClienteScreenState();
}

class _UpdateClienteScreenState extends State<UpdateClienteScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final Map<String, String> _formValues = {
    'cedula': '',
    'correo': '',
    'telefono': '',
    'tipocliente': '',
    'nombreCliente': '',
  };

  //Inicializa el estado
  @override
  void initState() {
    _formValues['correo'] = widget.cliente.email;
    _formValues['telefono'] = widget.cliente.telefono;
    _formValues['cedula'] = widget.cliente.numeroDocumento.toString();
    _formValues['nombreCliente'] = widget.cliente.nombreCliente;
    _formValues['tipocliente'] = widget.cliente.tipoIdcliente;
    print(widget.cliente.toJson());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print(widget.cliente.toJson());
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leading: IconButton(
            icon: const BackButtonIcon(),
            tooltip: "Atrás",
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/buscar_cliente',
                arguments: false,
              );
            },
          ),
          height: size.height,
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Center(
            child: Column(
              children: [
                Text(
                  'ACTUALIZACIÓN DATOS CLIENTE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.height > size.width
                        ? size.height * 0.02
                        : size.height * 0.04,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 40),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                if (widget.isNew)
                                  AuthField(
                                    initValue: widget.cliente.numeroDocumento,
                                    hintText: 'Cédula/Ruc/Pasaporte',
                                    value: 'cedula',
                                    formValues: _formValues,
                                    textInputType: TextInputType.number,
                                  ),
                                const SizedBox(height: 15),
                                if (widget.isNew)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio<String>(
                                        value: 'CR',
                                        groupValue: _formValues['tipo'],
                                        activeColor:
                                            themeProvider.getThemeIsMedi()
                                                ? AppTheme.buttomAndheadersMedi
                                                : AppTheme.buttomAndheadersEco,
                                        onChanged: (value) {
                                          setState(() {
                                            FocusScope.of(context).unfocus();
                                            _formValues['tipo'] =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      const Text(
                                        'Cédula',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Radio<String>(
                                        value: 'RC',
                                        groupValue: _formValues['tipo'],
                                        activeColor:
                                            themeProvider.getThemeIsMedi()
                                                ? AppTheme.buttomAndheadersMedi
                                                : AppTheme.buttomAndheadersEco,
                                        onChanged: (value) {
                                          setState(() {
                                            _formValues['tipo'] =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      const Text(
                                        'RUC',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Radio<String>(
                                        value: 'PR',
                                        activeColor:
                                            themeProvider.getThemeIsMedi()
                                                ? AppTheme.buttomAndheadersMedi
                                                : AppTheme.buttomAndheadersEco,
                                        groupValue: _formValues['tipo'],
                                        onChanged: (value) {
                                          setState(() {
                                            FocusScope.of(context).unfocus();
                                            _formValues['tipo'] =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      const Text(
                                        'Pasaporte',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 15),
                                AuthField(
                                  initValue: widget.cliente.nombreCliente,
                                  hintText: 'Nombres',
                                  value: 'nombreCliente',
                                  formValues: _formValues,
                                ),
                                const SizedBox(height: 15),
                                AuthField(
                                  initValue: widget.cliente.email,
                                  hintText: 'Correo',
                                  value: 'correo',
                                  formValues: _formValues,
                                  textInputType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 15),
                                AuthField(
                                  initValue: widget.cliente.telefono,
                                  hintText: 'Teléfono',
                                  value: 'telefono',
                                  formValues: _formValues,
                                  textInputType: TextInputType.number,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                CustomButtom(
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();
                                      try {
                                        if (widget.isNew) {
                                          _formValues['tipocliente'] = "C";
                                        }

                                        Map<String, dynamic> validation =
                                            Utils.validateCreateAndUpdateClient(
                                                _formValues);

                                        if (validation['validate']) {
                                          await userProvider
                                              .putClienteInfo(_formValues);
                                          Future.microtask(() {
                                            successMessage(
                                                context,
                                                widget.isNew
                                                    ? "¡Cliente Registrado!"
                                                    : "¡Cliente Actualizado!",
                                                widget.isNew
                                                    ? "La información del cliente ${_formValues['nombreCliente'].toString().toUpperCase()} se ha registrado correctamente."
                                                    : "La información del cliente ${_formValues['nombreCliente'].toString().toUpperCase()} se ha actualizado correctamente.");
                                          });
                                        } else {
                                          Utils.errorMessage(
                                              context,
                                              validation['title'],
                                              validation['message']);
                                        }
                                      } catch (e) {
                                        Utils.errorMessage(
                                            context,
                                            "¡Ha ocurrido inesperado con el envío de datos!",
                                            'Por favor, vuelva a interntarlo en unos segundos');
                                      }
                                    },
                                    text: widget.isNew
                                        ? "REGISTRAR"
                                        : "ACTUALIZAR")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const Footer(),
      ),
    );
  }

  Future<dynamic> successMessage(
      BuildContext context, String title, String message) {
    return QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: title,
        text: message,
        confirmBtnText: "Aceptar",
        onConfirmBtnTap: () {
          Navigator.of(context).pushNamed(
            '/buscar_cliente',
            arguments: false,
          );
        });
  }
}
