import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';

class Utils {
  static final storage = FlutterSecureStorage();

  //VALIDAR TIEMPO Y TOKEN DE STOREGA
  static Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'token');
    final fechaIngresoStr = await storage.read(key: 'fechaIngreso');

    if (token != null && fechaIngresoStr != null) {
      final now = DateTime.now();
      final fechaIngreso = DateTime.parse(fechaIngresoStr);

      final difference = now.difference(fechaIngreso);

      if (difference.inHours < 24) {
        return true;
      }
    }

    return false;
  }

  //VALIDAR PERMISOS
  static Future<String> atributionsUser() async {
    String atribuciones = await storage.read(key: 'atribuciones') ?? '';
    return atribuciones;
  }

  //MENSAJES DE ERROR
  static dynamic errorMessage(
      BuildContext context, String title, String message) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: title,
      text: message,
      confirmBtnText: "Aceptar",
    );
  }

  //MENSAJES DE CONFIRMACIÓN
  static dynamic confirmMessage(BuildContext context, String title,
      String message, Function onConfirmBtnTap) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      title: title,
      text: message,
      confirmBtnText: "Aceptar",
      cancelBtnText: "Cancelar",
      showCancelBtn: true,
      onConfirmBtnTap: () => onConfirmBtnTap,
    );
  }

  //MOSTRAR LOADING
  static dynamic showLoading(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: LoadingAnimationWidget.inkDrop(
              color: Colors.white,
              size: 100,
            ),
          );
        });
  }

  //VALIDAR ELEMENTOS DE UN MAPA
  static bool validateEmptyField(Map<String, String> formValues) {
    bool allFieldsFilled = true;
    formValues.forEach((key, value) {
      if (value.isEmpty || value.toString().length <= 0) {
        allFieldsFilled = false;
      }
    });
    return allFieldsFilled;
  }

  //VALIDAR FORMULARIO USUARIO
  static Map<String, dynamic> validateCreateAndUpdateClient(
      Map<String, String> formValues) {
    final Map<String, dynamic> validation = {
      'validate': true,
      'title': '',
      'message': '',
    };

    String title = "";
    String message = "";

    if (!validateEmptyField(formValues)) {
      validation['validate'] = false;
      validation['title'] = '¡Campos Vacíos!';
      validation['message'] =
          '¡Por favor, revise los campos ingresados y vuelva a intentar!';
      return validation;
    }

    if (!validadorDeCedula(formValues['cedula']!)) {
      validation['validate'] = false;
      message = "Por favor revise la cédula, formato incorrecto.\n";
    }

    if (!validarCorreoElectronico(formValues['correo']!)) {
      validation['validate'] = false;
      message = "$message Por favor revise el correo, formato incorrecto.\n";
    }

    if (formValues['telefono']!.length < 10) {
      validation['validate'] = false;
      message = "$message Por favor revise el teléfono, formato incorrecto.\n";
    }

    if (message != "") {
      validation['title'] = '¡Campos Incorrectos!';
      validation['message'] = message;
    }

    return validation;
  }

  //VALIDAR CÉDULA
  static bool validadorDeCedula(String cedula) {
    if (cedula.length != 10) {
      return false;
    }

    final List<int> coefValCedula = [2, 1, 2, 1, 2, 1, 2, 1, 2];
    final int verificador = int.parse(cedula.substring(9, 10));
    int suma = 0;

    for (int i = 0; i < 9; i++) {
      final int digito =
          int.parse(cedula.substring(i, i + 1)) * coefValCedula[i];
      suma += (digito % 10) + (digito ~/ 10);
    }

    if ((suma % 10 == 0 && verificador == 0) ||
        (10 - suma % 10 == verificador)) {
      return true;
    }

    return false;
  }

  //VALIDAR CORREO
  static bool validarCorreoElectronico(String correo) {
    final pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    return regExp.hasMatch(correo);
  }
}
