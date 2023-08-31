import 'dart:convert';
import 'dart:io';

import 'package:clientes_articulos/theme/app_theme.dart';
import 'package:clientes_articulos/utils/utils.dart';
import 'package:clientes_articulos/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:toggle_switch/toggle_switch.dart';

class RegisterBannerScreen extends StatefulWidget {
  RegisterBannerScreen({super.key});

  @override
  State<RegisterBannerScreen> createState() => _RegisterBannerScreenState();
}

class _RegisterBannerScreenState extends State<RegisterBannerScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  File? imagePicker;
  String base64ImagePicker = "";
  final Map<String, String> _formValues = {
    'descripcion': '',
    'sucursal': '',
    'cargar': '',
    'urlEntrada': '',
    'urlSalida': '',
    'estado': '',
  };

  Future pickImage() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      File imageTemp = File(image.path);

      Uint8List imageBytes = await imageTemp.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      setState(() {
        imagePicker = imageTemp;
        base64ImagePicker = base64Image;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            title: Text(
              "Registrar Banner",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:
                    size.width > 600 ? size.height * 0.05 : size.height * 0.03,
              ),
            ),
            leading: IconButton(
              icon: const BackButtonIcon(),
              tooltip: "Atrás",
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              },
            ),
            height: size.height),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          //color: Colors.red,
          child: ResponsiveGridList(
            horizontalGridSpacing: 40,
            verticalGridSpacing: 16,
            horizontalGridMargin: 50,
            verticalGridMargin: 50,
            minItemWidth: 350,
            minItemsPerRow: 1,
            maxItemsPerRow: 2,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: base64ImagePicker.isEmpty
                              ? Image.asset(
                                  'assets/images/no_image.png',
                                  fit: BoxFit.cover,
                                )
                              : Image.memory(
                                  base64Decode(base64ImagePicker),
                                  fit: BoxFit.cover,
                                ),
                        )),
                    CustomButtom(
                        onPressed: () {
                          pickImage();
                        },
                        text: "SUBIR ARCHIVO")
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    AuthField(
                        hintText: 'Descripcion',
                        value: 'descripcion',
                        formValues: _formValues),
                    const SizedBox(height: 10),
                    AuthField(
                        hintText: 'Url Entrada',
                        value: 'urlEntrada',
                        formValues: _formValues),
                    const SizedBox(height: 10),
                    AuthField(
                        hintText: 'Url Salida',
                        value: 'urlSalida',
                        formValues: _formValues),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Sucursal",
                            style: TextStyle(
                                fontSize:
                                    size.height * 0.025), // Estilo del título
                          ),
                        ),
                        ToggleSwitch(
                          initialLabelIndex: 1,
                          cornerRadius: 25.0,
                          minWidth: size.width / 2 > 300
                              ? size.width * 0.2
                              : size.width * 0.36,
                          minHeight: 55,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.white,
                          inactiveFgColor: Colors.black,
                          totalSwitches: 2,
                          labels: const ['Económica', 'Medicity'],
                          activeBgColors: const [
                            [
                              AppTheme.buttomAndheadersEco,
                              Color.fromARGB(255, 247, 201, 201)
                            ],
                            [
                              Color.fromARGB(255, 192, 213, 159),
                              AppTheme.buttomAndheadersMedi
                            ]
                          ],
                          onToggle: (index) {
                            _formValues['estado'] =
                                index == 1 ? 'Económica' : 'Medicity';
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Estado",
                            style: TextStyle(
                                fontSize:
                                    size.height * 0.025), // Estilo del título
                          ),
                        ),
                        ToggleSwitch(
                          initialLabelIndex: 1,
                          cornerRadius: 25.0,
                          minWidth: size.width / 2.5 > 300
                              ? size.width * 0.2
                              : size.width * 0.36,
                          minHeight: 55,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.white,
                          inactiveFgColor: Colors.black,
                          totalSwitches: 2,
                          labels: const ['Activo', 'Desactivo'],
                          activeBgColors: const [
                            [Colors.indigo, Color.fromARGB(255, 106, 121, 205)],
                            [Color.fromARGB(255, 255, 208, 139), Colors.orange]
                          ],
                          icons: const [
                            Icons.notifications_active,
                            Icons.notifications_off
                          ],
                          onToggle: (index) {
                            _formValues['estado'] =
                                index == 1 ? 'activo' : 'desactivo';
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: size.width / 2 > 480 ? 300 : 0, top: 20),
                child: CustomButtom(
                    onPressed: () {
                      if (!Utils.validateEmptyField(_formValues)) {
                        Utils.errorMessage(context, '¡Campos Vacíos!',
                            'Por favor revise los campos y vuelva a internta');
                      }
                    },
                    text: 'Guardar'),
              ),
              Container(
                  margin: EdgeInsets.only(
                      right: size.width / 2 > 480 ? 300 : 0, top: 20),
                  child: CustomButtom(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/banners',
                        );
                      },
                      text: 'Buscar'))
            ],
          ),
        ),
      ),
    );
  }
}
