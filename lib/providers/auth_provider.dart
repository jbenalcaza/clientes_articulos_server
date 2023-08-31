import 'dart:convert';

import 'package:clientes_articulos/models/producto_matriz_response.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/enviroment.dart';
import '../models/permisos_response.dart';

class AuthProvider with ChangeNotifier {
  bool _themeIsMedi = false;

  bool get themeIsMedi => _themeIsMedi;
  set themeIsMedi(bool value) {
    _themeIsMedi = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  AuthProvider() {
    _initializeAsync();
  }

  Future<void> _initializeAsync() async {
    // _themeIsMedi = await readTheme();
    notifyListeners();
  }

  final storage = const FlutterSecureStorage();

  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<String> _getJsonData(String segment) async {
    var url = Uri.parse("${Enviroment.apiUrl}$segment");
    final response = await http.get(url, headers: headers);
    return response.body;
  }

  Future<void> postLogin(String nombreCorto, String password) async {
    try {
      String segment = "gettoken";
      Map<String, String> headersGet = {
        'user': nombreCorto,
        'app': 'ACIF',
      };
      headers.addAll(headersGet);
      final jsonData = await _getJsonData(segment);
      final parsedJson = json.decode(jsonData);
      Permiso permiso = PermisosResponse.getPermisoFromJsonDecode(parsedJson);

      if (permiso.token != "N/A" || permiso.atribuciones.length > 0) {
        themeIsMedi = true;
        final now = DateTime.now();
        //final ipv4 = await Ipify.ipv4();

        String atribuciones = "";

        permiso.atribuciones.forEach((atribucion) {
          atribuciones = "$atribuciones${atribucion.modulo},";
        });

        await storage.write(key: 'ipLocal', value: '192.168.137.197');
        await storage.write(key: 'token', value: permiso.token);
        await storage.write(key: 'atribuciones', value: atribuciones);
        await storage.write(key: 'fechaIngreso', value: now.toString());

        headers.remove('app');
        headers.remove('user');
      } else {
        throw "Estimado usuario, usted no tiene permisos asignados en la aplicación.";
      }
    } catch (e) {
      throw "Estimado usuario, usted no tiene permisos asignados en la aplicación.";
    }
  }

  Future<void> loginToken() async {
    final tokenTemp = await storage.read(key: 'token') ?? '';
    await storage.write(key: 'token', value: tokenTemp);
  }

  Future logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'ipLocal');
    await storage.delete(key: 'fechaIngreso');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
