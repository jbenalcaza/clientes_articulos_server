import 'package:animate_do/animate_do.dart';
import 'package:clientes_articulos/utils/utils.dart';
import 'package:clientes_articulos/widgets/product_card_responsive.dart';
import 'package:clientes_articulos/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';

import '../models/clientes_response.dart';
import '../models/productos_response.dart';
import '../providers/user_provider.dart';

class RightInformationUser extends StatefulWidget {
  const RightInformationUser(
      {super.key, required this.userProvider, required this.cliente});
  final UserProvider userProvider;
  final Cliente cliente;

  @override
  State<RightInformationUser> createState() => _RightInformationUserState();
}

class _RightInformationUserState extends State<RightInformationUser> {
  List<Producto> _lstProductos = [];
  bool firstView = true;
  bool loading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final Map<String, String> _formValues = {
    'filterOption': '1',
    'filter': '',
  };
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black12,
      height: double.infinity,
      child: Column(
        children: [
          Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: AuthField(
                          autofocus: true,
                          hintText: "",
                          textInputType:
                              int.parse(_formValues['filterOption']!) == 0
                                  ? TextInputType.number
                                  : TextInputType.text,
                          value: "filter",
                          formValues: _formValues,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.only(top: 30, right: 10),
                        child: CustomButtom(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            Utils.showLoading(context);
                            List<Producto> productos = [];
                            try {
                              if (_formValues['filter'].toString() == "") {
                                Navigator.of(context).pop();
                                setState(() {
                                  Utils.errorMessage(context, "¡Campos Vacíos!",
                                      "Estimado usuario, los campos no deben estar vacíos.");

                                  _lstProductos = [];
                                });
                              } else {
                                productos =
                                    await widget.userProvider.getProducto(
                                  int.parse(
                                      _formValues['filterOption'].toString()),
                                  widget.cliente.nombreCliente,
                                  _formValues['filter'].toString(),
                                );
                                Future.microtask(() {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    _lstProductos = productos;
                                    firstView = false;
                                    loading = false;
                                  });
                                });
                              }
                            } catch (e) {
                              Navigator.of(context).pop();
                              setState(() {
                                alertaError(context, "¡Producto No Encotrado!",
                                    "Estimado usuario, por favor revise la información digitada y vuelva a intentar.");
                                _lstProductos = [];
                              });
                            }
                          },
                          text: "Buscar",
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: OptionFilter(
                        value: 'filterOption', formValues: _formValues)),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Expanded(
            child:
                firstView || _lstProductos.isEmpty || _lstProductos.length == 0
                    ? const Center(
                        child: Text(
                          "ESTIMADO USUARIO CONSULTE UN PRODUCTO",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : loading
                        ? Center(
                            child: LoadingAnimationWidget.newtonCradle(
                              color: Colors.white,
                              size: 200,
                            ),
                          )
                        : FadeInUp(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: ListView.separated(
                                itemCount: _lstProductos.length,
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: false,
                                scrollDirection: Axis.vertical,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: size.height * 0.02,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.04),
                                    child: ProductCardResponsive(
                                      producto: _lstProductos[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> alertaError(
      BuildContext context, String titulo, String mensaje) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: titulo,
      text: mensaje,
      confirmBtnText: "Aceptar",
    );
  }
}
