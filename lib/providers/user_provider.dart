import 'dart:convert';
import '../models/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/producto_acumulacion_response.dart';
import 'package:clientes_articulos/models/clientes_response.dart';
import 'package:clientes_articulos/models/productos_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:clientes_articulos/models/acumulaciones_response.dart';
import 'package:clientes_articulos/models/producto_matriz_response.dart';
import 'package:clientes_articulos/models/producto_promocion_response.dart';
import 'package:clientes_articulos/models/promocion_clientes_response.dart';

class UserProvider with ChangeNotifier {
  final storage = const FlutterSecureStorage();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<String> _postJsonDataToken(
      String segment, Map<String, dynamic> body) async {
    var url = Uri.parse("${Enviroment.apiUrl}$segment");
    String token = await storage.read(key: 'token') ?? '';

    Map<String, String> customHeaders = {'Authorization': token};
    headers.addAll(customHeaders);

    final response =
        await http.post(url, headers: headers, body: jsonEncode([body]));
    return response.body;
  }

  //Obtener Datos Clientes
  Future<List<Cliente>> getClientsInfo(String filter) async {
    String segment = "getDatosCliente";
    String ipFarmacia = "192.168.237.190";
    Map<String, dynamic> bodyRequest = {
      'Cedula': "",
      "nombreCliente": "",
      'ipFarmacia': ipFarmacia,
    };
    if (int.tryParse(filter) == null) {
      bodyRequest['nombreCliente'] = filter;
    } else {
      bodyRequest['Cedula'] = filter;
    }
    final jsonData = await _postJsonDataToken(segment, bodyRequest);
    final parsedJson = json.decode(jsonData);

    List<Cliente> clientes = [];
    try {
      clientes = ClienteResponse.getClienteFromJsonDecode(parsedJson);
    } catch (e) {
      print(e);
    }
    return clientes;
  }

  //Actualizar Datos Clientes
  Future<void> putClienteInfo(Map<String, dynamic> formValues) async {
    String segment = "updateDatosCliente";
    String usuario = 'jbenalcaza';
    String ipFarmacia = "192.168.237.190";
    String ipDispositivo =
        "192.168.237.190"; // await storage.read(key: 'ipLocal') ?? '';

    Map<String, dynamic> bodyRequest = {
      'usuario': usuario,
      'ipFarmacia': ipFarmacia,
      'ipregistro': ipDispositivo,
      'nombreNavegador': 'Google Chrome'
    };
    bodyRequest.addAll(formValues);
    try {
      final jsonData = await _postJsonDataToken(segment, bodyRequest);
      final parsedJson = json.decode(jsonData);
    } catch (e) {
      print(e);
    }
  }

  //Obtener Productos acumulados del Cliente
  Future<List<Acumulacion>> getClienteAcumulados(
      String cedulaCliente, String nombreCliente) async {
    String segment = "getDatosAcumulacionCliente";
    String ipFarmacia = "192.168.237.190";
    String oficina = "190";
    Map<String, dynamic> bodyRequest = {
      'Cedula': cedulaCliente,
      'Oficina': oficina,
      'nombreCliente': nombreCliente,
      'ipFarmacia': ipFarmacia,
      'Usuario': 'jbenalcaza',
    };
    final jsonData = await _postJsonDataToken(segment, bodyRequest);
    final parsedJson = json.decode(jsonData);
    List<Acumulacion> acumulaciones = [];
    try {
      if (nombreCliente != "INVITADO") {
        acumulaciones =
            AcumulacionesResponse.getAcumulacionFromJsonDecode(parsedJson);
      }
    } catch (e) {
      print(e);
    }
    return acumulaciones;
  }

  //Promocion Cliente

  Future<Promocion> getPromocionByCliente(String cedulaCliente) async {
    String segment = "getDatosBeneficioCliente";
    String ipFarmacia = "192.168.237.190";
    String oficina = "190";

    Map<String, dynamic> bodyRequest = {
      "Cedula": cedulaCliente,
      "Oficina": oficina,
      "ipFarmacia": ipFarmacia,
      "Usuario": "jbenalcaza"
    };

    final jsonData = await _postJsonDataToken(segment, bodyRequest);
    final parsedJson = json.decode(jsonData);

    Promocion promocionCliente =
        PromocionesClientesResponse.getPromocionFromJsonDecode(parsedJson);

    return promocionCliente;
  }

  //Obtener Productos
  Future<List<Producto>> getProducto(
      int filterType, String nombreCliente, String filter) async {
    String segment = "getDatosProducto";
    String ipFarmacia = "192.168.237.190";
    String oficina = "190";

    List<String> opciones = [
      'cod_articulo',
      'Nombre',
      'NombrePA',
      'cod_barra',
    ];
    Map<String, dynamic> bodyRequest = {
      'Oficina': oficina,
      'nombreCliente': nombreCliente,
      'ipFarmacia': ipFarmacia,
      'Usuario': 'jbenalcaza',
      'descontinuado': 0,
      'cod_barra': "",
      'Nombre': "",
      'NombrePA': "",
      'cod_articulo': ""
    };
    bodyRequest[opciones[filterType]] = filter;
    final jsonData = await _postJsonDataToken(segment, bodyRequest);
    final parsedJson = json.decode(jsonData);

    List<Producto> productos = [];
    try {
      if (parsedJson[0]['respuesta'] != null) {
        // final errorMessage = parsedJson[0]['respuesta']['message'];
        throw 'EL PRODUCTO BUSCADO NO SE HA ENCONTRADO';
      } else {
        productos = ProductosResponse.getProductosFromJsonDecode(parsedJson);
      }
    } catch (e) {
      throw Exception('¡No se han encotrado objetos con esa caraterísicas!');
    }

    return productos;
  }

  //Acumulación por producto

  Future<ProductoAcumulacion> getAcumulacionByIdProducto(
      String codArticulo) async {
    String segment = "getDatosMedFrecArticulo";
    String ipFarmacia = "192.168.237.190";
    String oficina = "190";

    Map<String, dynamic> bodyRequest = {
      "cod_articulo": codArticulo,
      "Oficina": oficina,
      "ipFarmacia": ipFarmacia,
      "Usuario": "jbenalcaza"
    };

    final jsonData = await _postJsonDataToken(segment, bodyRequest);
    final parsedJson = json.decode(jsonData);

    ProductoAcumulacion productoAcumulacion =
        ProductoAcumulacionResponse.getProductoAcumulacionFromJsonDecode(
            parsedJson);

    return productoAcumulacion;
  }

  //Promocion Producto

  Future<ProductoPromocion> getPromocionByIdProducto(String codArticulo) async {
    String segment = "getDatosPromoArticulo";
    String ipFarmacia = "192.168.237.190";
    String oficina = "190";

    Map<String, dynamic> bodyRequest = {
      "cod_articulo": codArticulo,
      "Oficina": oficina,
      "ipFarmacia": ipFarmacia,
      "Usuario": "jbenalcaza"
    };

    final jsonData = await _postJsonDataToken(segment, bodyRequest);
    final parsedJson = json.decode(jsonData);

    ProductoPromocion productoPromocion =
        ProductoPromocionResponse.getProductoAcumulacionFromJsonDecode(
            parsedJson);

    return productoPromocion;
  }

  //Promocion Producto

  Future<List<Farmacia>> getFarmaciaStockByIdProducto(
      String codArticulo) async {
    String segment = "getDatosStockMatriz";
    String oficina = "190";

    Map<String, dynamic> bodyRequest = {
      "cod_articulo": codArticulo,
      "Oficina": oficina,
    };

    final jsonData = await _postJsonDataToken(segment, bodyRequest);
    final parsedJson = json.decode(jsonData);

    List<Farmacia> farmaciasStock =
        ProductoMatrizResponse.getFarmaciaFromJsonDecode(parsedJson);

    return farmaciasStock;
  }
}
